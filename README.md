Tutorial Webflow Jahia
======================

I. Introduction
---------------
Ce tutoriel nécessite une connaissance des concepts Jahia basiques tels que la création de vues ou l'édition de pages.
L'objectif de de tutoriel est de vous apprendre à réaliser des webflows sous Jahia 7.1. 
Les webflows sont des formulaires complexes qui comportent plusieurs étapes et qui s'étendent donc sur plusieurs pages web. 

Pour réaliser ce tutoriel, je me suis basé sur cet exemple : https://github.com/shyrkov/jahia-spring-webflow-showcase

Pour illustrer ce tutoriel, nous prendrons comme exemple une démarche de mise à jour d'informations de contact.
Commencez donc par créer un templateSet sous Jahia.

Note : Attention, tout le code HTML présent dans ce tutoriel est présent à titre d'illustration et ne suit pas forcément les bonnes pratiques du codeage HTML.
Pour suivre les bonnes pratiques de création de formulaire, veuillez vous référer à ce lien : http://www.w3.org/WAI/tutorials/forms/

II. La structure d'un webflow
-----------------------------
Un webflow sous Jahia comporte plusieurs fichiers principaux qu'il est important de connaître.
Il est important de comprendre le rôle de chacun de ces fichiers:
1. flow.xml : ce fichier xml va contenir le squelette de notre webflow, c'est à dire la liste et l'ordre des étapes du webflow ainsi que la définition des beans java utilisés par celui-ci. C'est le cœur de notre webflow.
2. *.jsp : ces fichiers vont contenir les vues utilisées par les différentes étapes de notre webflow. Dans ces vues il y aura le code HTML des différents formulaires.
3. handler.java : cette class Java va contenir le traitement appelé à la fin du webflow. Dans notre exemple c'est cette class qui va créer un compte à partir des informations recueillis depuis le weblflow.
4. object.java : cette class Java va contenir un objet correspondant aux informations partagées par les différentes étapes du webflow. Dans notre exemple, il y aura informations du compte tel que l'adresse email, le numéro de téléphone mobile et fixe.  

III. Déclaration du composant
-----------------------------
Tout d'abord, nous allons commencer par déclarer notre composant ainsi que sont namespace dans le fichier definitions.cnd
Rappel : le fichier defintions.cnd est localisé dans le dossier src/main/resources/META-INF/
Nous allons créer deux namespace dans ce fichier, un namespace correspondant aux node types de smile et un namespace correspondant aux mixins de smile.
Le code suivant déclare les deux namespaces dont nous aurons besoin:
```
<snt = 'http://www.smile.fr/jahia/nt/1.0'>
<smix = 'http://www.smile.fr/jahia/mix/1.0'>
```
Nous allons en suite créer une mixine héritante de la mixine "jmix:droppableContent", cela va nous permettre de gliser déposer notre composant dans une page.
```
[smix:smileContent] > jmix:droppableContent mixin
```
Finalement, nous allons déclarer notre composant, ce composant va hériter de la mixine "smix:smileContent" pour pouvoir être glisé-déposé ainsi que du node type "jnt:content".
```
[snt:updateContactInfos] > jnt:content, smix:smileContent
```
Sauvegardez et compilez, et le composant devrais donc apparaître dans la liste des contenues du mode édition.
![alt text](img/screen-shot-2.jpg)

IV. Création de l’arborescence
------------------------------
Dans le dossier "src/main/resources", nous allons créer une arboréscence correspondant à notre composant.
Tout d’abord il faut créer un dossier correspondant au nom du composant. Le nom de ce dossier se compose de la manière suivante : "namespace du composant" + "_" + "nom du composant en camelCase"
Pour notre exemple, nous allons donc nommer ce dossier "snt\_updateContactInfos".
Dans ce dossier nous allons créer un dossier "html", ce dossier contiendra les vues html.
Finalement, nous allons créer dans ce dossier, un dernier dossier nommé de la manière suivante : "nom du composant en camelCase" + "." + "flow"
L’arborescence devrait donc ressembler à ça "src/main/resources/snt\_updateContactInfos/html/updateContactInfos.flow/".

V. Création du flow.xml
------------------------
Dans le dossier "updateContactInfos.flow", créez un fichier nommé "flow.xml".
Vous trouverez ci-dessous le code de base du flow:
```
<?xml version="1.0" encoding="UTF-8"?>
<flow xmlns="http://www.springframework.org/schema/webflow" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xsi:schemaLocation="http://www.springframework.org/schema/webflow http://www.springframework.org/schema/webflow/spring-webflow-2.0.xsd">
</flow>
```
Les étapes du flow seront incluses entre les balises "\<flow>\</flow>".
Pour créer une étape, ajoutez donc le balise suivante entre les baslises "\<flow>\</flow>":
```
<view-state id="viewName"></view-state>    
```
Pensez bien à modifier la valeur de l'attribut "id" car il va correspondre à notre vue JSP. La première étape de notre
webflow sera une page récapitulative des informations de contact. Changez donc la valeur de l'id de la view-state en "resumeContactInfos".

VI. Création des vues
---------------------
Nous allons maintenant créer une vue JSP correspondante à l'étape que nous avons créée dans le "flow.xml"
Créez un fichier dans le même dossier que le "flow.xml" et nommez le de la même manière que l'id de l'étape précédemment créée.
Cette vue JSP va donc contenir le code HTML du formulaire. Vous pouvez vous inspirer de l'exemple ce code suivant:
```
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<form:form modelAttribute="contactInfos" method="post" >
    <fieldset>
        <legend>Mes informations de contact</legend>
        <div>
            <label for="email">Couriel : </label>
            <form:input path="email" />
        </div>
        <div>
            <label for="email">Téléphone mobile : </label>
            <form:input path="mobilePhone" />
        </div>
        <div>
            <label for="email">Téléphone fixe : </label>
            <form:input path="homePhone" />
        </div>
    </fieldset>
</form:form>
```
Nous pouvons voir que la balise "form" contient un attribut nommé "modelAttribute". La valeur de cet attribut correspond à l'id du bean spring utilisé pour stocker les informations du webflow.
Pour l'instant, nous n'avons encore déclaré aucun bean nommé "contactInfos" donc si vous affichez la page, il y aura une erreur.

VII. Création de l'objet Java
-----------------------------
Créez une nouvelle class Java dans le dossier "src/main/java" et nommez la "ContactInfos.java" par exemple.
Cette class doit étendre la class Serializable pour pouvoir être stocké.
Créez les variables dont vous aurez besoin, il vous faut une variable pour chaque champs de formulaire présent dans le webflow.
Générez les getter et setter correspondant ainsi que la méthode "toString()".
Maintenant nous allons déclarer cette class dans le "flow.xml". 
Créez une balise fermente "\<var />" contenant un attribut "name" et un attribut "class". L'attribut "name" va correspondre au nom du bean et l'attribut "class" va correspondre au nom de la class.
Voici le code de la balise complète:
```
<var name="contactInfos" class="fr.smile.tutorial.ContactInfos"/>
```
Faites bien attention à bien faire correspondre la valeur de l'attribut "name" avec la valeur de l'attribut "modelAttribute" utilisé dans la vue JSP.

VIII. Ajout de boutons de navigation
-------------------------------------
Pour créer un bouton "finish" par exemple il faut rajouter le code HTML du bouton dans la vue souhaitée pour qu'il apparaisse et il faut définir son action dans le "flow.xml".
Dans votre vue, ajouter un bouton "\<button>\</button>" de type "submit" possédant un id bien définit par exemple "next".
Il est également important d'ajouter un attribut "name" dont la valeur est composé de la manière suivante : "_eventId_" + "id du button".
Voici le code HTML de notre bouton :
```<button id="finish" type="submit" name="_eventId_finish">Finir</button>```
Dans le fichier "flow.xml", dans la balise "\<view-state>\</view-state>" correspondant à votre vue, ajoutez une balise "\<transition/>".
Cette balise va lier une action à un bouton correspondant dans une vue JSP. 
Dans notre exemple, nous voulons changer de page lors du clic sur le bouton "suivant", il faut alors utiliser l'attribut "on" qui correspond à l'id du bouton et l'attribut "to" qui correspond à l'id de la vue appelé.
Voici à quoi ressemble le code de notre exemple : 
```
<transition on="next" to="updateEmail" />
```
Bien sur la vue appelée par cette transition n'existe pas encore, c'est à vous de la créer. :)
Pour créer un bouton "précédant", c'est exactement la même chose, rajoutez un bouton dans la vue JSP, et déclarez sa vue cible dans le fichier "flow.xml" grâce à la balise "\<transition />".

IX. Création d'une class de traitement du webflow
-------------------------------------------------
Une fois les différentes étapes construites, nous allons créer une class de traitement, cette class va récupérer toutes les informations produite par le webflow et va les enregistrer par exemple.
Dans notre exemple, nous les afficherons simplement dans les logs.
Créez une class Java et nommez la "ContactInfosHandler" par exemple. Cette class doit implémenter la class "Serializable".
Dans cette class, créer une méthode nommé "processContactInfos" par exemple. Cette class va traiter les données du webflow contenues dans l'objet que nous avons créer à l'étape VII. Donc le méthode doit prendre en paramêtre cet objet.
Pour déclarer le logger (l'objet qui permet d'afficher des informations dans les logs depuis une class Java), vous pouvez utiliser la ligne de code suivante:
```
Logger LOGGER = LoggerFactory.getLogger(ContactInfosHandler.class);
```
Pour logger des information, vous pouvez utiliser la ligne de code suivante:
```
LOGGER.info("proccesing contact infos : " + contactInfos.toString());
```
Une fois cette class de traitement créée, il faut la déclarer dans le fichier "flow.xml". Cette déclaration ce fait de la même manière que pour l'objet de l'étape VII :
Créez une balise "\<var />", ajoutez lui un attribut "name" qui sera le nom du bean et ajoutez lui un attribut "class" qui correspond au package de la class de traitement.
Voici la balis appliqué à notre exemple:
```
<var name="handler" class="fr.smile.tutorial.ContactInfosHandler"/>
```
Il faut en suite lier cette class à un bouton. 
Pour ce faire, créez un bouton dans votre vue, déclarer le dans le fichier "flow.xml", ajouter une balise "transition" et à l'intérieur de cette balise transition et à l'intérieur dans cette balise, créer une balise "\<evaluate />".
Cette balise doit comporter l'attribut "expression", la valeur de cet attribut doit se composer des informations suivante : "nom du bean du handler" + "\." + "nom de la méthode de traitement du webflow avec en paramêtre le nom du bean de l'objet".
Cette balise evaluate devrait ressembler au code qui suit:
```
<transition on="finish">
    <evaluate expression="handler.processContactInfos(contactInfos)" />
</transition>
```