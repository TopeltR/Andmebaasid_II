CREATE USER t164640_suusaradade_juhataja WITH encrypted password 'rajad1';

GRANT CONNECT ON DATABASE t164640 TO t164640_suusaradade_juhataja;

GRANT EXECUTE ON FUNCTION f_lisa_rada(p_rada_kood Rada.raja_kood%TYPE, p_nimetus Rada.nimetus%TYPE, p_pikkus Rada.pikkus%TYPE, p_registreerija_email Isik.e_meil%TYPE, p_raskuse_nimetus Raja_raskus.nimetus%TYPE) TO t164640_suusaradade_juhataja;
GRANT EXECUTE ON FUNCTION f_lisa_rada_viga() TO t164640_suusaradade_juhataja;
GRANT EXECUTE ON FUNCTION f_unusta_rada(p_rada_kood Rada.raja_kood%TYPE) TO t164640_suusaradade_juhataja;
GRANT EXECUTE ON FUNCTION f_unusta_rada_viga() TO t164640_suusaradade_juhataja;
GRANT EXECUTE ON FUNCTION f_aktiveeri_rada(p_rada_kood Rada.raja_kood%TYPE) TO t164640_suusaradade_juhataja;
GRANT EXECUTE ON FUNCTION f_lopeta_rada(p_rada_kood Rada.raja_kood%TYPE) TO t164640_suusaradade_juhataja;
GRANT EXECUTE ON FUNCTION f_muuda_rada(p_vana_raja_kood Rada.raja_kood%TYPE, p_uus_raja_kood Rada.raja_kood%TYPE, p_rada_nimetus Rada.nimetus%TYPE, p_rada_pikkus Rada.pikkus%TYPE) TO t164640_suusaradade_juhataja;

GRANT SELECT ON aktiivsed_mitteaktiivsed_rajad TO t164640_suusaradade_juhataja;
GRANT SELECT ON koik_rajad TO t164640_suusaradade_juhataja;
GRANT SELECT ON rada_kategooria_omamine TO t164640_suusaradade_juhataja;
GRANT SELECT ON radade_detailid TO t164640_suusaradade_juhataja;
GRANT SELECT ON radade_koondaruanne TO t164640_suusaradade_juhataja;


GRANT USAGE ON SCHEMA public TO t164640_suusaradade_juhataja;