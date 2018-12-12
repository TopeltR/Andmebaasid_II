CREATE DOMAIN d_reg_aeg TIMESTAMP without time zone NOT NULL DEFAULT localtimestamp(0)
CONSTRAINT chk_reg_aeg_vahemikus CHECK (
  VALUE BETWEEN '2010-01-01' AND '2100-12-31 23:59:59'
);

CREATE DOMAIN d_nimetus VARCHAR(20) NOT NULL
  CONSTRAINT CHK_nimetus_pole_tyhi CHECK ((VALUE !~ '^[[:space:]]+$') AND (VALUE <> ''));

ALTER TABLE Tootaja_seisundi_liik DROP CONSTRAINT chk_tootaja_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Tootaja_seisundi_liik DROP CONSTRAINT chk_tootaja_seisundi_liik_nimetus_pole_tyhi;

ALTER TABLE Raja_seisundi_liik DROP CONSTRAINT chk_raja_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Raja_seisundi_liik DROP CONSTRAINT chk_Raja_seisundi_liik_nimetus_pole_tyhi;

ALTER TABLE Tootaja_seisundi_liik DROP CONSTRAINT chk_tootaja_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Tootaja_seisundi_liik DROP CONSTRAINT chk_tootaja_seisundi_liik_nimetus_pole_tyhi;

ALTER TABLE Raja_kategooria_tyyp DROP CONSTRAINT chk_raja_kategooria_tyyp_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Raja_kategooria_tyyp DROP CONSTRAINT chk_raja_kategooria_tyyp_nimetus_pole_tyhi;

ALTER TABLE Raja_kategooria DROP CONSTRAINT chk_raja_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Raja_kategooria DROP CONSTRAINT chk_raja_nimetus_pole_tyhi;

ALTER TABLE Kliendi_seisundi_liik DROP CONSTRAINT chk_kliendi_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Kliendi_seisundi_liik DROP CONSTRAINT chk_kliendi_seisundi_liik_nimetus_pole_tyhi;

ALTER TABLE Isiku_seisundi_liik DROP CONSTRAINT chk_isiku_seisundi_liik_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Isiku_seisundi_liik DROP CONSTRAINT chk_isiku_seisundi_liik_nimetus_pole_tyhi;

ALTER TABLE Rada DROP CONSTRAINT chk_rada_nimetus_ei_koosne_tyhikutest;
ALTER TABLE Rada DROP CONSTRAINT chk_rada_nimetus_ei_ole_tyhi_string;


ALTER TABLE Rada DROP CONSTRAINT chk_rada_reg_aeg_vahemikus;
ALTER TABLE Isik DROP CONSTRAINT chk_isik_reg_aeg_vahemikus;




ALTER TABLE Tootaja_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Raja_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Raja_kategooria_tyyp ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Raja_kategooria ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Kliendi_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Isiku_seisundi_liik ALTER COLUMN nimetus TYPE d_nimetus;
ALTER TABLE Isik ALTER COLUMN reg_aeg TYPE d_reg_aeg;
ALTER TABLE Rada ALTER COLUMN reg_aeg TYPE d_reg_aeg;
