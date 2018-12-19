

/* OP 1 */
CREATE OR REPLACE FUNCTION f_lisa_rada(p_rada_kood Rada.raja_kood%TYPE, p_nimetus Rada.nimetus%TYPE, p_pikkus Rada.pikkus%TYPE, p_registreerija_email Isik.e_meil%TYPE, p_raskuse_nimetus Raja_raskus.nimetus%TYPE)
RETURNS VOID AS $$
INSERT INTO rada(raja_kood, nimetus, pikkus, registreerija_id, raja_raskus_kood)
SELECT p_rada_kood, p_nimetus, p_pikkus, isik.isik_id, raja_raskus.raja_raskus_kood
FROM isik, raja_raskus WHERE LOWER(e_meil) = LOWER(p_registreerija_email) AND LOWER(nimetus) = LOWER(p_raskuse_nimetus);
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lisa_rada(p_rada_kood Rada.raja_kood%TYPE, p_nimetus Rada.nimetus%TYPE, p_pikkus Rada.pikkus%TYPE, p_registreerija_email Isik.e_meil%TYPE, p_raskuse_nimetus Raja_raskus.nimetus%TYPE)
IS 'Selle funktsiooni abil registreeritaksa uus rada. See funktsioon realiseerib andmebaasioperatsiooni OP1. Parameetri p_rada_kood oodatav väärtus on raja identifikaator, p_nimetus oodatav väärtus on raja nimetus, p_pikkus oodatav väärtus on raja pikkus meetrides, p_registreerija_email oodatav väärtus on isiku e-mail, p_raskuse_nimetus oodatav väärtus on raja raskuse nimetus.';

/* usage:   select f_lisa_rada(p_rada_kood := 4, p_nimetus := 'Lisa rada', p_pikkus := smallint '3333', p_registreerija_email := 'rasmus@live.ee', p_raskuse_nimetus := 'Raske'); */

/* OP 2 [ainult kui ootel]*/
CREATE OR REPLACE FUNCTION f_unusta_rada(p_rada_kood Rada.raja_kood%TYPE)
RETURNS VOID AS $$
DELETE FROM Rada WHERE raja_kood = p_rada_kood;
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_aktiveeri_rada(p_rada_kood Rada.raja_kood%TYPE)
IS 'Selle funktsiooni abil unustatake (kustutakse) rada. See funktsioon realiseerib andmebaasioperatsiooni OP2. Parameetri p_rada_kood oodatav väärtus on raja identifikaator.';

CREATE OR REPLACE FUNCTION f_unusta_rada_viga() RETURNS trigger AS $$
BEGIN
	RAISE EXCEPTION 'Ei saa unustada rada, mille seisundi liik ei ole ootel.';
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION f_unusta_rada_viga() IS 'See trigeri funktsioon aitab jõustada ärireegli: Ei
saa unustada rada, mille seisundi liik ei ole ootel';

CREATE TRIGGER trig_unusta_rada_viga BEFORE DELETE
ON Rada FOR EACH ROW WHEN (OLD.raja_seisundi_liik_kood <> 1) EXECUTE
FUNCTION f_unusta_rada_viga();


/* OP 3 [ainult kui ootel] */
CREATE OR REPLACE FUNCTION f_aktiveeri_rada(p_rada_kood Rada.raja_kood%TYPE) RETURNS VOID AS $$
DECLARE
   praegune_kood rada.raja_kood%TYPE := (SELECT raja_seisundi_liik_kood FROM Rada WHERE raja_kood = p_rada_kood);
BEGIN
IF praegune_kood <> 1 THEN
   RAISE EXCEPTION 'Ei saa aktiveerida rada, mille seisundi liik ei ole ootel.';
ELSIF praegune_kood IS NULL THEN
   RAISE EXCEPTION 'Ei saa aktiveerida rada, mida ei ole olemas';
ELSE
	UPDATE Rada SET raja_seisundi_liik_kood = 2 WHERE raja_kood = p_rada_kood;
END IF;
END
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp;


/* OP 4 [ainult kui aktiivne/mitteaktiivne] */
CREATE OR REPLACE FUNCTION f_lopeta_rada(p_rada_kood Rada.raja_kood%TYPE) RETURNS VOID AS $$
DECLARE
   praegune_kood rada.raja_kood%TYPE := (SELECT raja_seisundi_liik_kood FROM Rada WHERE raja_kood = p_rada_kood);
BEGIN
IF (praegune_kood <> 2 AND praegune_kood <> 3) THEN
   RAISE EXCEPTION 'Ei saa lõpetada rada, mille seisundi liik ei ole aktiivne või mitteaktiivne.';
ELSIF praegune_kood IS NULL THEN
   RAISE EXCEPTION 'Ei saa lõpetada rada, mida ei ole olemas.';
ELSE
   UPDATE Rada SET raja_seisundi_liik_kood = 4 WHERE raja_kood = p_rada_kood;
END IF;
END
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lopeta_rada(p_rada_kood Rada.raja_kood%TYPE)
IS 'Selle funktsiooni abil lõpetatakse rada. See funktsioon realiseerib andmebaasioperatsiooni OP4. Parameetri p_rada_kood oodatav väärtus on raja identifikaator.';


/* OP 6 [kui ootel v6i mitteaktiivne]*/
CREATE OR REPLACE FUNCTION f_muuda_rada(p_vana_raja_kood Rada.raja_kood%TYPE, p_uus_raja_kood Rada.raja_kood%TYPE, p_rada_nimetus Rada.nimetus%TYPE, p_rada_pikkus Rada.pikkus%TYPE) RETURNS VOID AS $$
DECLARE
   praegune_kood rada.raja_kood%TYPE := (SELECT raja_seisundi_liik_kood FROM Rada WHERE raja_kood = p_vana_raja_kood);
BEGIN
IF (praegune_kood <> 1) AND (praegune_kood <> 3) THEN
   RAISE EXCEPTION 'Ei saa muuta rada, mille seisund ei ole ootel või mitteaktiivne.';
   RETURN;
ELSIF praegune_kood IS NULL THEN
   RAISE EXCEPTION 'Ei saa muuta rada, mida ei ole olemas.';
   RETURN;
ELSE
   UPDATE Rada SET raja_kood = p_uus_raja_kood, nimetus = p_rada_nimetus, pikkus = p_rada_pikkus WHERE raja_kood = p_vana_raja_kood;
END IF;
END
$$ LANGUAGE plpgsql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_muuda_rada(p_vana_raja_kood Rada.raja_kood%TYPE, p_uus_raja_kood Rada.raja_kood%TYPE, p_rada_nimetus Rada.nimetus%TYPE, p_rada_pikkus Rada.pikkus%TYPE)
IS 'Selle funktsiooni abil muudetakse raja andmed. See funktsioon realiseerib andmebaasioperatsiooni OP6. Parameetri p_vana_raja_kood oodatav väärtus on muutmise raja identifikaator, p_uus_raja_kood oodatav väärtus on uus raja identifikaator, p_rada_nimetus oodatav väärtus on uus raja nimetus, p_rada_pikkus oodatav väärtus on uus raja pikkus.';



