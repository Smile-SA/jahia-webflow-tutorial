Tutorial Webflow Jahia
======================

I. Introduction
---------------
Ce tutoriel nécessite une connaissance des concepts Jahia basiques tels que la création de vues ou l'édition de pages.
L'objectif de de tutoriel est de vous apprendre à réaliser des webflows sous Jahia 7.1. 
Les webflows sont des formulaires complexes qui comportent plusieurs étapes et qui s'étendent donc sur plusieurs pages web. 
Ils sont très souvent utilisés dans les projets Jahia, il est donc très important de les maîtriser. 

Pour illustrer ce tutoriel, nous prendrons comme exemple une création de compte en plusieurs étapes.

II. La structure d'un webflow
-----------------------------
Un webflow sous Jahia comporte plusieurs fichiers principaux qu'il est important de connaître.
Il est important de comprendre le rôle de chacun de ces fichiers:
1. flow.xml : ce fichier xml va contenir le squelette de notre webflow ainsi que la définition des beans java utilisés par celui-ci. C'est le cœur de notre webflow.
2. *.jsp : ces fichiers vont contenir les vues utilisées par les différentes étapes de notre webflow. Dans ces vues il y aura le code HTML des différents formulaires.
3. handler.java : cette class Java va contenir le traitement appelé à la fin du webflow. Dans notre exemple c'est cette class qui va créer un compte à partir des informations recueillis depuis le weblflow.
4. infos.java : cette class Java va contenir un simple objet correspondant aux informations partagées par les différentes étapes du webflow. Dans notre exemple, il y aura informations du compte tel que le nom de l'utilisateur, le prénom, l'adresse email, le numéro de téléphone etc...  


```
<snt = 'http://www.smile.fr/jahia/nt/1.0'>
<smix = 'http://www.smile.fr/jahia/mix/1.0'>
```