Webflow dans Digital Factory
============================

Table des matières
------------------
* [Introduction](#introduction)
* [Présentation](#présentation)
* [Structure d'un webflow](#structure-dun-webflow)
* [Définition du composant Jahia](#définition-du-composant-jahia)
* [Mise en place de Webflow](#mise-en-place-de-webflow)
* [Vues et transitions](#vues-et-transitions)
* [Modèle](#modèle)
* [Traitements du webflow](#traitements-du-webflow)

## Introduction

Les webflows sont des formulaires complexes qui se présentent sur plusieurs étapes s'affichant sur plusieurs pages. 
Webflow n'est pas un nouveau concept mais une solution éprouvée de [Spring](http://projects.spring.io/spring-webflow/).
Sergiy Shyrkov (de Jahia) nous propose une [démo de Webflow](https://github.com/shyrkov/jahia-spring-webflow-showcase) qui fera un très bon complément.
Jahia nous offre aussi la transcription de la [présentation de Sergiy lors de Jahia One 2014](https://www.jahia.com/files/live/sites/jahiacom/files/Resources/docs/7.x/7.1/en/DF7.1_SPRING_WEB_FLOW.pdf).

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

### Modification de l'adresse email une fois modifiée

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

Un webflow fonctionnant sous Digital Factory se définit par plusieurs fichiers.
Il est important de comprendre le rôle de chacun de ces fichiers:

1. spring.xml : webflow faisant partie de la stack Spring, il nécessite un fichier de contexte où définir des beans
2. flow.xml : ce fichier xml va contenir le squelette de notre webflow, c'est à dire la liste et l'ordre des étapes du webflow ainsi que la définition des beans java utilisés par celui-ci. C'est le cœur de notre webflow.
3. views.jsp : ces fichiers vont contenir les vues utilisées par les différentes étapes de notre webflow. Dans ces vues il y aura le code HTML des différents formulaires.
3. Model.java : cette classe Java définit l'objet correspondant aux informations partagées par les différentes étapes du webflow. Dans notre exemple, il y aura les informations du compte telles que l'adresse email, les numéros de téléphone mobile et fixe.  
4. Handler.java : cette classe Java va contenir les traitements métiers appelés par le webflow. Dans notre exemple c'est cette classe qui va modifier un compte à partir des informations recueillies durant le webflow.

## Définition du composant Jahia

Pour commencer, nous allons déclarer notre composant ainsi que son namespace dans le fichier `definitions.cnd`
Ce fichier est localisé dans le dossier _src/main/resources/META-INF/_.

Nous allons créer deux namespaces dans ce fichier, un premier correspondant aux nodes types et un second correspondant aux mixins.

```jackrabbit
<wfnt = 'http://www.smile.fr/jahia/webflow/nt/1.0'>
<wfmix = 'http://www.smile.fr/jahia/webflow/mix/1.0'>
```

Ensuite, nous allons créer un mixin héritant de `jmix:droppableContent`, cela va nous permettre de créer une entrée de menu et de glisser-déposer notre composant dans une page.

```jackrabbit
[wfmix:webflowContent] > jmix:droppableContent mixin
```

Finalement, nous allons déclarer notre composant. Celui-ci va hériter de la mixin "wfmix:webflowContent" pour pouvoir être glissé-déposé, ainsi que du node type "jnt:content".

```jackrabbit
[wfnt:form] > jnt:content, wfmix:webflowContent
```
Sauvegardez et compilez. Le composant devrait donc apparaître dans la liste des contenus du mode édition de Jahia.

### Définition de la vue par défaut du composant

Dans le dossier "src/main/resources", nous allons créer une arboréscence contenant les différentes vues de notre composant.
Tout d’abord il faut créer un dossier correspondant au nom du composant. Le nom de ce dossier se compose de la manière suivante : "namespace du composant" + "_" + "nom du composant en camelCase"
Pour notre exemple, nous allons donc nommer ce dossier "wfnt\_form".
Dans ce dossier nous allons créer un dossier "html", ce dossier contiendra les vues html.
Nous pouvons déjà y créer le fichier form.jsp qui sera la vue par défaut.


## Mise en place de Webflow

Premièrement la configuration spring. Dans src/main/resources créer META-INF/spring/webflow.xml avec le contenu suivant :

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
        http://www.springframework.org/schema/mvc
        http://www.springframework.org/schema/mvc/spring-mvc-3.0.xsd">
    <mvc:annotation-driven conversion-service="springTypeConversionService"/>
    <bean id="messageSource" class="org.jahia.utils.i18n.ModuleMessageSource"/>
</beans>
```

Ces deux beans sont les utilitaires basiques lors de l'utilisation d'un webflow.
ModuleMessageSource permet l'utilisation des resource bundles pour l'internationalisation de vos vues.
SpringTypeConversionService permet la validation des valeurs renseignées par les utilisateurs au travers de vos formulaires.

Ensuite dans votre dossier de vue, créer un sous-dossier nommé de la manière suivante : nom du composant en camelCase + "." + nom du webflow + ".flow"
L’arborescence devrait donc ressembler à ça "src/main/resources/wfnt\_form/html/form.update.flow/".

Ce dossier contiendra d'une part les vues dédiées au webflow et d'autre part sa définition grâce au fichier flow.xml.

## Vues et transitions

### Configuration du webflow

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

Chaque étape du webflow sera à inclure dans la balise `<flow />` par ce code :

```xml
<view-state id="viewName" />    
```

La première étape de notre webflow sera la page de modification de l'email de l'utilisateur. 
Changez la valeur de l'id de la view-state en "step1" (c'est ainsi que nous y ferons référence par la suite).


### Création des premières vues

La vue par défaut du composant sera considérée comme notre point d'entrée (et de sortie) du webflow. 
Elle présentera un résumé des informations utilisateur et proposera un lien permettant d'entrer dans le webflow de modification.

Pour cette vue par défaut (form.jsp), nous pouvons utiliser ce code pour afficher les informations utilisateur :

```xml
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="well span6" style="float:none;margin:0 auto">
    <h2>Informations de contact</h2>
    <dl class="dl-horizontal">
        <dt>
            <fmt:message key="wfnt_form.email"/>
        </dt>
        <dd>
            <c:if test="${not empty currentUser.properties['j:email'] }">
                ${fn:escapeXml(currentUser.properties['j:email'])}
            </c:if>
        </dd>
        <dt>
            <fmt:message key="wfnt_form.phone"/>
        </dt>
        <dd>
        	<c:if test="${not empty currentUser.properties['j:phoneNumber'] }">
                ${fn:escapeXml(currentUser.properties['j:phoneNumber'])}
            </c:if>
        </dd>
        <dt>
            <fmt:message key="wfnt_form.mobile"/>
        </dt>
        <dd>
        	<c:if test="${not empty currentUser.properties['j:mobileeNumber'] }">
                ${fn:escapeXml(currentUser.properties['j:mobileeNumber'])}
            </c:if>
        </dd>
    </dl>
    
    <div class="pull-right">
        <c:url value='' var="updateUrl"/>
        <a class="btn btn-default" href="${updateUrl}"
           title="Modifier ces informations en commen&ccaron;ant un formulaire sur plusieurs &eacute;tapes">
            <fmt:message key="wfnt_form.label.update"/>
        </a>
    </div>
</div>
```

Pour la première étape du webflow, il s'agira d'afficher un formulaire permettant de modifier l'adresse email de l'utilisateur puis de passer à l'étape suivante.
Pour cela nous créons la vue step1.jsp dans le sous-dossier form.update.flow :

```xml
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:if test="${not empty currentNode.user.properties['j:email'].string }">
    <c:set var="filledEmail" value="${fn:escapeXml(currentNode.user.properties['j:email'].string)}"/>
</c:if>

<div class="well span6" style="float:none;margin:0 auto">
    <div class="clearfix">
        <div class="pull-right">
            <progress max="4" value="1">(Step 1 of 4)</progress>
        </div>
    </div>
    <form:form modelAttribute="contactInfo" class="form-horizontal" method="post">
        <fieldset>
            <legend>Modifier votre adresse email</legend>
            <%@ include file="validation.jspf" %>
            <div class="control-group">
                <label class="control-label" for="email">
                    <span class="hide-text">Modifier votre </span><fmt:message key="wfnt_form.email"/> :</label>

                <div class="controls">
                    <form:input type="email" id="email" name="email" value="${filledEmail}"/>
                </div>
            </div>
            <div class="form-actions">
                <button id="cancel" class="btn" type="submit" name="_eventId_cancel">
                    Annuler
                </button>

                <div class="pull-right">
                    <button class="btn btn-primary" type="submit">
                        Suivant
                    </button>
                </div>
            </div>
        </fieldset>
    </form:form>
</div>
```

Pour la séconde étape du webflow, il s'agira cette fois de modifier le numéro de téléphone de l'utilisateur.
Pour cela nous créons la vue step2.jsp dans le sous-dossier form.update.flow :

```xml
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:if test="${not empty currentNode.user.properties['j:phoneNumber'].string }">
    <c:set var="filledPhone" value="${fn:escapeXml(currentNode.user.properties['j:phoneNumber'].string)}"/>
</c:if>

<div class="well span6" style="float:none;margin:0 auto">
    <div class="clearfix">
        <div class="pull-right">
            <progress max="4" value="2">(Step 2 of 4)</progress>
        </div>
    </div>

    <form:form modelAttribute="contactInfo" class="form-horizontal" method="post">
        <fieldset>
            <legend>Modifier votre num&eacute;ro de t&eacute;l&eacute;phone</legend>
            <%@ include file="validation.jspf" %>
            <div class="control-group">
                <label class="control-label" for="phone"><fmt:message key="wfnt_form.phone"/> :</label>

                <div class="controls">
                    <form:input path="phone" type="tel" id="phone" name="phone" value="${filledPhone}"/>
                </div>
            </div>
            <div class="form-actions">
                <button class="btn" type="submit">
                    Annuler
                </button>

                <div class="pull-right">
                    <button class="btn" type="submit">
                        Pr&eacute;c&eacute;dent
                    </button>
                    <button class="btn btn-primary" type="submit">
                        Suivant
                    </button>
                </div>
            </div>
        </fieldset>
    </form:form>
</div>
```

### Démarrage du flow

Une fois l'application déployée vous pouvez voir la vue par défaut présentant les informations de l'utilisateur ainsi que le lien permettant de les éditer.
Cependant il nous reste à définir comment passer de cette vue à la première étape du webflow.
Jahia ne reconnaissant pas nativement le "format" webflow pour un composant, il faut importer dans le JCR un nouveau template. Celui sera associé à notre composant form et redirigera vers les vues de notre webflow.

Pour cela créer src/main/import/repository.xml avec ce contenu :

```xml
<?xml version="1.0" encoding="UTF-8"?>
<content xmlns:j="http://www.jahia.org/jahia/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0">
    <modules jcr:primaryType="jnt:modules">
        <webflow j:dependencies="default"
                 j:modulePriority="0"
                 j:moduleType="module"
                 j:title="webflow"
                 jcr:mixinTypes="jmix:hasExternalProviderExtension"
                 jcr:primaryType="jnt:module">
            <sources jcr:mixinTypes="jmix:hasExternalProviderExtension"
                     jcr:primaryType="jnt:moduleVersionFolder"
                     j:staticMountPointProviderKey="module-webflow-1.0-SNAPSHOT">
                <src jcr:primaryType="jnt:folder">
                    <main jcr:primaryType="jnt:folder">
                        <resources jcr:primaryType="jnt:folder">
                            <wfnt_form jcr:primaryType="jnt:nodeTypeFolder">
                                <html jcr:primaryType="jnt:templateTypeFolder">
                                    <form.update.flow jcr:primaryType="jnt:folder">
                                        <flow.xml jcr:primaryType="jnt:xmlFile"/>
                                    </form.update.flow>
                                        <form.jsp jcr:primaryType="jnt:viewFile"/>
                                </html>
                            </wfnt_form>
                            <META-INF jcr:primaryType="jnt:metaInfFolder">
                                <definitions.cnd jcr:primaryType="jnt:definitionFile"/>
                            </META-INF>
                        </resources>
                    </main>
                </src>
            </sources>

            <portlets jcr:primaryType="jnt:portletFolder"/>
            <files jcr:primaryType="jnt:folder"/>
            <contents jcr:primaryType="jnt:contentFolder"/>
            <templates j:rootTemplatePath="/base" jcr:primaryType="jnt:templatesFolder">
                <files jcr:primaryType="jnt:folder"/>
                <contents jcr:primaryType="jnt:contentFolder"/>
                <webflow-update j:applyOn="wfnt:form"
                                j:defaultTemplate="false"
                                j:hiddenTemplate="false"
                                jcr:primaryType="jnt:contentTemplate">
                    <j:translation_en j:workInProgress="false"
                                      jcr:language="en"
                                      jcr:mixinTypes="mix:title"
                                      jcr:primaryType="jnt:translation"
                                      jcr:title="webflow-update"/>
                    <pagecontent jcr:primaryType="jnt:contentList">
                        <main-resource-display j:mainResourceView="update"
                                               j:workInProgress="false"
                                               jcr:primaryType="jnt:mainResourceDisplay"/>
                    </pagecontent>
                </webflow-update>
            </templates>

        </webflow>
    </modules>
</content>
```

Ainsi nous créons le template "webflow-update" s'appliquant sur "wfnt:form" et redirigeant vers la view "update".

Dans form.jsp, modifier la partie se chargeant de l'affichage du lien pour pointer vers ce template.

```xml
<c:url value='${url.base}${currentNode.path}.webflow-update.html' var="updateUrl"/>
<a class="btn btn-default" href="${updateUrl}"
   title="Modifier ces informations en commen&ccaron;ant un formulaire sur plusieurs &eacute;tapes">
    <fmt:message key="wfnt_form.label.update"/>
</a>
```

Vous pouvez tester l'application. En utilisant ce template, Webflow se charge lui-même de rediriger vers la bonne vue et en l'occurence affichera step1.jsp.

### Création des premières transitions

Nous souhaitons maintenant passer de l'étape 1 à l'étape 2. Pour cela nous devons d'abord faire évoluer la définition du webflow dans flow.xml.
On définit une transition avec la balise <transition />. L'attribut "on" identifie l'action déclencheuse et "to" indique l'étape suivante.

```xml
<view-state id="step1" model="contactInfo">
    <transition on="next" to="step2"/>
</view-state>

<view-state id="step2" model="contactInfo">
    <transition on="previous" to="step1"/>
</view-state> 
```

Il y a donc deux transitions : step1 vers step2 sur "next" et step2 vers step1 sur "previous".
Voyons comment mentionner ces transition dans les sources.

step1.jsp
```xml
<button id="next" class="btn btn-primary" type="submit" name="_eventId_next">
    Suivant
</button>
```

step2.jsp
```xml
<button id="previous" class="btn" type="submit" name="_eventId_previous">
    Pr&eacute;c&eacute;dent
</button>
```

Il faut donc faire correspondre le "on" de la transition au name du boutton submit préfixé par "_eventId_".


### Création des vues et transitions restantes

Nous pouvons finaliser la partie navigation de l'application en ajoutant les vues et transitions manquantes.

Step3 permettra de modifier le numéro de téléphone portable de l'utilisateur et redirigera vers la vue summary.
Summary résumera les modifications soumises par l'utilisateur et sur validation redirigera vers la vue success.
Success affichera un message de succès et proposera un lien renvoyant sur la vue par défaut.

```xml
<view-state id="step2" model="contactInfo">
    <transition on="previous" to="step1"/>
    <transition on="next" to="step3"/>
</view-state>

<view-state id="step3" model="contactInfo">
    <transition on="previous" to="step2" />
    <transition on="next" to="summary" />
</view-state>

<view-state id="summary" model="contactInfo">
    <transition on="previous" to="step3" />
    <transition on="finish" to="success" />
</view-state>

<view-state id="success"/>
```

Il est aussi intéressant de proposer une étape d'annulation disponible à partir de toutes les vues.
On définit une transition globale grâce à la balise <global-transitions>.

```xml
<view-state id="cancel"/>

<global-transitions>
    <transition on="cancel" to="cancel" />
</global-transitions>
```

NB: Pour retourner sur la vue par défault, il suffira par exemple de pointer sur la page actuelle sans paramètre :
```xml
<c:url value="${page.url}" var="cancelUrl"/> 
```

## Modèle

Pour le moment les valeurs de nos formulaires ne sont pas sauvegardées. Pour ce faire nous allons avoir besoin d'une couche modèle.

Créez une nouvelle class Java dans un sous package *.model et nommez la "ContactInfo.java" par exemple.
Cette classe doit implémenter la class Serializable pour pouvoir être stockée.
Créez les champs dont vous aurez besoin, il vous faut une variable pour chaque champ présent dans le formulaire.
Générez les getter et setter correspondant ainsi que la méthode "toString()".

Maintenant nous allons instancier et rendre disponible cette classe dans le "flow.xml".
Créez une balise "<var />" contenant un attribut "name" et un attribut "class". L'attribut "name" va correspondre au nom du bean et l'attribut "class" va correspondre au nom de la classe.

Le code de la balise complète:
```xml
<var name="contactInfo" class="fr.smile.jahia.model.ContactInfo"/>
```

Ce bean est maintenant accessible par nos formulaires. Pour chacun d'entre eux nous allons pouvoir binder des champs de formulaire aux champs de cet objet :
```xml
<form:form modelAttribute="contactInfo" class="form-horizontal" method="post"> 
...
<form:input path="email" type="email" id="email" name="email" value="${filledEmail}"/>	
```

Ici le champ email du formulaire renseigner le champs email du bean contactInfo.
Faites bien attention à faire correspondre la valeur de l'attribut `name` avec la valeur de l'attribut `modelAttribute` utilisée dans la vue.

Modifiez les trois formulaires du webflow pour que leurs valeurs soient stockées correctement dans contactInfo.

NB : si pour certaines transitions le binding formulaire-bean n'est pas souhaité, on peut doit le préciser : 
```xml
<view-state id="step2" model="contactInfo">
    <transition on="previous" to="step1"/>
    <transition on="next" to="step3"/>
</view-state>
```

## Traitements du Webflow

Une fois les différentes étapes construites et notre objet modèle correctement peuplé, nous allons créer une classe de traitement chargée de mettre à jour l'utilisateur.

Créez une classe Java dans un package *.handler et nommez la `ContactInfoHandler`. Cette classe doit implémenter la classe `java.io.Serializable`.
Dans cette classe, créer une méthode nommée "update".
Cette méthode va traiter les données du webflow contenues dans l'objet que nous avons créé, elle doit donc prendre en paramètre cet objet.
Il peut également être intéressant de passer les informations du node Jahia courant afin de bénéficier de son contexte.

```java
public void update(final ContactInfo contactInfo, final JCRNodeWrapper formNode)
```

N'hésitez pas à déclarer un logger pour controler l'appel de la méthode update:

```java
private static final Logger logger = LoggerFactory.getLogger(ContactInfoHandler.class);

logger.debug("Updating contact information : " + contactInfo.toString());
```

Une fois cette classe de traitement créée, il faut la déclarer dans le fichier `flow.xml`.  
Cette déclaration se fait de la même manière que pour l'objet contactInfo.  
* Créez une balise `<var />` 
* Ajoutez lui un attribut `name` qui sera le nom du bean 
* Ajoutez lui un attribut `class` qui correspond à la classe de traitement.

```xml
	
	<var name="handler" class="fr.smile.jahia.handler.ContactInfoHandler"/>
```

Il faut ensuite lier cette méthode `update()` à une de vos transitions. 
Pour ce faire, dans le fichier "flow.xml" et à l'intérieur de la balise `<transition/>` souhaitée, ajoutez une balise `<evaluate />`.
Cette balise doit comporter l'attribut `expression` qui indique le bean et la méthode à appeler.
Ici nous allons modifier la transition finish de la vue summary.

```xml

	<view-state id="summary" model="contactInfo">
	    <transition on="previous" to="step3" bind="false"/>
	    <transition on="finish" to="success" bind="false">
	        <evaluate
	                expression="handler.update(contactInfo, externalContext.nativeRequest.getAttribute('currentResource').node)"/>
	    </transition>
	</view-state>
```

Complétez le corps de la méthode update pour mettre à jour l'utilisateur Jahia courant.
