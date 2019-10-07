-- Exemples de commandes utiles pour le TP

-- suppression de la table Comptes (genere un warning si elle n'existe pas)
drop table Comptes;

-- creation de la table comptes
-- (pensez a ajouter les contraintes necessaires)
create table Comptes(
	NC integer,
	Nom varchar2(10),
	Solde number,
	constraint soldepos check (solde>=0)
);Paul
