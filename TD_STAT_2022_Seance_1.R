################################# TD ANALYSE UNIVARIEE ########################################################################
#R studio facilite l'utilisation de R et le developpement de scripts
#Sur la "Console" doivent etre affiches un paragraphe de bienvenu suivi de ">" en bleu (signifie que R 
#est disponible en attente de la prochaine commande)
#Le script (au dessus de la Console) repr?sente une memoire, un historique des commandes que le logiciel doit enchainer
#

## Manipulations de base - R est d'abord une grosse calculatrice
1+3
1+3
450/78
exp(-2)
3*4
3*8^7

## OBJET : l'element de base
## Principe : on cree des objets a partir desquelles on va ensuite pouvoir operer des traitements
#Les objets sont stockes et on peut les reutiliser ulterieurement pour cela on utilise la fleche (operateir d'assignement) <- 
#Cette fleche stocke ce qu'il y a à sa droite dans un objet dont le nom est indiqué à sa gauche.
x <- -8
# peut se lire : prend la valeur -8 et mets la dans un objet qui s'appelle x:
x
y <- 90
x+8
truc <--x + y
truc
truc    <-     x   +  y    #NB es espaces et les commentaires n'ont pas d'importance. On prililegie un espace entre chaque mot ou signe


##Precisions syntaxiques : eviter les caracteres accentués ; R est sensible à la casse (x et X sont deux objets différents)
##eviter les noms courts tels que c, q, t, C, D, F, I, T, max, min
##pas d'espaces: utiliser . ou _ (privilégier _)
#on prefere un nom d'objet pas trop long mais tout de meme suffisement explicite


# les objets n'ont pas de memoire: 
x <- 6
x <- -62
x
x2 <- 6

# les objets peuvent contenir plein de sortes d'information: chiffres mais aussi chaines de caracteres par exemple
#ces "mots" sont delimit?s avec des guillemets simples ou doubles: ' ou ''
chien <- "Dalmatien"

##VECTEURS : 
# Faire des stats suppose d’avoir plus d’une valeur.
# Le vecteur est un type d’objet qui contient des valeurs dans R.
# Il en existe plusieurs types :

##VECTEURS UNIDIMENSIONNELS
# numeric
# integer
# character
# factor
# logical
##VECTEURS PLURIDIMENSIONNELS
# list
# matrix
# data.frame

#Créer un vecteur: 
#operateur c (pour "combine" ou "concatenate") sert à combiner des valeurs ; valeurs numeriques ou alphanumeriques (caracteres)
tailles <- c(167, 192, 173, 174, 172, 167, 171, 185, 163, 170)
tailles
class(tailles)

#un "expériment" suggéré par vous
tailles_augm <- c(167, 192, 173, 174, 172, 167, 171, 185, 163, 170) + 10
tailles_augm #effectivement avec la commande + 10 après parenthèse on ajoute 10 à tous les valeurs! 
# mais il y a de manière plus pratiques (cf. plus en base "les avnatages d'un vecteur")


suite <- c(1:1000)
suite

#opérateur rep (pour "replicate")
toto <- c(7,9,13)
toto
# on répète toto 3 fois
rep(toto, 3)
vecteur_rep <- rep(toto, 3)
# on répète le premier terme une fois,
# et le second deux fois...
rep(toto, 1:3)

nono <- c(1,3,5,7,9) #une preuve ultérieure suggérée par vous
rep(nono, 1:5)

#opérateur seq (pour "sequence"): créer des séries équidistantes de nombres
suite <- seq(1,10) # équivalent à c(1:10)
suite2 <- seq(0,30, 0.5) #de 0 à 30 avec écart de 3 unités

#Un vecteur dans R est un objet qui peut contenir plusieurs informations du même type, potentiellement en très grand nombre.
dipl <- c("BEP", "CAP", "Bac", "Licence", "CAP", "Bac", "Master")
dipl
class(dipl) #VECTEUR ALPHANUMERIQUE (de type character)
table(dipl)
str(dipl)
# Opération sur plusieurs vecteurs alphanumériques
sexe <- c("H","H","H","H","F","F","F")
sexe2 <- rep(c("H","F"), c(4,3))
table(dipl, sexe)
table(dipl,sexe2)

#L'avantage d'un vecteur est que lorsqu'on lui applique une opération, celle-ci s'applique à toutes les valeurs qu'il contient
##Operations sur les vecteurs
tailles+10
tailles*2
tailles-50
tailles/10
tailles^2

### FIN SEANCE 1.A - DEBUT SEANCE 1.2

##Combinaison de vecteurs/opérations sur plusieurs vecteurs
poids <- c(86, 74, 83, 50, 78, 66, 66, 51, 50, 55)
tailles.m <- tailles/100
imc <- poids/(tailles.m^2)
imc

#On peut acceder a un element particulier en indiquant sa position au sein du vecteur entre crochets:
dipl[4]

#AFFICHER UN TEXTE
cat("C'est quoi R ?")
## C'est quoi R ?
cat("C'est quoi \"R\" ?")
## C'est quoi "R" ?
cat("C'est quoi \"R\" ? Un truc de geek !")
## C'est quoi "R" ? Un truc de geek !
cat("C'est quoi \"R\" ? \n Un truc de geek !")
## C'est quoi "R" ?
## Un truc de geek !

## VECTEURS LOGIQUES
# Vecteurs logiques : T=TRUE et F=FALSE
logic <- c(T,T,F,T)
logic
# NB: Préférer TRUE ou FALSE en toutes lettres, qui sont plus explicites.

## MATRICE
# La matrice est un vecteur à deux dimensions.
# Première manière de créer une matrice : on créeun vecteur et on lui définit deux dimensions
x <- 1:12
x
dim(x) <- c(3,4)
x
# Deuxième manière : la fonction matrix
y <- matrix(1:12, nrow=3)
y
y <- matrix(1:12, nrow=3, byrow=T)
y
# On peut transformer cette matrice...
colnames(x) <- LETTERS[1:4]
# donne des noms aux colonnes
rownames(x) <- paste("Indiv", 1:3, sep="")
# donne des noms aux lignes
x
# transposition
t(x) # transposition

# Troisième manière : coller des lignes ou des colonnes
cbind(A=1:4, B=5:8, C=9:12) #par colonne
rbind(A=1:4, B=5:8, C=9:12) #par ligne
#Exemple:
tailles <- c(167, 192, 173, 174, 172, 167, 171, 185,
             163, 170)
poids <- c(86, 74, 83, 50, 78, 66, 66, 51, 50, 55)
x <- cbind(tailles, poids)
x

## LISTES
# Une liste est un objet composé d’un ou plusieurs vecteurs. 
# Ces vecteurs peuvent être de n’importe quel type et de n’importe quelle taille. 
# Beaucoup de fonctions stockent leurs résultats dans une liste.

# Les éléments d'une liste n'ont pas forcément la même taille
maliste <- list(mensuration1=tailles,
                mensuration2=poids)
maliste
maliste$mensuration1
maliste$mensuration2

## DATA.FRAMES
# Un data.frame est une liste composée de vecteurs de même taille.
# Ces vecteurs peuvent être de différents types.
ident <- paste("ID", 1:10, sep="")
data1 <- data.frame(tailles, poids, ident)
str(data1)
# Autre possibilité en donnant un nom différent aux colonnes
data2 <- data.frame(X=tailles, Y=poids, Z=ident)
data2
data1
# On peut aussi renommer après coup
data3 <- data.frame(tailles, poids, ident)
names(data3) <- c("X", "Y", "Z")
str(data3)
data3

## INDEXATION
# Une seule dimension
tailles
tailles[1]
tailles[c(1,3,10)]
# Deux dimensions
data1
data1[1,] #la virgule nous donnes l'ensemble de variables pour un individu


##FONCTIONS
# Une fonction a un NOM, 
# accepte des ARGUMENTS, 
# retourne un RESULTAT 
# et peut effectuer une ACTION (dessiner un graph, lire un fichier, etc.)
## Exemple : L'operateur c est une fonction qui cree un vecteur

##Fonctions utiles pour vecteurs ou variables num?riques
length(tailles)   #Nombre d'elements
mean(tailles)     #Moyenne
var(tailles)      #Variance
min(tailles)      #Minimum
max(tailles)      #Maximum
sd(tailles)       #ecart-type
sum(tailles)      #somme des elements du vecteur
(sum(tailles)/length(tailles))
(sum(tailles)/length(tailles)) - mean(tailles)
moy <- mean(tailles)
sqrt(sum((tailles - moy)^2)/(length(tailles) - 1))

toto <- (1:10)     #renvoie une sequence de nombre de 1 a 10 (equivalent a c(1,2,3))
toto

unique(dipl)      #Supprime tous les doublons

## ARGUMENTS: 
# Entre parentheses apres le nom de la fonction
# Permet de préciser ce que l'on souhaite faire: objet sur lequel s'applique la fonction, parametrage...
# Un argument utilisé dans plusieurs fonctions : na.rm=TRUE : 
# demande a R d'ignorer les valeurs manquantes dans le calcul

tailles2 <- c(167, NA, 192, 173, 174, 172, 167, 171, NA, 185, 163, 170)
tailles2
mean(tailles2) #R considère par défaut qu'il ne peut pas calculer la moyenne si une des valeurs n'est pas disponible
mean(tailles2, na.rm=TRUE) #2 arguments (rm pour remove)


##Aide sur une fonction
help("mean")
?mean
help.start()
# et n'oubliez pas de demander à internet!
# Voir aussi la rubrique "Help" de Rstudio 
# + mailing-list + forums sur internet 

## RECAPITULATIF
# R fonctionne avec des objets. On en manipule principalement deux : les vecteurs et les fonctions. 
# Les vecteurs contiennent les données.
# Les fonctions prennent des arguments, modifient un vecteur et retournent un résultat.
# Les résultats sont affichés (print()) dans la console. 
# Pour qu’ils soient stockés en mémoire, il faut les assigner dans un objet.

### EXERCICE 1 : On a demand? ? 4 m?nages le revenu du chef de m?nage, celui de son conjoint, et le nombre de personnes du m?nage.
# Ménage 1 : Chef = 1200 ; Conjoint = 1450 ; Nb pers = 4
# Ménage 1 : Chef = 1180 ; Conjoint = 1850 ; Nb pers = 2
# Ménage 1 : Chef = 1750 ; Conjoint = 1690 ; Nb pers = 3
# Ménage 1 : Chef = 2100 ; Conjoint = 0 ; Nb pers = 2


### EXERCICE 2 : Dans l'exercice precedent, calculez le revenu minimum et le revenu maximum parmi ceux du chef de menage :


### Recommencer avec les revenus suivants, parmi lesquels l'un des enquétés n'a pas voulu repondre :
chef.na <- c(1200, 1180, 1750, NA)



## Avant de pouvoir proceder a quelque analyse que ce soit, il faut dire a R ou se trouvent les donnees, et charger les extensions necessaires   
library(foreign)
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
setwd("/Volumes/GoogleDrive/Il mio Drive/Backup Hard Disk bianco Set 2020/Francesco/Teaching/Stat Sorbonne 2022/R_Stat_Sorbonne/Stat_Sorbonne")

getwd() 
#permet de voir dans quel dossier de travail/repertoire on est 
