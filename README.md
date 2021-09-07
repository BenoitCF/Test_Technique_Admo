# Test_Technique_Admo
Les scripts que j'ai fourni sont le fruit de ma réflexion concernant le test technique pour Admo TV concernant le poste d'alternant Infra et Support Engineer. 

Le premier script concerne la sauvegarde de toutes les bases de données d'un système. il permet aussi d'envoyer un fichier à une machine étrangère en utilisant SCP. 
L'envoie est soumis à des tests de connexion. 
Si l'envoi échoue un mail est envoyé à l'administrateur pour l'informer de la situation. 


Le deuxieme script, un ansible playbook permet d'installer et de configurer Nginx pour Ubuntu. le script déroule toutes les taches à effectuer pour avoir une installation complète. 
Le script crée aussi un utilisateur Worldy et un fichier texte dans le home directory de cet utilisateur. 

Voila le fruit de mon travail j'espère qu'il sera à la hauteur de vos attentes 



J'ai donc apporté des modifications au code j'ai pull un nouveau fichier Test. J'ai ajouté une variable qui permet de vérifier l'état du test pour savoir si il faut envoyer un mail ou non à l'admin. 
J'espère que les changements seront apprécier.
