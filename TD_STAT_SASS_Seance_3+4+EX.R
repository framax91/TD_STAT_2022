### CORRECTION EXERCICE 1 : On a demandé à 4 ménages le revenu du chef de ménage, celui de son conjoint, 
### et le nombre de personnes du ménage
# Ménage 1 : Chef = 1200 ; Conjoint = 1450 ; Nb pers = 4
# Ménage 2 : Chef = 1180 ; Conjoint = 1850 ; Nb pers = 2
# Ménage 3 : Chef = 1750 ; Conjoint = 1690 ; Nb pers = 3
# Ménage 4 : Chef = 2100 ; Conjoint = 0 ; Nb pers = 2

revenu_manages <- data.frame(menage = c(1:4),
                             revenu_chef = c(1200, 1180, 1750, 2100),
                             revenu_conjoint = c(1450, 1850, 1690, 0),
                             membres_menage = c(4, 2, 3, 2))
revenu_manages

revenu_pp <- (revenu_manages$revenu_chef + revenu_manages$revenu_conjoint)/revenu_manages$membres_menage
revenu_pp

revenu_manages_augm <- data.frame(menage = c(1:4),
                                  revenu_chef = c(1200, 1180, 1750, 2100),
                                  revenu_conjoint = c(1450, 1850, 1690, 0),
                                  membres_menage = c(4, 2, 3, 2),
                                  revenu_pp)
View(revenu_manages_augm)


### EXERCICE 2 : Dans l'exercice precedent, calculez le revenu minimum et le revenu maximum parmi ceux du chef de menage :
min(revenu_manages$revenu_chef) 
max(revenu_manages$revenu_chef)
mean(revenu_manages$revenu_chef)
sd(revenu_manages$revenu_chef)


#On nomme les menages en creant un nouveau data frame
revenu_manages_augm_nom <- data.frame(menage = c("menage1", "menage2", "menage3", "menage4"),
                                      revenu_chef = c(1200, 1180, 1750, 2100),
                                      revenu_conjoint = c(1450, 1850, 1690, 0),
                                      membres_menage = c(4, 2, 3, 2),
                                      revenu_pp) #On ajoute la colonne avec le revenu pp
rownames(revenu_manages_augm) <- c("menage1", "menage2", "menage3", "menage4")
revenu_manages_augm

revenu_manages_rac <- data.frame(menage = c("menage1", "menage2", "menage3", "menage4"),
                                 revenu_chef = c(1200, 1180, 1750, 2100),
                                 revenu_conjoint = c(1450, 1850, 1690, 0),
                                 membres_menage = c(4, 2, 3, 2),
                                 revenu_pp) #On a enlevé une colonne
revenu_manages_rac

### EXERCICE 3: ### Recommencer avec les revenus suivants, parmi lesquels l'un des enquétés n'a pas voulu repondre :
# Ménage 1 : Chef = 1200 ; Conjoint = 1450 ; Nb pers = 4
# Ménage 2 : Chef = 1180 ; Conjoint = 1850 ; Nb pers = 2
# Ménage 3 : Chef = 1750 ; Conjoint = 1690 ; Nb pers = 3
# Ménage 4 : Chef = NA ; Conjoint = 0 ; Nb pers = 2
revenu_chef_na <- c(1200, 1180, 1750, NA) #suggestion premier pas


### INSTALLER LES PACKAGES
## Avant de pouvoir proceder a quelque analyse que ce soit, il faut dire a R ou se trouvent les donnees, et charger les extensions necessaires   
library(foreign)
library(questionr)
library(rio)
library(cluster)
library(FactoMineR) #librairie pour les analyses factorielles
library(survey)
library(R2HTML)
library(stats)
library(lmtest) #librairie pour les regressions 
library(TraMineR)
library(xtable)
library(lattice) 
library(nnet) 
library(questionr)
library(GDAtools)
library(missMDA)
library(tables)
library(tidyverse)

#Definition du dossier par defaut avec lequel R va fonctionner. IL faut faire copier l'adresse du dossier dans lequel la base de donnees est presente
#Puis la coller entre les guillemets comme argument de la fonction setwd. 
#Enfin, verifier que les slashs sont dans le bon sens: /
#Pour les macs, commencer par un slash et non par un ~
setwd("ICI VOUS RECOPIER LE CHEMIN (DU DOSSIER OU VOUS VOULES TRAVAILLER. PREFERBLEMENT LE MEME DOSSIER OU EST SAUVEGARDE VOTRE PROJET RSTUDIO")
# Exemple : setwd("setwd("/Volumes/GoogleDrive/Il mio Drive/Backup Hard Disk bianco Set 2020/Francesco/Teaching/Stat Sorbonne 2022/R_Stat_Sorbonne/Stat_Sorbonne")

getwd() 
#permet de voir dans quel dossier de travail/repertoire on est 

EVS <- import("ZA4751_v2-0-0.dta") #Si cela ne marche pas c'est parce que soit vous n'avez pas auvegardé la base de donnee au bon endroit (dans le meme dossier du projet), soit parce que vous n'avez pas le package
EVS <- read.dta("ZA4751_v2-0-0.dta") # en alternative a import
# sinon vous essayez avec le boutton en cliquant avec le bouton gauche sur l'icone de la base de donnée dans le carré en bas a droite onglet "files". Important: si vous faites cela il faut que vous l nommiez EVS (je vous envoie les captures d'ecran)

## ASPECT DES DONNEES
nrow(EVS)         # nombre de lignes ou d'individus
ncol(EVS)         # nombre de colonnes ou de variables
dim(EVS)

head(EVS, 2)      # Renvoie les deux premieres lignes du jeu de donnees EVS

names(EVS)        # Renvoie le nom des colonnes du tableau (i.e. le nom des variables)

str(EVS)          # Fonction plus complete qui renvoie les caracteristiques des variables : int, num ou factor

# Pour voir le tableau (1000 premieres lignes), cliquer sur l'onglet EVS dans l'environnement de travail

## Acceder a une variable : la variable "v302" : A quoi correspond-elle ? 
EVS$v302
head(EVS$v302)   # Renvoie les 6 premieres valeurs de la variable s
tail(EVS$v302, 10) # Renvoie les 10 dernierse valeurs de la variable s

## C'est totalement illisible : il faut remplacer les codes par des noms de modalite en langage "naturel"
## Autrement dit : il faut renommer les modalites, ou recoder, la variable sexee
## Premiere etape : quelles sont les modalites de la variable? 
table(EVS$v302)
summary(EVS$v302)
class(EVS$v302)
## Probleme : le sexe est considere comme une variable numerique... Il faut la convertir en "facteur" ; on en profite pour la renommer  
EVS$sexe <- factor(EVS$v302) # on rend aussi plus lisible le nom de la variable 
summary(EVS$sexe)
levels(EVS$sexe)
## Seconde etape : 1=Homme et 2=Femme grace a l'option "label"
EVS$sexe <- factor(EVS$sexe, label=c("Homme", "Femme"))
levels(EVS$sexe)
table(EVS$sexe)
freq(EVS$sexe)

## Par defaut, R presente les modalites par ordre alphabetique, mais on peut modifier cet ordre avec l'option "level" 
## On veut que les Femmes apparaissent avant les hommes
EVS$sexe <- factor(EVS$sexe, levels=c("Femme", "Homme"))
table(EVS$sexe)

## EXERCICE 4 
## 1/ Trouver une variable permettant de saisir le plus haut niveau atteint dans les etudes de PI ; 
## 2/ Modifier les noms des modalites pour les rendre explicites.