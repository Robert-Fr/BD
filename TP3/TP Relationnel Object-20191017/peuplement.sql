-- La suite doit etre placee dans un script de peuplement (autre fichier)

-- Deja les cages
insert into LesCages values (11 ,  'fauve' , 10, ens_gardiens() );
insert into LesCages values (1 , 'fosse'  , 1,ens_gardiens() );
insert into LesCages values (2 , 'aquarium'  , 1,ens_gardiens() );
insert into LesCages values (3 , 'petits oiseaux' , 2,ens_gardiens());
insert into LesCages values (4 , 'grand aquarium'  , 1,ens_gardiens() );
insert into LesCages values (12  , 'fauve' , 10,ens_gardiens());

-- Ensuite les employes maintenant que les cages existent
insert into LesEmployes values (tresponsable('Verdier'  , 'Noumea',tspecialites('fauve'),10 ));
insert into LesEmployes values (tgardien('Spinnard'  , 'Sartene',tspecialites('fauve'),
	ens_cages(
		(select ref(c) from lescages c where c.noCage = 11),
		(select ref(c) from lescages c where c.noCage = 12))
	) );
insert into LesEmployes values (tgardien('Labbe' ,    'Calvi',tspecialites('fauve'),
	ens_cages(
		(select ref(c) from lescages c where c.noCage = 12),
		(select ref(c) from lescages c where c.noCage = 11)
	) ));
insert into LesEmployes values (tgardien('Lachaize' , 'Pointe a Pitre',tspecialites('fauve','fosse','petis oiseaux'),
	ens_cages(
		(select ref(c) from lescages c where c.noCage = 11),
		(select ref(c) from lescages c where c.noCage = 1),
		(select ref(c) from lescages c where c.noCage = 3),
		(select ref(c) from lescages c where c.noCage = 12))
	) );
insert into LesEmployes values (tresponsable('Desmoulins'  , 'Ushuaia',tspecialites('fauve','fosse','petis oiseaux'),2) );
insert into LesEmployes values (tresponsable('Jouanot'   , 'Papeete',tspecialites('fosse','aquarium','gand aquarium'),1) );

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

