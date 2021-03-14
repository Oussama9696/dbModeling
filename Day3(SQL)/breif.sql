-- Exercice #1
-- Soit la base de données suivante :

-- Départements :( DNO, DNOM, DIR, VILLE)
-- Employés : ( ENO, ENOM, PROF, DATEEMB, SAL, COMM, #DNO)
-- Exprimez en SQL les requêtes suivantes:


-- Reponse:::


-- Donnez la liste des employés ayant une commission.
SELECT * 
FROM Employés 
WHERE COMM NOT NULL;

-- Donnez les noms, emplois et salaires des employés par emploi croissant, et pour chaque emploi, par salaire décroissant.
SELECT ENOM, PROF, SAL  
FROM Employés
ORDER BY PROF {ASC}, SAL {DESC};

-- Donnez le salaire moyen des employés.
SELECT AVG(SAL)
FROM Employés

-- Donnez le salaire moyen du département Production.
SELECT AVG(SAL) 
FROM Employes INNER JOIN Departement
ON Employés.DNO=Departement.DNO 
WHERE Departement.DNOM = "production"


-- Donnes les numéros de département et leur salaire maximum.

SELECT DNO, MAX(SAL) 
FROM Employes GROUP BY DNO

-- Donnez les différentes professions et leur salaire moyen.

SELECT PROF, AVG(SAL) 
FROM Employes GROUP BY PROF

-- Donnez le salaire moyen par profession le plus bas.

SELECT PROF, AVG(SAL)
FROM Employes 
GROUP BY PROF 
ORDER BY AVG(SAL) ASC
LIMIT 1

-- Donnez le ou les emplois ayant le salaire moyen le plus bas, ainsi que ce salaire moyen.
SELECT PROF FROM Employes GROUP BY PROF
HAVING AVG(SAL)=(SELECT AVG(SAL) FROM Employes
GROUP BY PROF ORDER BY AVG(SAL) ASC LIMIT 1);

-- Exercice #2
-- Soit la base de données intitulée "gestion_projet" permettant de gérer les projets relatifs au développement de logiciels. Elle est décrite par la représentation textuelle simplifiée suivante :

-- Developpeur (NumDev, NomDev, AdrDev, EmailDev, TelDev)
-- Projet (NumProj, TitreProj, DateDeb, DateFin)
-- Logiciel (CodLog, NomLog, PrixLog, #NumProj)
-- Realisation (#NumProj, #NumDev)
-- Ecrire les requêtes SQL permettant :





-- D’afficher les noms et les prix des logiciels appartenant au projet ayant comme titre « gestion de stock », triés dans l’ordre décroissant des prix.
SELECT NomLog, PrixLog
FROM Logiciel
WHERE #NumProj in
(SELECT #NumProj 
FROM Projet  
WHERE TitreProj = 'gestion de stock');
ORDER BY PrixLog {DESC}
   
-- D’afficher le total des prix des logiciels du projet numéro 10. Lors de l’affichage, le titre de la colonne sera « cours total du projet ».
SELECT SUM(PrixLog) as 'cours total du projet' 
FROM Logiciel
WHERE NumProj = 10;

-- Afficher le nombre de développeurs qui ont participé au projet intitulé « gestion de stock »
SELECT SUM(NumDev)
FROM Realisation
WHERE NumProj in
(SELECT NumProj 
FROM Projet
WHERE TitreProj = 'gestion de stock');

-- Afficher les projets qui ont plus que 5 logiciels.
SELECT *
FROM Projet
WHERE NumProj in
(SELECT #NumProj
FROM Logiciel
WHERE SUM(#NumProj) > 5);

-- Les numéros et noms des développeurs qui ont participés dans tout les projets.

SELECT NumDev, NomDev
FROM Developpeur
WHERE NumDev in
(SELECT #NumProj 
FROM Realisation
WHERE #NumProj in
(SELECT ))

-- Les numéros de projets dans lesquelles tous les développeurs y participent dans sa réalisation.
