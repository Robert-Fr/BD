drop table lesanimaux FORCE;
drop table lesemployes FORCE;
drop table lescages FORCE;
drop type ens_cages FORCE;
drop type ens_maladies FORCE;
drop type ens_gardiens FORCE;
drop type tresponsable;
drop type tgardien;
drop type temploye;
drop type tcage;
drop type tspecialites;

-- ATTENTION: Il est plus prudent d'executer chaque commande de maniere indépendante, et pas le script complet
-- => plus facile a debuguer

-- Declarer un type tcage
create type tcage;
/

-- Definir une collection libre (nested table) ens_cages de references sur tcage
create type ens_cages as table of REF tcage;
/

-- Definir une collection statique (Varray) tspecialites de chaines de caracteres (fonction de la cage)
Create type tspecialites as Varray (100) of varchar(20);
/

-- Definir un type temploye
create type temploye as object(
	nomE varchar2(20),
	adresse varchar2(20),
	fonction_cage tspecialites
)
NOT FINAL;
/

-- Definir les sous-types de temploye: tgardien et trespsonsable
create type tgardien UNDER temploye (liste_cages ens_cages);
/

create type tresponsable UNDER temploye (
	noAllee integer);
/

-- Creation de la table lesemployes (Attention les les collections des classes herites n'ont pas de "container")
create table lesemployes of temploye;

-- Definir une collection libre ens_gardiens de references sur tgardien
create type ens_gardiens as table of REF tgardien;
/

-- Definir le type tcage (dejà declarer au debut)
create type tcage as object (
	noCage number(3),
	fonction varchar2(20),
	noAllee number(3),
	liste_gardiens ens_gardiens
);
/

-- Creation de la table lescages (Les collections de classes "final" possedent des "containers")
create table lescages of tcage
nested table liste_gardiens Store as lesgardiens;

-- Definir une collection libre ens_maladies de chaine de caracteres (maladie)
create type ens_maladies as ;
/

-- Creation de la table lesanimaux
create table LesAnimaux (
	nomA varchar2(20),
	sexe varchar2(13),
	type_an varchar2(15),
	fonction_cage varchar2(20),
	pays varchar2(20),
	anNais number(4),
	lacage _____,
	liste_maladies _____,
	constraint LesAnimaux_C1 primary key (nomA)
)
_____;

-- La suite doit etre placee dans un script de peuplement (autre fichier)

-- Deja les cages
insert into LesCages values (11 ,  'fauve' , 10, ens_cages() );
insert into LesCages values (1 , 'fosse'  , 1,_____ );
insert into LesCages values (2 , 'aquarium'  , 1,_____ );
insert into LesCages values (3 , 'petits oiseaux' , 2,_____ );
insert into LesCages values (4 , 'grand aquarium'  , 1,_____ );
insert into LesCages values (12  , 'fauve' , 10,_____);

-- Ensuite les employes maintenant que les cages existent
insert into LesEmployes values (_____('Verdier'  , 'Noumea', _____,10));
insert into LesEmployes values (_____('Spinnard'  , 'Sartene',_____,
	ens_cages(
		(_____),
		(_____))
	) );
insert into LesEmployes values (_____('Labbe' ,    'Calvi',_____,
	ens_cages(
		(_____),
		(_____)
	) );
insert into LesEmployes values (_____('Lachaize' , 'Pointe a Pitre',_____,
	ens_cages(
		(_____),
		(_____),
		(_____),
		(_____)
	) );
insert into LesEmployes values (_____('Desmoulins'  , 'Ushuaia',_____,2) );
insert into LesEmployes values (_____('Jouanot'   , 'Papeete',_____,1) );

-- Mise à jour de liste des gardiens dans chaque cage
insert into Table(____) value (____);
insert into Table(____) value (____);
insert into Table(____) value (____);
insert into Table(____) value (____);

-- Et enfin les animaux
insert into LesAnimaux values ('Charly', 'male',   'lion', 'fauve',  'Kenya',  2010,   _____,_____);
insert into LesAnimaux values ('Arthur', 'male',   'ours', 'fosse',  'France', 2000,   _____,_____ );
insert into LesAnimaux values ('Chloe',  'femelle', 'pie', 'petits oiseaux' ,  'France', 2011,   _____,_____);
insert into LesAnimaux values ('Milou',  'male' ,  'leopard', 'fauve', 'France', 2013,  _____,_____);
insert into LesAnimaux values ('Tintin', 'male' , 'leopard', 'fauve', 'France', 2013,    _____,_____);
insert into LesAnimaux values ('Charlotte', 'femelle', 'lion',  'fauve',  'Kenya',  2012, _____,_____);


