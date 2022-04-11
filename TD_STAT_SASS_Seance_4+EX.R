#### ON RECAPITULE ####

## Avant de pouvoir proceder a quelque analyse que ce soit, il faut dire a R ou se trouvent les donnees, et charger les extensions necessaires   
library(foreign)
library(survey)
library(R2HTML)
library(stats)
library(lmtest) #librairie pour les regressions 
library(xtable)
library(lattice) 
library(nnet) 
library(questionr)
library(tables)

### 1) On regarde nos données

## 1.1. On charge les données dans R

# Nos donn?es sont actuellement stock?es dans le fichier ZA4751_v2-0-0.dta: on l'enregistre dans un dossier sur notre ordinateur
#Definition du dossier par defaut avec lequel R va fonctionner. IL faut faire copier l'adresse du dossier dans lequel la base de donnees est presente
#Puis la coller entre les guillemets comme argument de la fonction setwd. 
#Pour cela, on va dans Explorer, le bon dossier, puis clique droit sur le fichier ZA4751_v2-0-0.dta et on clique sur "Propri?t?". 
#on copie ce qui est ?crit apr?s Emplacement et on le colle dans la ligne de code suivante ? l'emplacement du chemin actuellement ?crit:
setwd("/Volumes/GoogleDrive/Il mio Drive/Backup Hard Disk bianco Set 2020/Francesco/Teaching/Stat Sorbonne 2022/R_Stat_Sorbonne/Stat_Sorbonne")

#on s?lectionne la ligne au-dessus et on fait Ctrl + entr?e. Il est probable que R affiche un message d'erreur. Si c'est le cas:
#verifier que les slashs sont dans le bon sens: /
#Pour les macs, commencer par un slash et non par un ~
#on v?rifie qu'on a bien les guillemets et le bons noms de dossier.
#si cette ?tape n'est pas valid?e, on ne peut rien faire

getwd() 
#permet de voir dans quel dossier de travail/repertoire on est 

data() #les dataset installés sur rstudio par defaut (très utiles pour s'entrsainer!)

## 1.2. On donne un nom à nos données. ZA4751_v2-0-0.dta n'est pas très lisible, on va donc les appeller EVS

EVS <- read.dta("ZA4751_v2-0-0.dta",convert.factors = F)


## 1.3. On va maintenant essayer de regarder nos donn?es, d'en apprendre plus sur la façon dont la base est organisée
nrow(EVS)         # nombre de lignes ou d'individus
ncol(EVS)         # nombre de colonnes ou de variables
dim(EVS)          # nombre d'individus suivi du nombre de variables

head(EVS, 2)      # Renvoie les deux premieres lignes du jeu de donnees EVS

names(EVS)        # Renvoie le nom des colonnes du tableau (i.e. le nom des variables)

str(EVS)          # Fonction plus complete qui renvoie les caracteristiques des variables : int, num ou factor

# Pour voir le tableau (1000 premieres lignes), cliquer sur l'onglet EVS dans l'environnement de travail
View(EVS)
#Avertissement: nous n'utiliserons pas, pour cette premiere decouverte de R, la variable de ponderation FR05.
#les resultats que nous obtiendrons ne peuvent pas etre completement (la deformation est tres legere pour cette enquete)
#consid?re?s comme s'appliquant a la population francaise totale.
#n?anmoins, dans les diff?rents traitements et commentaires que vous en ferez, vous consid?rerez "exceptionnellement" que c'est le cas.


## 1.4. On va s'intéresser à une variable en particulier, la variable nommée v302
EVS$v302      #regarder la variable V302 qui appartient ? la basse de donn?es EVS (on écrit toujours avant une variable le nom
#"de la base à qui elle appartient, séparée par un $ qui signifie 'appartient ?'")

head(EVS$v302)   # Renvoie les 6 premieres valeurs de la variable v302
tail(EVS$v302, 10) # Renvoie les 10 dernierse valeurs de la variable v302

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
## Seconde etape : on renomme les mosalités de la facçon suivante: 1=Homme et 2=Femme grace a l'option "label"
EVS$sexe <- factor(EVS$sexe, label=c("Homme", "Femme"))
levels(EVS$sexe)
table(EVS$sexe)
freq(EVS$sexe)

### INTRO AUX FACTEURS
https://swcarpentry.github.io/r-novice-inflammation/12-supp-factors/index.html
https://larmarange.github.io/analyse-R/facteurs-et-vecteurs-labellises.html 

## Par defaut, R presente les modalites par ordre alphabetique, mais on peut modifier cet ordre avec l'option "level" 
## On veut que les Femmes apparaissent avant les hommes
EVS$sexe <- factor(EVS$sexe, levels=c("Femme", "Homme"))
table(EVS$sexe)

#1.5. On s'intéresse au statut d'emploi
## EXERCICE 3 
## 1/ Trouver, à partir du questionnaire, une variable permettant de saisir le statut d'emploi 
# (si la personne a - ou pas - une activite professionnelle rémunérée) ; 
##### 
EVS$v337
summary(EVS$v337)
class(EVS$v337)
levels(EVS$v337)

## 2/ Modifier les noms des modalites pour les rendre explicites.
##### 
EVS$statut <- factor(EVS$v337, label=c(">30h", "<30h", "A son compte", "Retraité", "au foyer", "Etudiant", "Chômeur", "Handicapé", "Autre"))


EVS$statut <- factor(EVS$v337, label=c(">30h", 
                                       "<30h", 
                                       "A son compte", 
                                       "Retraité",
                                       "Au foyer",
                                       "Etudiant",
                                       "Chômeur",
                                       "Handicapé",
                                       "Autre"))
table(EVS$statut)
freq(EVS$statut)


#### ON REPREND ####
#1.6. On s'intéresse au niveau d'étude, c'est-à-dire à la variable v336_cs

EVS$v336_cs
head(EVS$v336_cs) #la variable niveau d'etude est recoéee d'abord de manière harmonisee pour l'ensemble des pays 
#europeens. Nous, on veut le recodage initial, celui du questionnaire. On regarde dans la codebook (coodebook ZA4751_cdb_CODEBOOK_EVS.pdf) et on voit que cette variable est codee 
#v336_cs pour country sepcific
table(EVS$v336_cs)
class(EVS$v336_cs)
table(EVS$v336_cs, useNA="ifany") #argument qui permet de voir le nombre de NA. Sinon, il y a la fonction freq qui est tres bien:
freq(EVS$v336_cs)
EVS$dipl <- factor(EVS$v336_cs) 
freq(EVS$dipl)
EVS$dipl <- factor(EVS$dipl, label=c("ec.prim.s.certif", 
                                     "ec.prim.a.certif", 
                                     "college.g", 
                                     "college.p", 
                                     "lycee.g",
                                     "lycee.p", 
                                     "CAP.BEP",
                                     "Deug.Prepa",
                                     "Bac+3-4",
                                     "Bac+5",
                                     "Bac+2",
                                     "Bac+8"))
freq(EVS$dipl)
barplot(table(EVS$dip)) #diagramme baton val absolues
barplot(prop.table(table(EVS$dipl))) #diagramme baton vale pourcentage


##On peut avoir besoin de regrouper les modalites d'une variable qualitative, pour diverses raisons:
# lisibilite
# trop de categories pour certaines analyses
#trops faibles effectifs dans certaines categories
table(EVS$dipl, EVS$v336_3)
## Exemple : on voudrait ici : ec.prim, college/CAP/BEP, bac, Bac+2, Bac+3 et plus
EVS$ddipl_PI <- "abc"
class(EVS$ddipl_PI)
EVS$ddipl_PI [EVS$dipl == "ec.prim.s.certif"] <- "ec.prim"
EVS$ddipl_PI [EVS$dipl == "ec.prim.a.certif"] <- "ec.prim"
EVS$ddipl_PI [EVS$dipl == "college.g"] <- "college.CAP.BEP"
EVS$ddipl_PI [EVS$dipl == "college.p"] <- "college.CAP.BEP"
EVS$ddipl_PI [EVS$dipl == "CAP.BEP"] <- "college.CAP.BEP"
EVS$ddipl_PI [EVS$dipl == "lycee.g"] <- "Bac"
EVS$ddipl_PI [EVS$dipl == "lycee.p"] <- "Bac" 
EVS$ddipl_PI [EVS$dipl == "Deug.Prepa"] <- "Bac+2" 
EVS$ddipl_PI [EVS$dipl == "Bac+2"] <- "Bac+2" 
EVS$ddipl_PI [EVS$dipl == "Bac+3-4"] <- "Bac+3-8" 
EVS$ddipl_PI [EVS$dipl == "Bac+5"] <- "Bac+3-8" 
EVS$ddipl_PI [EVS$dipl == "Bac+8"] <- "Bac+3-8" 
#les crochets signifient que l'on selectionne un sous ensemble au sein de l'ensemble a gauche des crochets
#dans les crochets on ecrit la conditions a satisfaire pour faire partie de ce sous-ensemble
#ici les sous ensemble d'individus doivent satisfaires des conditions sur la variable dipl
#ces conditions sont d'avoir certaines modalités pour cette variable
barplot(table(EVS$ddipl_PI)) #on fait un diagramme baton


#on inclu les NA
table(EVS$ddipl_PI, useNA="ifany")
EVS$ddipl_PI [is.na(EVS$dipl)==T] <- NA 
table(EVS$ddipl_PI, useNA="ifany")
table(EVS$ddipl_PI, EVS$dipl, useNA="ifany")
barplot(table(EVS$ddipl_PI, useNA = "ifany")) #on fait un diagramme baton

## Une maniere plus rapide et "elegante" de le faire: désigner des vecteurs de modalités avec l'operateur %in%
EVS$ddipl_PI2 <- NA #on choisit un residu, ici les NA. Ca fait gagner du temps
EVS$ddipl_PI2 [EVS$dipl %in% c("ec.prim.s.certif","ec.prim.a.certif")]<- "ec.prim"
EVS$ddipl_PI2 [EVS$dipl %in% c("college.g","college.p", "CAP.BEP")]<- "college.CAP.BEP"
EVS$ddipl_PI2 [EVS$dipl %in% c("lycee.g","lycee.p")]<- "Bac"
EVS$ddipl_PI2 [EVS$dipl %in% c("Deug.Prepa","Bac+2")]<- "Bac+2"
EVS$ddipl_PI2 [EVS$dipl %in% c("Bac+3-4","Bac+5", "Bac+8")]<- "Bac+3-8"

table(EVS$ddipl_PI2, useNA="ifany") #Probleme : les modalites sont regroupes par ordre alphabetique! 

#Du coup on utilise à nouveau l'option levels pour mettre les modalités dans l'ordre souhaité
EVS$ddipl_PI2 <- factor(EVS$ddipl_PI2, levels=c("ec.prim", "college.CAP.BEP", "Bac", "Bac+2","Bac+3-8"))

freq(EVS$ddipl_PI2) #AC
plot(EVS$ddipl_PI2) # diagramme baton val absolues
barplot(prop.table(table(EVS$ddipl_PI2))) #diagramma baton val %

#AC signifie A commenter. Les tableaux, graphiques et autres sorties pour lesquelles vous voyez ecrit "AC sont celles que je souhaite que vous
#metiez au propre dans un document word par exemple, avec un titre, une source, un champs et une note et un rapide commentaire.
copie(freq(EVS$ddipl_PI2)) 

#Nous cherchons maintenant à présenter nos résultats de facon plus aimable.

#Voici comment r?aliser certaines representations graphiques:

#diagramme circulaire
table(EVS$ddipl_PI2)
freq(EVS$ddipl_PI2)
pie(EVS$ddipl_PI2)#ne fonctionne pas: la fonction veut qu'on lui donne les effectifs de chaque modalites
pie(table(EVS$ddipl_PI2)) #avec table ca marche
pie(table(EVS$ddipl_PI2), col=c("white","grey","yellow","orange","red")) 

#diagramme en batons
barplot(table(EVS$ddipl_PI2))
barplot(table(EVS$ddipl_PI2), col=c("white","grey","yellow","orange","red"), las=2) # diagramme baton valeurs absolues

#Et si on veu le diagramme en %?
table_dipl <- (table(EVS$ddipl_PI2)) #d'abord on crée un objet tableau
table_dipl_pourcentage <- prop.table(table(EVS$ddipl_PI2)) #ensuite on cree un objet tableu %
barplot(table_dipl_pourcentage, col=c("white","grey","yellow","orange","red"), las=2) # enfin on fait le barplot de ce dernier - 
# voici le diagramme baton valeurs %


### 1.2. -- Analyse et représentation d'une variable quantitative --
## Comment faire avec une variable numerique ? 

#Exemple : Age : quelle est la var "age" dans EVS ? -> v303
table(EVS$v303, useNA="ifany") # v303 nous donne les effectifs par année de naissance

class(EVS$v303) #on est bien avec une variable numerique, on peut donc faire des operations mathematiques

#on crée une nouvelle variable age à partir de l'année de naissace. 
#On sait quelle age au moment de l'enquete = date de l'enquete - annee de naissance donc on cree:
EVS$age <- 2008-EVS$v303
table(EVS$age) #on verifie que notre variable age donne bien des r?sultats coh?rents en regardant les effectifs associ?s ? chaque modalit?

table(EVS$age, useNA="ifany")
freq(EVS$age)# on regarde les frequences associees à chaque modalité
quantile(EVS$age)
class(EVS$age)

## Representation graphique :
# si besoin d'aide: www.duclert.org/Aide-memoire-R/graphiques/ 

#diagramme en batones
barplot(EVS$age)   #ne fonctionne pas
barplot(table(EVS$age, useNA="ifany")) # donne le graphe mais sans aucune legende
barplot(table(EVS$age, useNA="ifany"), legend.text="individus par age")
barplot(table(EVS$age, useNA="ifany"), legend.text="individus par age", col="red")
barplot(table(EVS$age, useNA="ifany"), legend.text="individus par age", col="red", xlab="Age")
barplot(table(EVS$age, useNA="ifany"), legend.text="individus par age", col="red", xlab="Age", ylab="Effectifs")
barplot(table(EVS$age, useNA="ifany"), legend.text="individus par age", col="orange", xlab="Age", ylab="Effectifs", 
        main="Age des individus")
barplot(table(EVS$age, useNA="ifany"), legend.text="individus par age", col="orange", xlab="Age", ylab="Effectifs", 
        offset=20, main="Age des individus", cex.names=0.8) #offset: griglia y parte da 20
barplot(table(EVS$age, useNA="ifany"), legend.text="individus par age", col="orange", xlab="Age", ylab="Effectifs", 
        main="Age des individus", cex.names=0.6) 

#histogramme
hist(EVS$age)
hist(EVS$age, col="green") # version par defaut
hist(EVS$age, col="green", breaks=c(18,19,20,21,22,63,118)) #mais on peut aussi choisir les bornes de chaque baton
hist(EVS$age, col="green", breaks=c(18,28,38,48,58,68,78,88,98,108,118))#mais il faut alors choisir des bornes lisibles et coh?rentes

#bo?te ? moustache
boxplot(EVS$age, main="Age des individus", ylab="Age", col="orange")


abline(h = median(EVS$age, na.rm = TRUE), col = "navy", lty = 2)
text(1.35, median(EVS$age, na.rm = TRUE) + 0.15, "Mediane", col = "navy")
Q1 <- quantile(EVS$age, probs = 0.25, na.rm = TRUE)
abline(h = Q1, col = "darkred")
text(1.35, Q1 + 0.15, "Q1 : premier quartile", col = "darkred",lty = 2)
Q3 <- quantile(EVS$age, probs = 0.75, na.rm = TRUE)
abline(h = Q3, col = "darkred")
text(1.35, Q3 + 0.15, "Q3 : troisieme quartile", col = "darkred", lty = 2)
arrows(x0 = 0.7, y0 = quantile(EVS$age, probs = 0.75, na.rm = TRUE), x1 = 0.7, y1 = quantile(EVS$age, probs = 0.25,na.rm = TRUE), length = 0.1, code = 3)
text(0.7, Q1 + (Q3 - Q1)/2 + 0.15, "h", pos = 2)

mtext("L'ecart inter-quartile h contient 50 % des individus",side = 1)

boxplot(EVS$age, ylab="Age", col="orange") #AC
rug(EVS$age, side = 2)

## Copier une représentation graphique dans un fichier word
#lorsque la représenation graphique dans la fenetre en bas à droite vous convient, 
#cliquer dans la bare des taches de la fenetre en bas à droite (onglet Plots) sur export, 
#puis sur "Copy to Clipboard". Ouvrez un word et afites "Coller"
#ou: de meme puis "Save an image" (pour exporter dans un fichier dans un dossier precis)

## Nous allons maintenant retravailler la variable age en redécoupant les modalit?s
## On peut decouper la variable age en 6 classes d'amplitude egale
EVS$age_PI_6 <- cut(EVS$age,6) 
table(EVS$age_PI_6, EVS$age, useNA="ifany")

##On peut aussi choisir les frontieres des classes
EVS$age_PI_7 <- cut(EVS$age, c(18, 25, 35, 45, 55, 65, 75, 118))
table(EVS$age_PI_7, EVS$age, useNA="ifany") 
#Attention: en ce cas et par defaut 
#R a exclu les individus ages de 18 ans et inclut ceux de 65 !
# CAS ou on inclut les 2 extremites : 
EVS$age_PI_7 <- cut(EVS$age, c(18, 25, 35, 45, 55, 65, 75, 118), include.lowest=TRUE)
table(EVS$age_PI_7, EVS$age, useNA="ifany") 
# CAS ou on inclut les 18 ans et exclut les 65 : 
EVS$age_PI_7 <- cut(EVS$age, c(18, 25, 35, 45, 55, 65, 75, 118), right=FALSE)
table(EVS$age_PI_7, EVS$age, useNA="ifany") 
# CAS ou on exclut les 2 extremites : bug !!  
EVS$age_PI_7 <- cut(EVS$age, c(18, 25, 35, 45, 55, 65, 75, 118), include.lowest=FALSE, right=FALSE)

table(EVS$age_PI_7, EVS$age, useNA="ifany") 

# Voir help "cut" pour voir comment fonctionne la fonction, et ses options 

##Et on peut renommer les intervalles en utilisant l'option labels
EVS$age_PI_7 <- cut(EVS$age, c(18, 25, 35, 45, 55, 65, 75, 118), include.lowest=TRUE, 
                    right=T, labels=c("<25", "25-35", "36-45", "46-55", 
                                      "56-65", "65-75",">75"))
table(EVS$age_PI_7, useNA="ifany")

##Enfin, on peut demander a R de decouper des classes d'effectifs semblables (package rgrs)
EVS$age_PI_EFF <- quant.cut(EVS$age, 6)
table(EVS$age_PI_EFF, useNA="ifany")

##Quelle representation?
#Effectifs absolus ou relatifs
class(EVS$age_PI_7)
freq(EVS$age_PI_7, cum=TRUE, total=TRUE, digits=2, exclude=NA) 


#Diagramme en baton
barplot(table(EVS$age_PI_7), xlab="Ages", ylab="Effectifs", 
        col="magenta", ylim=c(0, 600))
boxplot(table(EVS$age_PI_7), xlab="Ages", ylab="Effectifs", 
        col="magenta", ylim=c(0, 600))
#AC --> comparer avec le graphique boxplot: quelle est la representation la plus lisible de l'age dans notre ?chantillon?
