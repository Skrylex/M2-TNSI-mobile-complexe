# Pokeflex 

<p align="center">
  <div style="text-align:center"><img src="/images/market_center.png" alt="PokeCenter"/></div>
</p>

## Introduction

Dans le cadre de ce projet, nous avons réalisé une application Flutter de gestion d'équipe Pokémon. 
Nous avons choisi ce thème car il se rapproche des fonctionnalités attendues. 
Pour ce faire, nous avons utilisé une API RESTful pour récupérer les Pokémons de la première génération. 



## Fonctionnement général

### Section

L'application se découpe en 5 sections : 

- Home Page : Chargement de l'application et récupération du Pokédex via l'API. Cette page devient inaccessible après le chargement du Pokédex (Waiting Screen). 

- Pokédex : Affichage de tous les Pokémons sous forme de liste de Card (Nom + Image). La Card est cliquable pour accéder à la page Détails. 

- Détail Pokémon : Affichage des informations spécifiques au Pokémon et la possibilité d'ajout/retrait à l'équipe (6 Pokémons max. à l'équipe). 

- Equipe : Affichage de l'équipe (6 Pokémons max. à l'équipe). Possibilité d'accéder à la page Détails en cliquant, de retirer un Pokémon de la liste via un Swipe sur l'élément de la liste. Enfin, nous pouvons valider l'équipe. 

- Validation : Affichage d'une confirmation de l'équipe à récupérer au PokéCenter le plus proche. 

  

### AppBar

Nous avons ajouté à l'AppBar existante, un accès direct vers l'équipe. Cet accès est impossible lorsque l'équipe est vide. 
La taille de l'équipe est indiqué sur le bouton grâce à un badge de notification. 



### API 

L'API utilisée : https://pokeapi.co/
Elle est utilisée à deux moments : 

- Au chargement de l'application afin de générer un Pokédex contenant simplement le nom des Pokémons 
- A l'ouverture de la page Détail d'un Pokémon afin de récupérer les informations complètes du Pokémon. 
  Ses appels sont effectué grâce à des Future. Cela nous permet une gestion asynchrone des appels ainsi que de créer une application dynamique. 
- Des factory sont utilisées afin de faire le lien entre le JSON récupérer et la création de nos objets Pokémons. 

Nous sommes limités à 100 appels API par minutes par IP. 

### Stockage 

Le stockage local a été pensé à la version finale de l'application. 

Seules les informations textuelles sont stockées dans le téléphone. Les sprites des Pokémons sont récupérées en liens externes (vers raw.github). 
Cette façon de faire nous permet d'alléger l'application en ne stockant pas les images de tous le Pokédex. 
Cependant, ces images sont maintenues en cache, afin de ne pas recharger les images à chaque appel. 

Le stockage interne se fait grâce aux SharedPreferences (Interface mettant à disposition un espace de stockage lié à l'application sous forme de <key, value>). 

Seule l'équipe sélectionnée est stockée en mémoire. Vous pouvez fermer l'application sans perdre votre équipe. 

### Permissions 

Pour faire fonctionner notre application sur un appareil physique, nous avons ajouté les permissions nécessaire à l'accès internet, permettant d'appeler notre API. 

### Ressources et Assets

Afin de personnaliser notre application, nous avons créer une police de quelques icônes grâce à [Flutter Icon]( https://fluttericon.com/ ), comme la superbe Pokéball présente sur l'AppBar.

Nous avons également ajouté quelques images pour styliser notre affichage. 



## Building APK 

### Revue de l'application 

Avant la release finale, nous avons changer nos propriétés d'application : 

- Le nom et l'ID 

- Le logo

- La version 

- Les versions de SDK cible.

  

### Signature 

La signature de l'application a été effectuée en suivant les instructions [de la documentation Flutter "Signing the app"](  https://flutter.dev/docs/deployment/android#signing-the-app  ).

La signature a été vérifiée grâce à la commande `jarsigner -verify -verbose -certs .\app.apk`.



### Release

La release finale a été effectuée en suivant les instructions [de la documentation Flutter "Build an APK"]( https://flutter.dev/docs/deployment/android#build-an-apk).



## Limites et Tests

#### Appels API

Du fait de la limitation à 100 appels API par minute par IP, nous avons vérifié l'état du Pokédex avant chaque nouvel appel. Si le Pokédex n'est pas complétement instancié, ou que qu'un Pokémon ne possède pas toutes ses informations, alors nous faisons un appel API. Sinon, nous récupérons les données déjà stockées en cache ou en mémoire. 

#### Cycle de Vues

Pour éviter l'empilement des vues de la pile, nous avons utilisés des pushReplacement() et des pop(). 

#### Boutons 

Certains boutons sont disabled si l'accès est refusé. 
