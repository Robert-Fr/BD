--REQEUETE A
SELECT LesAnimaux.liste_maladies FROM ( LesAnimaux LEFT JOIN lescages ON DEREF(LesAnimaux.laCage) = lescages.noCage ) Where DEREF(LesAnimaux.laCage).noAllee = 2; 
-- REQUETE B
SELECT (LesAnimaux.nomA, LesAnimaux.type_an) FROM LesAnimaux a, Table(a.liste_maladies) lm Where ('grippe' IN lm);
-- REQUETE C
