Digital Factory et Webflow
==========================

## Introduction

Les webflows sont des formulaires complexes qui se présentent sur plusieurs étapes s'affichant sur plusieurs pages. 
Webflow n'est pas un nouveau concept mais une solution éprouvée de [Spring](http://projects.spring.io/spring-webflow/).
Sergiy Shyrkov (de Jahia) nous propose une [démo de Webflow](https://github.com/shyrkov/jahia-spring-webflow-showcase) qui fera un très bon complément à cette présentation.

Cette présentation nécessite une connaissance des concepts Jahia basiques tels que la création de vues et la contribution.
L'objectif est d'apprendre à réaliser des webflows sous Digital Factory de Jahia. 

La grande force de Digital Factory est qu'elle fait partie des CMS où l'on maitrise 100% du code généré, 
nous en profiterons pour produire des formulaires accessibles pendant cette présentation.

## Présentation

Nous prendrons comme exemple une démarche de mise à jour d'informations de contact de l'utilisateur courant sur plusieurs étapes.

### Vue par défaut

![Vue par défaut](doc/1.png)  

### Modification de l'adresse email

![Première étape de modification, l'adresse email](doc/2.png)

### Modification de l'adresse email modifiée

![Première étape de modification, l'adresse email modifiée](doc/3.png)  

### Modification du numéro de téléphone fixe

![Deuxième étape de modification, le numéro de téléphone fixe](doc/4.png)

### Modification du numéro de téléphone mobile

![Troisième étape de modification, le numéro de téléphone mobile](doc/5.png)  

### Vérification

![Quatrième étape, la vérification](doc/6.png)

### Confirmation

![Confirmation des modifications](doc/7.png)  

### Vue par défaut modifiée

![Vue par défaut modifiée](doc/8.png)

### Annulation

A tout moment, dans le processus, il sera possible d'annuler nos modifications.

![Annulation des modifications](doc/7b.png)

## Structure d'un webflow

Un webflow fonctionnant sous Digital Factory se défini par plusieurs fichiers.
Il est important de comprendre le rôle de chacun de ces fichiers:
1. Model.java : cette classe Java va contenir un objet correspondant aux informations partagées par les différentes étapes du webflow. Dans notre exemple, il y aura informations du compte tel que l'adresse email, le numéro de téléphone mobile et fixe.  
2. view.jsp : ces fichiers vont contenir les vues utilisées par les différentes étapes de notre webflow. Dans ces vues il y aura le code HTML des différents formulaires.
3. flow.xml : ce fichier xml va contenir le squelette de notre webflow, c'est à dire la liste et l'ordre des étapes du webflow ainsi que la définition des beans java utilisés par celui-ci. C'est le cœur de notre webflow.
4. Handler.java : cette classe Java va contenir le traitement appelé à la fin du webflow. Dans notre exemple c'est cette classe qui va créer un compte à partir des informations recueillis depuis le weblflow.

## Définitions

Pour commencer, nous allons déclarer notre composant ainsi que son namespace dans le fichier `definitions.cnd`
Ce fichier est localisé dans le dossier _src/main/resources/META-INF/_.

Nous allons créer deux namespaces dans ce fichier, un premier correspondant aux node types et un second correspondant aux mixins.

```jackrabbit
<wfnt = 'http://www.smile.fr/jahia/webflow/nt/1.0'>
<wfmix = 'http://www.smile.fr/jahia/webflow/mix/1.0'>
```

Ensuite, nous allons créer une mixin héritant de `jmix:droppableContent`, cela va nous permettre de créer une entrée de menu et de glisser-déposer notre composant dans une page.

```jackrabbit
[wfmix:webflowContent] > jmix:droppableContent mixin
```

Finalement, nous allons déclarer notre composant, ce composant va hériter de la mixine "smix:smileContent" pour pouvoir être glisé-déposé ainsi que du node type "jnt:content".

```jackrabbit
[wfnt:form] > jnt:content, wfmix:webflowContent
```
Sauvegardez et compilez. Le composant devrait donc apparaître dans la liste des contenus du mode édition.

## Arborescence

Dans le dossier "src/main/resources", nous allons créer une arboréscence correspondant à notre composant.
Tout d’abord il faut créer un dossier correspondant au nom du composant. Le nom de ce dossier se compose de la manière suivante : "namespace du composant" + "_" + "nom du composant en camelCase"
Pour notre exemple, nous allons donc nommer ce dossier "snt\_updateContactInfos".
Dans ce dossier nous allons créer un dossier "html", ce dossier contiendra les vues html.
Finalement, nous allons créer dans ce dossier, un dernier dossier nommé de la manière suivante : "nom du composant en camelCase" + "." + "flow"
L’arborescence devrait donc ressembler à ça "src/main/resources/snt\_updateContactInfos/html/updateContactInfos.flow/".

## Définition du webflow

Dans le dossier _src/main/resources/wf_form/html/form.update.flow/", 
créez un fichier nommé `flow.xml`.

Voici le code de base du webflow:

```xml
<?xml version="1.0" encoding="UTF-8"?>
    <flow xmlns="http://www.springframework.org/schema/webflow" 
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
            xsi:schemaLocation="http://www.springframework.org/schema/webflow 
                                http://www.springframework.org/schema/webflow/spring-webflow-2.0.xsd">
</flow>
```

Les étapes du webflow seront incluses dans la balise `<flow />`.

```xml
<view-state id="viewName" />    
```

Pensez bien à modifier la valeur de l'attribut `id` car il va correspondre à notre vue. 
La première étape de notre webflow sera une page récapitulative des informations de contact. 
Changez donc la valeur de l'id de la view-state en "step1".

## Création des vues

Nous allons maintenant créer une vue JSP correspondante à l'étape que nous avons créée dans le "flow.xml"
Créez un fichier dans le même dossier que le "flow.xml" et nommez le de la même manière que l'id de l'étape précédemment créée.
Cette vue JSP va donc contenir le code HTML du formulaire. Vous pouvez vous inspirer de l'exemple ce code suivant:

```java
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

Nous pouvons voir que la balise "form" contient un attribut nommé "modelAttribute". 
La valeur de cet attribut correspond à l'id du bean spring utilisé pour stocker les informations du webflow.
Pour l'instant, nous n'avons encore déclaré aucun bean nommé "contactInfo" donc si vous affichez la page, 
il y aura une erreur.

## Model

Créez une nouvelle class Java dans le dossier "src/main/java" et nommez la "ContactInfos.java" par exemple.
Cette class doit étendre la class Serializable pour pouvoir être stocké.
Créez les variables dont vous aurez besoin, il vous faut une variable pour chaque champs de formulaire présent dans le webflow.
Générez les getter et setter correspondant ainsi que la méthode "toString()".
Maintenant nous allons déclarer cette class dans le "flow.xml". 
Créez une balise fermente "\<var />" contenant un attribut "name" et un attribut "class". L'attribut "name" va correspondre au nom du bean et l'attribut "class" va correspondre au nom de la class.
Voici le code de la balise complète:

```xml
<var name="contactInfo" class="fr.smile.jahia.model.ContactInfo"/>
```
Faites bien attention à bien faire correspondre la valeur de l'attribut `name` 
avec la valeur de l'attribut `modelAttribute` utilisée dans la vue.

## Navigation

Pour créer un bouton "finish" par exemple il faut rajouter le code HTML du bouton 
dans la vue souhaitée pour qu'il apparaisse et il faut définir son action dans le `flow.xml`.
Dans votre vue, ajouter un bouton `<button type "submit" />` possédant un ID bien défini, par exemple "next".
Il est également important d'ajouter un attribut "name" 
dont la valeur est composé de la manière suivante : "_eventId_" + "id du button".

```html
<button id="finish" type="submit" name="_eventId_finish">Finish</button>
```

Dans le fichier `flow.xml`, dans la balise `<view-state />` correspondant à votre vue, 
insérez une balise `<transition />`.
Cette balise va lier une action à un bouton correspondant dans une vue. 
Dans notre exemple, nous voulons changer de page lors du clic sur le bouton "suivant", 
il faut alors utiliser l'attribut `on` qui correspond à l'ID du bouton 
et l'attribut `to` qui correspond à l'ID de la vue appelée.

Voici à quoi ressemble le code de notre exemple : 

```xml
<transition on="next" to="step2" />
```

Bien sur la vue appelée par cette transition n'existe pas encore, c'est à vous de la créer. :)

Pour créer un bouton "précédant", c'est exactement la même chose, rajoutez un bouton dans la vue JSP, et déclarez sa vue cible dans le fichier "flow.xml" grâce à la balise `<transition />`.

## Traitement du webflow

Une fois les différentes étapes construites, nous allons créer une class de traitement, cette class va récupérer toutes les informations produite par le webflow et va les enregistrer par exemple.

Créez une classe Java et nommez la `ContactInfosHandler`.  
Cette classe doit implémenter la classe `java.io.Serializable`.
Dans cette classe, créer une méthode nommée "update()" par exemple.

Cette class va traiter les données du webflow contenues dans l'objet que nous avons créé. 
Donc le méthode doit prendre en paramètre cet objet.

```java
private static final Logger logger = LoggerFactory.getLogger(ContactInfoHandler.class);
```

Pour logger des information, vous pouvez utiliser la ligne de code suivante:

```java
logger.debug("Updating contact information : " + contactInfo.toString());
```

Une fois cette classe de traitement créée, il faut la déclarer dans le fichier `flow.xml`.  
Cette déclaration se fait de la même manière que pour l'objet.  
* Créez une balise `<var />` 
* Ajoutez lui un attribut `name` qui sera le nom du bean 
* Ajoutez lui un attribut `class` qui correspond à la classe de traitement.

```xml
  <var name="handler" class="fr.smile.jahia.handler.ContactInfoHandler"/>
```

Il faut ensuite lier cette méthode `update()` à un bouton. 
Pour ce faire, créez un bouton dans votre vue, déclarer le dans le fichier "flow.xml", 
Ajoutez une balise `<transition/>` et à l'intérieur de celle-ci, ajoutez une balise `<evaluate />`.
Cette balise doit comporter l'attribut `expression`.

```xml
<view-state id="summary" model="contactInfo">
    <transition on="previous" to="step3" bind="false"/>
    <transition on="finish" to="success" bind="false">
        <evaluate
                expression="handler.update(contactInfo, externalContext.nativeRequest.getAttribute('currentResource').node)"/>
    </transition>
</view-state>
```