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

IV. Création de l'arboréscence
------------------------------
Dans le dossier "src/main/ressources", nous allons créer une arboréscence correspondant à notre composant.
Tout d'abbord il faut créer un dossier correspondant au nom du composant. Le nom de ce dossier se compose de la manière suivante : "namespace du composant" + "_" + "nom du composant en camelCase"
Pour notre exemple, nous allons donc nommer ce dossier "snt_updateContactInfos".
Dans ce dossier nous allons créer un dossier "html", ce dossier contiendra les vues html.
Finallement, nous allons créer dans ce dossier "html" nommé de la manière suivante : "nom du composant en camelCase" + "." + "flow"
L'arboréscence devrait donc ressembler à ça "src/main/ressources/snt_updateContactInfos/html/updateContactInfos.flow/".

V. Création du flow.xml
------------------------

