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
chien

##VECTEURS : 
# Faire des stats suppose d’avoir plus d’une valeur.
# Le vecteur est un type d’objet qui contient des valeurs dans R.
# Il en existe plusieurs types :

##VECTEURS UNIDIMENSIONNELS
# Numeric (nb réel) et Integer (nb entier)
# Character (chaîne de caractères)
# Logical (valeur binaire)

# Factor (un vecteur dont les éléments ne peuvent prendre que des modalités prédefinies: couleur, sexe , jour de la semaine)

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
dipl
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

##Combinaison de vecteurs/opérations sur plusieurs vecteurs
poids <- c(86, 74, 83, 50, 78, 66, 66, 51, 50, 55)
tailles_m <- tailles/100
tailles_m
poids/(tailles_m^2)
imc <- poids/(tailles_m^2)
imc

#On peut acceder a un element particulier en indiquant sa position au sein du vecteur entre crochets (INDEXATION):
dipl
dipl[4]
dipl[1]          # extraire le premier élément
dipl[10]         # dernier élément
dipl[c(1, 5)]    # premier et cinquième
dipl[-c(1, 5)]   # tous sauf premier et cinquième
dipl[c(1:5)]

# La composition d’un vecteur n’est pas altérée lors de l’indexation, 
# mais on peut se servir de cette dernière pour introduire des modifications dans le vecteur.
tailles2 <- c(167, 192, 173, 174, 172, 167, 171, 185, 163, 170)
tailles2[1] <- 175 # modifier le 1er élément
tailles2[c(3, 10)] <- c(168, 170) # modifier le 3e et 10e élément
tailles2[11] <- 176  # ajouter un nouveau élément et le placer 11e
tailles2 <- c(tailles2, 177) # ajouter un nouveau élément à la fin
tailles2 <- tailles2[-2] # supprimer le 2e élément
tailles2

#AFFICHER UN TEXTE
question <- cat("C'est quoi R ?")
## C'est quoi R ?
cat("C'est quoi \"R\" ?")
## C'est quoi "R" ?
cat("C'est quoi \"R\" ? Un truc de geek !")
## Un truc de geek !
cat("Un truc de geek!")
## C'est quoi "R" ? Un truc de geek !
cat("C'est quoi \"R\" ? \n Un truc de geek !")

## C'est quoi "R" ?
## Un truc de geek !
question <- "C'est quoi R ?"
reponse <- "Un truc de geek!"
paste(question, reponse) #On a concaténé une chaîne de caractères!



## VECTEURS LOGIQUES
# Vecteurs logiques : T=TRUE et F=FALSE
logic <- c(T,T,F,T)
logic
# NB: Préférer TRUE ou FALSE en toutes lettres, qui sont plus explicites.


### VECTEURS PLURIDIMENSIONNELS
## MATRICE
# La matrice est un vecteur à deux dimensions. Un vecteur dont les éléments sont disposés sous forme d’un tableau 
# qui comporte des lignes et des colonnes. 
# Ce qui caractérise une matrice est le fait qu’elle dispose de l’attribut dim (pour dimension). 

# Première manière de créer une matrice : on crée un vecteur et on lui définit deux dimensions
x <- 1:12
x
dim(x) <- c(3,4)
x
# Deuxième manière : la fonction matrix
y <- matrix(1:12, nrow=3)
y
y <- matrix(1:12, nrow=3, byrow=TRUE)
y
# On peut transformer cette matrice...

# donner des noms aux colonnes
colnames(x) <- LETTERS[10:13]
x
# donner des noms aux lignes
rownames(x) <- paste("Indiv", 1:3, sep="")
rownames(x) <- paste("Indiv", 1:3)
x
# transposition
t(x) # transposition

# Troisième manière : coller des lignes ou des colonnes
cbind(A=1:4, B=5:8, C=9:12) #par colonne
rbind(A=1:4, B=5:8, C=9:12) #par ligne
# Autre Exemple:
tailles <- c(167, 192, 173, 174, 172, 167, 171, 185,
             163, 170)
poids <- c(86, 74, 83, 50, 78, 66, 66, 51, 50, 55)
x <- cbind(tailles, poids)
x
rownames(x) <- paste("Obs", 1:10, sep = "")

## LISTES
# Une liste est un objet composé d’un ou plusieurs vecteurs. Ce sont les structures moins rigides et plus plyvalentes.
# Ces vecteurs peuvent être de n’importe quel type et de n’importe quelle taille. 
# Beaucoup de fonctions stockent leurs résultats dans une liste.

# Les éléments d'une liste n'ont pas forcément la même taille
maliste <- list(mensuration1=tailles,
                mensuration2=poids)
maliste
maliste$mensuration1 #NB le symbole "$"
maliste$mensuration2

maliste2 <- list(mensuration1=tailles2,
                 mensuration2=poids)
maliste2

#Pour créer une liste, il suffit d’utiliser la fonction list() et d’écrire entre les parenthèses les différents éléments.
# Les objets à mettre dans une liste
el_liste1 <- c(45, 12, 56, 14, 16)
el_liste2 <- c("Car", "Bike")
el_liste3 <- matrix(1:12, ncol = 4)

# Création de la liste
liste <- list(el_liste1, el_liste2, el_liste3)
liste
liste <- list(el1 = el_liste1, el2 = el_liste2, el3 = el_liste3) #renommer


# Nous pouvons accéder à un élément d’une liste de plusieurs façons différentes.
# par numéro (position), en utilisant les doubles crochets
liste[[3]]
# par nom, en utilisant les doubles crochets
liste[["el3"]]
# par nom, en utilisant l'opérateur $ (Méthode la plus fréquente)
liste$el3


## DATA.FRAMES
# Un data.frame est une liste composée de vecteurs de même taille.
# Ces vecteurs peuvent être de différents types.
# Pour créer un data frame, nous allons commencer par créer les vecteurs 
# qui constitueront les colonnes de notre future data frame.
tailles #existe deja
poids #existe deja 
ident <- paste("ID", 1:10, sep="") #on cree ident
ident
# Maintenant il suffit d’utiliser la fonction data.frame() pour construire notre data frame.
data1 <- data.frame(tailles, poids, ident)
str(data1)
data1
View(data1)

# Petite variation en donnant un nom différent aux colonnes
data2 <- data.frame(X=tailles, Y=poids, Z=ident)
data2 <- data.frame(tailles=X, poids=Y, ident=Z) #cela ne marche pas

data2
data1
# On peut aussi renommer après coup
data3 <- data.frame(tailles, poids, ident)
names(data3) <- c("X", "Y", "Z")
data3
str(data3)
attributes(data3)
View(data3) #afficher les donnes du data.frame (nouvel onglet)

## INDEXATION
# Une seule dimension
tailles
tailles[1]
tailles[c(1,3,10)]

# Deux dimensions
data1
data1[1,] #la virgule nous donnes l'ensemble de variables pour un individu

# selectionner certaines colonnes par numero/position
data1[c(2, 3)]                    # colonnes 2 et 3
data1[, c(2, 3)]                  # idem
data1 |> subset(select = c(2, 3)) # idem
data1[-c(2, 3)]                    # toutes les colonnes sauf 2 et 3
data1[, -c(2, 3)]                  # idem (resultat = vecteur)
data1 |> subset(select = -c(2, 3)) # idem

#par nom
data1$poids                       # colonne "poids" (resultat = vecteur)
data1["poids"]                    # colonne "poids" (resultat = data.frame)
data1 |> subset(select = "poids") # idem
data1 |> subset(select = poids)   # idem

data1 |> subset(select = -c(poids, ident)) # toutes les colonnes sauf "poids" et "ident"

# selectionner certaines lignes
# par numero/position
data1[c(2, 3), ]  # les lignes 2 et 3
data1[-c(2, 3), ] # toutes les lignes sauf  2 et 3
#par condition logique [En pratique, il arrive très souvent que l’on souhaite soustraire 
# un sous-ensemble d’observations (lignes) qui remplissent une certaine condition. Voici quelques exemples]
data1[data1$tailles >= 170, ]           # sélectionner uniquement les tailles supérieures à 170
data1 |> subset(subset = tailles >= 170) # idem
data1 |> subset(tailles >= 170)          # idem
# les individus dont la taille est  au moins egale à 170 e la taille inférieur à la taille moyenne
data1 |> subset(tailles >=  170  & poids < mean(poids)) 
# idem mais on selecte seulement les colonnes tailles
data1 |> subset(tailles >=  170  & poids < mean(poids), select = c(tailles, poids)) 


##FONCTIONS
# Une fonction a un NOM, 
# accepte des ARGUMENTS, 
# retourne un RESULTAT 
# et peut effectuer une ACTION (dessiner un graph, lire un fichier, etc.)
## Exemple : L'operateur c est une fonction qui cree un vecteur

##Fonctions utiles pour vecteurs ou variables numériques
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

unique(dipl)      #Supprime tous les doublons (les observations multiples)

## ARGUMENTS: 
# Entre parentheses apres le nom de la fonction
# Permet de préciser ce que l'on souhaite faire: objet sur lequel s'applique la fonction, parametrage...
# Un argument utilisé dans plusieurs fonctions : na.rm=TRUE : 
# demande a R d'ignorer les valeurs manquantes dans le calcul

tailles3 <- c(167, NA, 192, 173, 174, 172, 167, 171, NA, 185, 163, 170)
tailles3
mean(tailles3) #R considère par défaut qu'il ne peut pas calculer la moyenne si une des valeurs n'est pas disponible
mean(tailles3, na.rm=TRUE) #2 arguments (rm pour remove)


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




### EXERCICE 1 : On a demandé à 4 ménages le revenu du chef de ménage, celui de son conjoint, 
### et le nombre de personnes du ménage
# Ménage 1 : Chef = 1200 ; Conjoint = 1450 ; Nb pers = 4
# Ménage 2 : Chef = 1180 ; Conjoint = 1850 ; Nb pers = 2
# Ménage 3 : Chef = 1750 ; Conjoint = 1690 ; Nb pers = 3
# Ménage 4 : Chef = 2100 ; Conjoint = 0 ; Nb pers = 2

### Calculez le revenu total par personne de chaque Ménage
## Suggestion 1: d'abord il faut un data.frame pour chaque ménage
## Suggestion 2: ensuite on calcule le revenu total par personne de chaque ménage 
# (indice: utiliser le symbole $ pour indexer les valeurs du dataframe qui nous intéressent pour le calcul)


### EXERCICE 2 : Dans l'exercice precedent, calculez le revenu minimum et le revenu maximum parmi ceux du chef de menage :
# Sugggestion: faites à nouveau un data.frame
# ensuite utiliser les fonctions qu'on a vu avant (min, max etc)


#Renommez les menages en creant un nouveau data frame









