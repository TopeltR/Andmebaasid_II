INSERT INTO amet (amet_kood, nimetus, kirjeldus) VALUES ('juh','juhataja','Antud töötaja peamisteks tegevusteks on suusabaasi radade ülevaatamine');
INSERT INTO amet (amet_kood, nimetus, kirjeldus) VALUES ('r_hal','Radade haldur','Peamisteks tegevusteks on radade hooldamine');
INSERT INTO amet (amet_kood, nimetus, kirjeldus) VALUES ('juhab','Juhiabi','Aitab juhti igapäeva tegemistes');
INSERT INTO amet (amet_kood, nimetus, kirjeldus) VALUES ('varha','Varade haldur','Vastutab firma materjaalsete väärtuste korrasolu üle');
INSERT INTO amet (amet_kood, nimetus, kirjeldus) VALUES ('klaha','Klassifikaatorite haldur','Kontrollib, et kõik klassifikaatorid oleksid korrektsed');
INSERT INTO amet (amet_kood, nimetus, kirjeldus) VALUES ('klete','Klienditeenidaja','Suhtleb klientidega');
INSERT INTO amet (amet_kood, nimetus, kirjeldus) VALUES ('tootj','Töötaja','Teeb tööd');
INSERT INTO amet (amet_kood, nimetus, kirjeldus) VALUES ('perju','Personalijuht','Vastutab kõikide töötajate heaolu eest ');


INSERT INTO riik(riik_kood, nimetus) VALUES ('FIN','Finland');
INSERT INTO riik(riik_kood, nimetus) VALUES ('GER','Germany');

INSERT INTO isik (isik_id,isikukood,isikukoodi_riik,e_meil,parool,isiku_seisundi_liik_kood, synni_kp,reg_aeg,eesnimi, perenimi,elukoht) VALUES (1, 39709070810, 'EST', 'rasmus@live.ee', 'test123', 1, 

INSERT INTO kliendi_seisundi_liik(kliendi_seisundi_liik_kood,nimetus) VALUES (1,'Aktiivne');
INSERT INTO kliendi_seisundi_liik(kliendi_seisundi_liik_kood,nimetus) VALUES (2,'Mustas nimekirjas');

INSERT INTO klient (isik_id,kliendi_seisundi_liik_kood, on_nous_tylitamisega) VALUES (7,1,true);
INSERT INTO klient (kliendi_seisundi_liik_kood, on_nous_tylitamisega) VALUES (1,false);

INSERT INTO raja_kategooria_omamine (raja_kood, raja_kategooria_kood) VALUES (1,2);
INSERT INTO raja_kategooria_omamine (raja_kood, raja_kategooria_kood) VALUES (2,3);
INSERT INTO raja_kategooria_omamine (raja_kood, raja_kategooria_kood) VALUES (2,6);
INSERT INTO raja_kategooria_omamine (raja_kood, raja_kategooria_kood) VALUES (3,1);
INSERT INTO raja_kategooria_omamine (raja_kood, raja_kategooria_kood) VALUES (3,4);
INSERT INTO raja_kategooria_omamine (raja_kood, raja_kategooria_kood) VALUES (4,1);
INSERT INTO raja_kategooria_omamine (raja_kood, raja_kategooria_kood) VALUES (4,4);

INSERT INTO raja_kategooria_tyyp (raja_kategooria_tyyp_kood, nimetus) VALUES (1, 'Raja profiil');
INSERT INTO raja_kategooria_tyyp (raja_kategooria_tyyp_kood, nimetus) VALUES (2, 'Sihtrühm');

INSERT INTO raja_kategooria (raja_kategooria_kood, nimetus,raja_kategooria_tyyp_kood) VALUES (1,'Tasane', 1);
INSERT INTO raja_kategooria (raja_kategooria_kood, nimetus,raja_kategooria_tyyp_kood) VALUES (2,'Keskmine', 1);
INSERT INTO raja_kategooria (raja_kategooria_kood, nimetus,raja_kategooria_tyyp_kood) VALUES (3,'Mägine', 1);
INSERT INTO raja_kategooria (raja_kategooria_kood, nimetus,raja_kategooria_tyyp_kood) VALUES (4,'Noored', 2);
INSERT INTO raja_kategooria (raja_kategooria_kood, nimetus,raja_kategooria_tyyp_kood) VALUES (5,'Täiskasvanud', 2);
INSERT INTO raja_kategooria (raja_kategooria_kood, nimetus,raja_kategooria_tyyp_kood) VALUES (6,'Professionaalid', 2);

INSERT INTO raja_raskus (raja_raskus_kood, nimetus) VALUES (1,'Lihtne');
INSERT INTO raja_raskus (raja_raskus_kood, nimetus) VALUES (2,'Mõõdukas');
INSERT INTO raja_raskus (raja_raskus_kood, nimetus) VALUES (3,'Keskmine');
INSERT INTO raja_raskus (raja_raskus_kood, nimetus) VALUES (4,'Raskema poolne');
INSERT INTO raja_raskus (raja_raskus_kood, nimetus) VALUES (5,'Raske');
INSERT INTO raja_raskus (raja_raskus_kood, nimetus) VALUES (6,'Professionaalidele');

INSERT INTO raja_seisundi_liik (raja_seisundi_liik_kood, nimetus) VALUES (1,'Ootel');
INSERT INTO raja_seisundi_liik (raja_seisundi_liik_kood, nimetus) VALUES (2,'Aktiivne');
INSERT INTO raja_seisundi_liik (raja_seisundi_liik_kood, nimetus) VALUES (3,'Mitteaktiivne');
INSERT INTO raja_seisundi_liik (raja_seisundi_liik_kood, nimetus) VALUES (4,'Lõpetatud');

INSERT INTO tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (1,'Katseajal');
INSERT INTO tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (2,'Tööl');
INSERT INTO tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (3,'Puhkusel');
INSERT INTO tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (4,'Haiguslehel');
INSERT INTO tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (5,'Töösuhe peatatud');
INSERT INTO tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (6,'Töösuhe lõpetatud');
INSERT INTO tootaja_seisundi_liik (tootaja_seisundi_liik_kood, nimetus) VALUES (7,'Vallandatud');

INSERT INTO tootaja(isik_id, amet_kood, tootaja_seisundi_liik_kood, mentor) VALUES (5,'juh', 1, null);


INSERT INTO rada (raja_kood, nimetus, pikkus, registreerija_id, raja_seisundi_liik_kood, raja_raskus_kood) VALUES (1,'Astaku rada', 2000, 5,2,2);


CREATE USER MAPPING FOR t164640 SERVER
minu_testandmete_server_apex OPTIONS (user 't164640', password
'ro6raloko');






INSERT INTO Isik(riik_kood, isikukood, eesnimi, perenimi,
e_mail, synni_kp, isiku_seisundi_liik_kood, parool, elukoht)
SELECT riik_kood, isikukood, eesnimi, perenimi, e_mail,
synni_kp::date, isiku_seisundi_liik_kood::smallint, parool,
elukoht
FROM (SELECT isik->>'riik' AS riik_kood,
jsonb_array_elements(isik->'isikud')->>'isikukood' AS isikukood,
jsonb_array_elements(isik->'isikud')->>'eesnimi' AS eesnimi,
jsonb_array_elements(isik->'isikud')->>'perekonnanimi' AS
perenimi,
jsonb_array_elements(isik->'isikud')->>'email' AS e_mail,
jsonb_array_elements(isik->'isikud')->>'synni_aeg' AS synni_kp,
jsonb_array_elements(isik->'isikud')->>'seisund' AS
isiku_seisundi_liik_kood,
jsonb_array_elements(isik->'isikud')->>'parool' AS parool,
jsonb_array_elements(isik->'isikud')->>'aadress' AS elukoht
FROM isik_jsonb) AS lahteandmed
WHERE isiku_seisundi_liik_kood::smallint=1;

                                                                                                                                                
                                                                                                                                                ALTER DOMAIN d_nimetus ADD CONSTRAINT chk_nimetus_ei_koosne_tyhikutest CHECK (VALUE !~ '^[[:space:]]+$');
ALTER DOMAIN d_pikem_vali ADD CONSTRAINT chk_vali_ei_ole_tyhi_string CHECK (VALUE <> '');

ALTER TABLE amet ADD CONSTRAINT chk_amet_amet_kood_ei_koosne_tyhikutest CHECK (amet_kood !~ '^[[:space:]]+$');













