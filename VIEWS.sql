CREATE VIEW aktiivsed_mitteaktiivsed_rajad 
AS SELECT Rada.raja_kood, Rada.nimetus, Rada.pikkus, Raja_seisundi_liik.nimetus AS hetke_seisund WITH (security_barrier)
FROM Raja_seisundi_liik
INNER JOIN Rada ON Raja_seisundi_liik.raja_seisundi_liik_kood = Rada.raja_seisundi_liik_kood
WHERE Rada.raja_seisundi_liik_kood In (2,3);

COMMENT ON VIEW aktiivsed_mitteaktiivsed_rajad IS 'Näitab aktiivsed ja mitteaktiivseid radasi (kood, nimetus, pikkus ja seisundi liik)';


CREATE OR REPLACE VIEW rada_kategooria_omamine WITH (security_barrier)
AS SELECT Raja_kategooria_omamine.raja_kood, Raja_kategooria.nimetus || ' (' || Raja_kategooria_tyyp.nimetus || ')' AS kategooria
FROM Raja_kategooria_tyyp
INNER JOIN (Raja_kategooria INNER JOIN Raja_kategooria_omamine ON Raja_kategooria.raja_kategooria_kood = Raja_kategooria_omamine.raja_kategooria_kood) ON Raja_kategooria_tyyp.raja_kategooria_tyyp_kood = Raja_kategooria.raja_kategooria_tyyp_kood;

COMMENT ON VIEW rada_kategooria_omamine IS 'Näitab rajade kategooriad (kood ja rada kategooria)';


CREATE OR REPLACE VIEW koik_radad WITH (security_barrier)
AS SELECT Rada.raja_kood, Rada.nimetus, Rada.pikkus, Raja_seisundi_liik.nimetus AS hetke_seisund
FROM Raja_seisundi_liik
INNER JOIN Rada ON Raja_seisundi_liik.raja_seisundi_liik_kood = Rada.raja_seisundi_liik_kood;

COMMENT ON VIEW koik_radad IS 'Näitab kõike radasi (kood, nimetus, pikkus ja raja hetke seisundi';


CREATE OR REPLACE VIEW radade_koondaruanne WITH (security_barrier)
AS SELECT Raja_seisundi_liik.raja_seisundi_liik_kood, upper(Raja_seisundi_liik.nimetus) AS seisundi_nimetus, Count(Rada.raja_kood) AS arv
FROM Raja_seisundi_liik
LEFT JOIN Rada ON Raja_seisundi_liik.raja_seisundi_liik_kood = Rada.raja_seisundi_liik_kood
GROUP BY Raja_seisundi_liik.raja_seisundi_liik_kood, upper(Raja_seisundi_liik.nimetus)
ORDER BY Count(Rada.raja_kood) DESC , upper(Raja_seisundi_liik.nimetus);

COMMENT ON VIEW radade_koondaruanne IS 'Näitab radade koondaruanne nende seisundi liigi põhjal (seisundi kood, seisundi nimetus ja arv, mis näitab, kui palju on niisugusi radasi';


CREATE OR REPLACE VIEW radade_detailid WITH (security_barrier)
AS SELECT Rada.raja_kood, Rada.nimetus, Rada.pikkus, Raja_seisundi_liik.nimetus AS hetke_seisund, Isik.e_meil AS registreerija_email, (Trim(Isik.eesnimi || ' ' || Isik.perenimi)) AS registreerija_nimi, Rada.reg_aeg
FROM Raja_seisundi_liik
INNER JOIN (Isik INNER JOIN Rada ON Isik.isik_id=Rada.registreerija_id) ON Raja_seisundi_liik.raja_seisundi_liik_kood = Rada.raja_seisundi_liik_kood;

COMMENT ON VIEW radade_detailid IS 'Näitab kõike radasi detailid (kood, nimetus, pikkus, hetke seisund, registreerija email, registreerija täis nimi, registratsiooni aeg)';