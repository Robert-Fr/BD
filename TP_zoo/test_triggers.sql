create or replace trigger modif_aff_gardien after update on lesgardiens 
For each row
Begin
insert into lesHistoiresAff(dateFin,noCage,nomE) values(sysdate(), :old.noCage, :old.nomE);
End;
/

create or replace trigger modif_aff_animaux before update or insert on lesanimaux
For each row
Declare 
fonction varchar(20);
Begin
Select lescages.fonction into fonction from lescages where nocage=:new.nocage;
if(fonction!=:new.fonction_cage) then 
raise_application_error(-20101, 'le type de la cage n est pas compatible avec l animal');
end if;
End;
/

create or replace trigger cages_gardees before update or insert on lesanimaux
For each row
Declare 
noms integer;
Begin
Select count(lesgardiens.nomE) into noms from lescages left join lesgardiens on lescages.nocage=lesgardiens.nocage where lesgardiens.nocage=:new.nocage;
if(noms=0) then 
raise_application_error(-20101, 'la cage est vide');
end if;
End;
/

create or replace trigger upd_gardiens_possibles before delete or update on lesgardiens
	For each row
	Declare 
	nomsE integer;
	begin
	Select distinct count(distinct lesgardiens.nomE) into nomsE from (lesanimaux left join lesgardiens on lesanimaux.nocage=lesgardiens.nocage) where (lesgardiens.nocage=:old.nocage and ( ( lesanimaux.nocage = :old.nocage and lesgardiens.nomE != :old.nomE ))) ;
	if(nomsE=0) then 
		raise_application_error(-20101, 'update / delete du gardien impossible');
	end if;
END;
/
