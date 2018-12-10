CREATE DOMAIN d_reg_aeg TIMESTAMP without time zone NOT NULL DEFAULT localtimestamp(0)
CONSTRAINT CHK_reg_aeg_ajavahemik CHECK (
  VALUE BETWEEN '2010-01-01' AND '2100-12-31 23:59:59'
)

CREATE DOMAIN d_nimetus VARCHAR(20) NOT NULL
  CONSTRAINT CHK_nimetus_ei_koosne_tyhikutest CHECK (VALUE !~ '^[[:space:]]+$'),
  CONSTRAINT CHK_nimetus_ei_ole_tyhi_string CHECK (VALUE <> '')


ALTER TABLE Tootaja_seisundi_liik DROP CONSTRAINT CHK_Tootaja_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Tootaja_seisundi_liik DROP CONSTRAINT CHK_Tootaja_seisundi_liik_nimetus_ei_ole_tyhi;

ALTER TABLE Raja_seisundi_liik DROP CONSTRAINT CHK_Raja_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Raja_seisundi_liik DROP CONSTRAINT CHK_Raja_seisundi_liik_nimetus_ei_ole_tyhi;

ALTER TABLE Raja_kategooria_tyyp DROP CONSTRAINT CHK_Raja_kategooria_tyyp_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Raja_kategooria_tyyp DROP CONSTRAINT CHK_Raja_kategooria_tyyp_nimetus_ei_ole_tyhi;

ALTER TABLE Raja_kategooria DROP CONSTRAINT CHK_Raja_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Raja_kategooria DROP CONSTRAINT CHK_Raja_nimetus_ei_ole_tyhi;

ALTER TABLE Kliendi_seisundi_liik DROP CONSTRAINT CHK_Kliendi_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Kliendi_seisundi_liik DROP CONSTRAINT CHK_Kliendi_seisundi_liik_nimetus_ei_ole_tyhi;

ALTER TABLE Isiku_seisundi_liik DROP CONSTRAINT CHK_Isiku_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Isiku_seisundi_liik DROP CONSTRAINT CHK_Isiku_seisundi_liik_nimetus_ei_ole_tyhi;

ALTER TABLE Rada DROP CONSTRAINT CHK_Rada_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Rada DROP CONSTRAINT CHK_Rada_nimetus_ei_ole_tyhi;
ALTER TABLE Rada DROP CONSTRAINT CHK_Rada_reg_aeg_ajavahemik;

ALTER TABLE Isik DROP CONSTRAINT CHK_Isik_reg_aeg_ajavahemik;




ALTER TABLE Tootaja_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Raja_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Raja_kategooria_tyyp ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Raja_kategooria ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Kliendi_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Isiku_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;