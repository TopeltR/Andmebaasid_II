

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

select f_lisa_rada(p_rada_kood := 4, p_nimetus := 'Lisa rada', p_pikkus := smallint '3333', p_registreerija_email := 'rasmus@live.ee', p_raskuse_nimetus := 'Raske');

integer, character varying, smallint, character varying, character varying

/* OP 2 */
CREATE OR REPLACE FUNCTION f_unusta_rada(p_rada_kood Rada.raja_kood%TYPE)
RETURNS VOID AS $$
DELETE FROM Rada WHERE raja_kood = p_rada_kood;
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_aktiveeri_rada(p_rada_kood Rada.raja_kood%TYPE)
IS 'Selle funktsiooni abil unustatake (kustutakse) rada. See funktsioon realiseerib andmebaasioperatsiooni OP2. Parameetri p_rada_kood oodatav väärtus on raja identifikaator.';


/* OP 3 */
CREATE OR REPLACE FUNCTION f_aktiveeri_rada(p_rada_kood Rada.raja_kood%TYPE)
RETURNS VOID AS $$
UPDATE Rada SET raja_seisundi_liik_kood = 2 WHERE raja_kood = p_rada_kood;
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_aktiveeri_rada(p_rada_kood Rada.raja_kood%TYPE)
IS 'Selle funktsiooni abil lõpetatakse rada. See funktsioon realiseerib andmebaasioperatsiooni OP3. Parameetri p_rada_kood oodatav väärtus on raja identifikaator.';

select f_aktiveeri_rada(p_rada_kood := 4);

/* OP 4 */
CREATE OR REPLACE FUNCTION f_lopeta_rada(p_rada_kood Rada.raja_kood%TYPE)
RETURNS VOID AS $$
UPDATE Rada SET raja_seisundi_liik_kood = 4 WHERE raja_kood = p_rada_kood;
$$ LANGUAGE sql SECURITY DEFINER
SET search_path = public, pg_temp;

COMMENT ON FUNCTION f_lopeta_rada(p_rada_kood Rada.raja_kood%TYPE)
IS 'Selle funktsiooni abil lõpetatakse rada. See funktsioon realiseerib andmebaasioperatsiooni OP4. Parameetri p_rada_kood oodatav väärtus on raja identifikaator.';
