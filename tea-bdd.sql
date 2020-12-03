set datestyle to 'european'; 

DROP TABLE IF EXISTS trajets;
DROP TABLE IF EXISTS vehicules;
DROP TABLE IF EXISTS factures;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS carburants;


CREATE TABLE clients (
  noclient INTEGER
    CHECK (noclient > 100), 
  nom VARCHAR(30) NOT NULL , 
  prenom VARCHAR(30), 
  adresse VARCHAR(50) NOT NULL, 
  PRIMARY KEY(noclient)
);

CREATE TABLE factures(
  nofacture INTEGER NOT NULL , 
  datefacture DATE NOT NULL , 
  etat CHAR(1) NOT NULL
    DEFAULT 'C' CHECK (etat IN ('R', 'C')), 
  PRIMARY KEY(nofacture)
);

CREATE TABLE carburants(
  codecarburant CHAR(5) NOT NULL
    CHECK (codecarburant LIKE 'CRB__'), 
  pxcarburant FLOAT NOT NULL, 
  PRIMARY KEY (codecarburant)
);

CREATE TABLE vehicules (
  referencevhc CHAR(5) NOT NULL
    CHECK (referencevhc LIKE 'VHC__'), 
  marque VARCHAR(50) NOT NULL, 
  prixlocation NUMERIC(9, 2) NOT NULL, 
  litrereservoir INTEGER NOT NULL, 
  codecarburant CHAR(5) NOT NULL
    CHECK ( codecarburant LIKE 'CRB%'),
  PRIMARY KEY(referencevhc),
  FOREIGN KEY (codecarburant) REFERENCES carburants

);

CREATE TABLE trajets ( 
  notrajet INTEGER NOT NULL , 
  nomstandardiste VARCHAR(30) NOT NULL,
  jours INTEGER NOT NULL ,
  kilometragedebut INTEGER NOT NULL ,
  kilometragefin INTEGER NOT NULL ,
  noclient INTEGER NOT NULL , 
  nofacture INTEGER NOT NULL ,
  referencevhc CHAR(5) NOT NULL
    CHECK (referencevhc LIKE 'VHC%'),
  PRIMARY KEY (notrajet), 
  FOREIGN KEY (noclient) REFERENCES clients, 
  FOREIGN KEY (nofacture) REFERENCES factures, 
  FOREIGN KEY (referencevhc) REFERENCES vehicules 
);




INSERT INTO clients VALUES ( 101, 'Arnaud', 'Jean', '12 rue des pains');
INSERT INTO clients VALUES ( 102, 'Elleau', null, '2 rue des buches');
INSERT INTO clients VALUES ( 103, 'Junior', 'Julien', '43 rue Albert Comboire');
INSERT INTO clients VALUES ( 104, 'Cassi', 'Amandine', '67 rue du Guilleau');
INSERT INTO clients VALUES ( 105, 'François', null, '10 rue des fleurs');


INSERT INTO factures VALUES ( 1000, '07/01/2010', 'R');
INSERT INTO factures VALUES ( 1001, '23/02/2010', 'R');
INSERT INTO factures VALUES ( 1002, '04/05/2010', 'R');
INSERT INTO factures VALUES ( 1003, '12/04/2010', 'R');
INSERT INTO factures VALUES ( 1004, '22/07/2010', 'R');
INSERT INTO factures VALUES ( 1005, '17/06/2010', 'R');
INSERT INTO factures VALUES ( 1006, '26/06/2010', 'R');
INSERT INTO factures VALUES ( 1007, '08/07/2010', 'R');
INSERT INTO factures VALUES ( 1008, '23/07/2010', 'R');
INSERT INTO factures VALUES ( 1009, '15/08/2010', 'C');
INSERT INTO factures VALUES ( 1010, '07/07/2010', 'C');
INSERT INTO factures VALUES ( 1011, '25/08/2010', 'C');
INSERT INTO factures VALUES ( 1012, '02/08/2010', 'R');
INSERT INTO factures VALUES ( 1013, '28/08/2010', 'R');


INSERT INTO carburants VALUES ('CRB01', 1.476);
INSERT INTO carburants VALUES ('CRB02', 1.345);
INSERT INTO carburants VALUES ('CRB03', 1.237);
INSERT INTO carburants VALUES ('CRB04', 1.783);



INSERT INTO vehicules VALUES ( 'VHC01', 'Burstner', 300, 40, 'CRB01');
INSERT INTO vehicules VALUES ( 'VHC11', 'Pilote', 1000, 90, 'CRB01');
INSERT INTO vehicules VALUES ( 'VHC41', 'Challenger', 400, 30,'CRB03');
INSERT INTO vehicules VALUES ( 'VHC22', 'Autostar', 200, 36, 'CRB04');
INSERT INTO vehicules VALUES ( 'VHC56', 'Chausson', 150, 50,'CRB02');
INSERT INTO vehicules VALUES ( 'VHC34', 'Benimar', 450, 90, 'CRB02');
INSERT INTO vehicules VALUES ( 'VHC12', 'Rapido', 450, 90,'CRB03');
INSERT INTO vehicules VALUES ( 'VHC89', 'McLouis', 300, 65,'CRB03');
INSERT INTO vehicules VALUES ( 'VHC67', 'Adria', 300, 80, 'CRB04');
INSERT INTO vehicules VALUES ( 'VHC02', 'Bavaria', 300, 85,'CRB02');
INSERT INTO vehicules VALUES ( 'VHC93', 'Dethleffs', 150, 75, 'CRB02');



INSERT INTO  trajets VALUES ( 1039, 'Eric', 3, 120500, 122550, 104, 1003,'VHC01');
INSERT INTO  trajets VALUES ( 1040, 'Eric', 4, 130500, 134550, 103, 1004, 'VHC11');
INSERT INTO  trajets VALUES ( 1041, 'Jason', 6, 121700, 123550, 104, 1003,'VHC22');
INSERT INTO  trajets VALUES ( 1042, 'Eric', 7, 150460, 153750, 102, 1002,'VHC89');
INSERT INTO  trajets VALUES ( 1043, 'Brian', 3, 142640, 145560, 101, 1001, 'VHC67');
INSERT INTO  trajets VALUES ( 1044, 'Brian', 5, 120700, 122850, 101, 1010, 'VHC67');
INSERT INTO  trajets VALUES ( 1045, 'Paul', 8, 183050, 187150, 105, 1006, 'VHC02');
INSERT INTO  trajets VALUES ( 1046, 'Jason', 6, 111470, 116250, 105, 1008,'VHC01');
INSERT INTO  trajets VALUES ( 1047, 'Jason', 13, 154302, 158550, 104, 1009,'VHC56');
INSERT INTO  trajets VALUES ( 1048, 'Jason', 8, 120500, 122450, 102, 1009,'VHC56');
INSERT INTO  trajets VALUES ( 1049, 'Brian', 10, 167560, 170030, 101, 1004,'VHC01');
INSERT INTO  trajets VALUES ( 1050, 'Eric', 12, 133400, 135664, 102, 1004,'VHC12');
INSERT INTO  trajets VALUES ( 1051, 'Paul', 3, 143340, 146540, 103, 1007,'VHC12');
INSERT INTO  trajets VALUES ( 1052, 'Paul', 5, 120310, 125110, 101, 1009,'VHC89');


--------------------------------------------------------------------------------------------------------------------

--moyenne des jours parti, le max de jour, le min de jour--
select ROUND(AVG(jours), 2) as moyenne_des_jours_partis, MIN(jours) as minimum_de_jours, MAX(jours) as maximum_de_jours from trajets


--combiende stardardistes différents--
select COUNT(DISTINCT nomstandardiste) as nbre_standard from trajets 

--autonomie de chaque vehicule sachant que la consommation moyenne est de 4 litres au 100km --
select vehicules.referencevhc, SUM((100*litrereservoir)/4) from vehicules
GROUP BY referencevhc


--nofcature 1003 et 1007 avec le nbr de trajets les concernants--
select nofacture, COUNT(nofacture) AS nbre_trajet from trajets where nofacture = '1003' OR nofacture = '1007'
GROUP BY nofacture 
ORDER BY nofacture

-- le code carburant avec le nb de vehicule l'utilisant--
select carburants.codecarburant, COUNT(referencevhc) as nb_vehicule
FROM carburants
join vehicules on vehicules.codecarburant = carburants.codecarburant
GROUP BY carburants.codecarburant


--clients et leur nbr de trajets respectifs--
select clients.nom, clients.noclient, COUNT(notrajet) FROM clients
join trajets on trajets.noclient = clients.noclient
GROUP BY clients.noclient

--prix d'un plein pour chaque vehicule supérieur ou égale à 100 et combien de trajet il y eu pour ces vehicules-- A REVOIR
select vehicules.referencevhc, SUM(carburants.pxcarburant*vehicules.litrereservoir) as px_plein, COUNT(notrajet) as nbr_de_trajet from carburants
join vehicules on vehicules.codecarburant = carburants.codecarburant
join trajets on trajets.referencevhc = vehicules.referencevhc
GROUP BY vehicules.referencevhc
HAVING SUM(carburants.pxcarburant*vehicules.litrereservoir) >= 100

--kilometre parcouru pour chaque chaque trajets de chaques clients---
select clients.nom, notrajet, SUM(trajets.kilometragefin-trajets.kilometragedebut) as km_parcouru from trajets
join clients on clients.noclient = trajets.noclient
GROUP BY notrajet, clients.nom
ORDER BY clients.nom, notrajet


--le px total pour chaque trajet de chaques client, son nofacture, l'état de sa facture | (jour*pxlocation)+((distance/autonomie)*px_d'un_plein)--
select clients.nom, vehicules.referencevhc, vehicules.marque, notrajet, (jours*prixlocation)+ROUND( SUM(trajets.kilometragefin-trajets.kilometragedebut)/SUM((100*litrereservoir)/4) * SUM(carburants.pxcarburant*vehicules.litrereservoir)) as total_px_trajet, factures.etat 
from trajets
join vehicules on vehicules.referencevhc = trajets.referencevhc
join clients on clients.noclient = trajets.noclient
join factures on factures.nofacture = trajets.nofacture
join carburants on carburants.codecarburant = vehicules.codecarburant
GROUP BY factures.etat, clients.nom, notrajet, vehicules.referencevhc, vehicules.marque
ORDER BY clients.nom, vehicules.marque, notrajet


--afficher le nofacture, la datefacture et le nom des clients François et Cassi--
select factures.nofacture, factures.datefacture, clients.nom from factures
join trajets on trajets.nofacture = factures.nofacture
join clients on clients.noclient = trajets.noclient
WHERE clients.nom = 'François'
UNION 
select factures.nofacture, factures.datefacture, clients.nom from factures
join trajets on trajets.nofacture = factures.nofacture
join clients on clients.noclient = trajets.noclient
WHERE clients.nom = 'Cassi'
ORDER BY nom, nofacture

--le plus petit prix de location avec le réservoir le plus grand--
  --select referencevhc, marque, MIN(prixlocation) from vehicules WHERE litrereservoir >= ALL (select litrereservoir from vehicules)
  --GROUP BY referencevhc, marque

  --select MIN(prixlocation) from vehicules WHERE litrereservoir > ANY (select litrereservoir from vehicules)


--le client qui a utiliser le carburant le moins chère--





--quel est le vehicule qui utilise le carburant le moins chère--

