Tutorial Webflow Jahia
======================

I. Introduction
---------------
Ce tutoriel nécessite une connaissance des concepts Jahia basiques tels que la création de vues ou l'édition de pages.
L'objectif de de tutoriel est de vous apprendre à réaliser des webflows sous Jahia 7.1. 
Les webflows sont des formulaires complexes qui comportent plusieurs étapes et qui s'étendent donc sur plusieurs pages web. 
Ils sont très souvent utilisés dans les projets Jahia, il est donc très important de les maîtriser. 

Pour réaliser ce tutoriel, je me suis basé sur cet exemple : https://github.com/shyrkov/jahia-spring-webflow-showcase

Pour illustrer ce tutoriel, nous prendrons comme exemple une démarche de mise à jour d'informations de contact.
Commencez donc par créer un templateSet sous Jahia.

II. La structure d'un webflow
-----------------------------
Un webflow sous Jahia comporte plusieurs fichiers principaux qu'il est important de connaître.
Il est important de comprendre le rôle de chacun de ces fichiers:
1. flow.xml : ce fichier xml va contenir le squelette de notre webflow, c'est à dire la liste et l'ordre des étapes du webflow ainsi que la définition des beans java utilisés par celui-ci. C'est le cœur de notre webflow.
2. *.jsp : ces fichiers vont contenir les vues utilisées par les différentes étapes de notre webflow. Dans ces vues il y aura le code HTML des différents formulaires.
3. handler.java : cette class Java va contenir le traitement appelé à la fin du webflow. Dans notre exemple c'est cette class qui va créer un compte à partir des informations recueillis depuis le weblflow.
4. infos.java : cette class Java va contenir un simple objet correspondant aux informations partagées par les différentes étapes du webflow. Dans notre exemple, il y aura informations du compte tel que l'adresse email, le numéro de téléphone mobile et fixe.  

III. Déclaration du composant
-----------------------------
Tout d'abord, nous allons commencer par déclarer notre composant ainsi que sont namespace dans le fichier definition.cnd
Rappel : le fichier defintion.cnd est localisé dans le dossier src/main/resources/META-INF/
Nous allons créer deux namespace dans ce fichier, un namespace correspondant aux node types de smile et un namespace correspondant aux mixins de smile.
Copier-collez le code suivant dans votre fichier definition.cnd:
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