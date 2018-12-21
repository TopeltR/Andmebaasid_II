/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 13.5 		*/
/*  Created On : 23-nov-2018 14:57.50 				*/
/*  DBMS       : PostgreSQL 						*/
/* ---------------------------------------------------- */

/* Drop Sequences for Autonumber Columns */

 

/* Drop Tables */

DROP TABLE IF EXISTS Tootaja_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Raja_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Raja_raskus CASCADE
;

DROP TABLE IF EXISTS Raja_kategooria_tyyp CASCADE
;

DROP TABLE IF EXISTS Raja_kategooria CASCADE
;

DROP TABLE IF EXISTS Riik CASCADE
;

DROP TABLE IF EXISTS Kliendi_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Isiku_seisundi_liik CASCADE
;

DROP TABLE IF EXISTS Amet CASCADE
;

DROP TABLE IF EXISTS Isik CASCADE
;

DROP TABLE IF EXISTS Tootaja CASCADE
;

DROP TABLE IF EXISTS Klient CASCADE
;

DROP TABLE IF EXISTS Rada CASCADE
;

DROP TABLE IF EXISTS Raja_kategooria_omamine CASCADE
;

/* Create Tables */

CREATE TABLE Tootaja_seisundi_liik
(
	tootaja_seisundi_liik_kood smallint NOT NULL,
	nimetus d_nimetus,
	CONSTRAINT PK_Tootaja_seisundi_liik PRIMARY KEY (tootaja_seisundi_liik_kood),
	CONSTRAINT AK_Tootaja_seisundi_liik_nimetus UNIQUE (nimetus),
)
;

CREATE TABLE Raja_seisundi_liik
(
	raja_seisundi_liik_kood smallint NOT NULL,
	nimetus d_nimetus,
	CONSTRAINT PK_Raja_seisundi_liik PRIMARY KEY (raja_seisundi_liik_kood),
	CONSTRAINT AK_Raja_seisundi_liik_nimetus UNIQUE (nimetus),
)
;

CREATE TABLE Raja_raskus
(
	raja_raskus_kood integer NOT NULL,
	nimetus varchar(10) NOT NULL,
	CONSTRAINT PK_Raja_raskus PRIMARY KEY (raja_raskus_kood),
	CONSTRAINT AK_Raja_raskus_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Raja_raskus_nimetus_ei_koose_tyhikutest CHECK ((nimetus !~ '^[[:space:]]+$')),
	CONSTRAINT CHK_Raja_raskus_nimetus_ei_ole_tyhi CHECK ((nimetus <> ''))
)
;

CREATE TABLE Raja_kategooria_tyyp
(
	raja_kategooria_tyyp_kood smallint NOT NULL,
	nimetus d_nimetus,
	CONSTRAINT PK_Raja_kategooria_tyyp PRIMARY KEY (raja_kategooria_tyyp_kood),
	CONSTRAINT AK_Raja_kategooria_tyyp_nimetus UNIQUE (nimetus),
)
;

CREATE TABLE Raja_kategooria
(
	raja_kategooria_kood integer NOT NULL,
	nimetus d_nimetus,
	raja_kategooria_tyyp_kood integer NOT NULL,
	CONSTRAINT PK_Raja_kategooria PRIMARY KEY (raja_kategooria_kood),
	CONSTRAINT AK_raja_kategooria_nimetus_raja_kategooria_tyyp_kood UNIQUE (nimetus,raja_kategooria_tyyp_kood),
	CONSTRAINT FK_Raja_kategooria_Raja_kategooria_tyyp FOREIGN KEY (raja_kategooria_tyyp_kood) REFERENCES Raja_kategooria_tyyp (raja_kategooria_tyyp_kood) ON DELETE No Action ON UPDATE No Action
)
;
CREATE INDEX IXFK_Raja_kategooria_Raja_kategooria_tyyp ON Raja_kategooria (raja_kategooria_tyyp_kood ASC)
;
CREATE INDEX IXFK_Raja_kategooria_Raja_kategooria_tyyp_02 ON Raja_kategooria (raja_kategooria_tyyp_kood ASC)
;


CREATE TABLE Riik
(
	riik_kood char(3) NOT NULL,
	nimetus varchar(60) NOT NULL,
	CONSTRAINT PK_Riik PRIMARY KEY (riik_kood),
	CONSTRAINT AK_Riik_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Riik_nimetus_ei_koosne_tyhikutest CHECK ((nimetus !~ '^[[:space:]]+$')),
	CONSTRAINT CHK_Riik_nimetus_ei_ole_tyhi CHECK ((nimetus <> '')),
	CONSTRAINT CHK_Riik_kood_koosneb_kolmest_suurest_tahest CHECK ((riik_kood ~ '[A-Z]{3}'))
)
;

CREATE TABLE Kliendi_seisundi_liik
(
	kliendi_seisundi_liik_kood smallint NOT NULL,
	nimetus d_nimetus,
	CONSTRAINT PK_Kliendi_seisundi_liik PRIMARY KEY (kliendi_seisundi_liik_kood),
	CONSTRAINT AK_Kliendi_seisundi_liik_nimetus UNIQUE (nimetus),
)
;

CREATE TABLE Isiku_seisundi_liik
(
	isiku_seisundi_liik_kood smallint NOT NULL,
	nimetus d_nimetus,
	CONSTRAINT PK_Isiku_seisundi_liik PRIMARY KEY (isiku_seisundi_liik_kood),
	CONSTRAINT AK_isiku_seisundi_liik_nimetus UNIQUE (nimetus),
)
;

CREATE TABLE Amet
(
	amet_kood varchar(5) NOT NULL,
	nimetus varchar(20) NOT NULL,
	kirjeldus text NULL,
	CONSTRAINT PK_Amet PRIMARY KEY (amet_kood),
	CONSTRAINT AK_Amet_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Amet_kirjeldus_ei_koosne_tyhikutest CHECK ((kirjeldus !~ '^[[:space:]]*$')),
	CONSTRAINT CHK_Amet_kirjeldus_ei_ole_tyhi CHECK ((kirjeldus <> ''))
)
;

CREATE TABLE Isik
(
	isik_id serial NOT NULL,
	isikukood varchar(50) NOT NULL,
	isikukoodi_riik char(3) NOT NULL,
	e_meil varchar(254) NOT NULL,
	parool varchar(60) NOT NULL,
	isiku_seisundi_liik_kood smallint NOT NULL   DEFAULT 1,
	synni_kp date NOT NULL,
	reg_aeg timestamp without time zone NOT NULL   DEFAULT localtimestamp(0),
	eesnimi varchar(750) NULL,
	perenimi varchar(810) NULL,
	elukoht varchar(1000) NULL,
	CONSTRAINT PK_Isik PRIMARY KEY (isik_id),
	CONSTRAINT AK_Isik_e_meil UNIQUE (e_meil),
	CONSTRAINT AK_Isik_Isikukood_riik_kood UNIQUE (isikukoodi_riik,isikukood),
	CONSTRAINT CHK_Isik_isikukood_oige_struktuur CHECK ((isikukood ~ '([a-z])|([A-Z])|([0-9])|(/)|(-)|(\s)')),
	CONSTRAINT CHK_Isik_email_oige_struktuur CHECK ((e_meil ~ '^[a-z0-9._%-]+@[a-z0-9.-]+[.][a-z]+$')),
	CONSTRAINT CHK_Isik_eesnimi_perenimi_on_olemas CHECK ((eesnimi IS NOT NULL) OR (perenimi IS NOT NULL)),
	CONSTRAINT CHK_Isik_synni_kp_ajavahemik CHECK (synni_kp BETWEEN '1900-01-01' AND '2100-12-31'),
	CONSTRAINT CHK_Isik_reg_aeg_ajavahemik CHECK (reg_aeg BETWEEN '2010-01-01' AND '2100-12-31 23:59:59'),
	CONSTRAINT CHK_Isik_elukoht_ei_koosne_tyhikutest CHECK ((elukoht !~ '^[[:space:]]+$')),
	CONSTRAINT CHK_Isik_eesnimi_ei_koosne_tyhikutest CHECK (eesnimi !~ '^[[:space:]]+$'),
	CONSTRAINT CHK_Isik_perenimi_ei_koosne_tyhikutest CHECK ((perenimi !~ '^[[:space:]]+$')),
	CONSTRAINT CHK_Isik_isikukood_ei_koosne_tyhikutest CHECK ((isikukood ~! '^[[:space:]]+$')),
	CONSTRAINT CHK_Isik_eesnimi_ei_ole_tyhi_string CHECK (eesnimi <> ''),
	CONSTRAINT CHK_Isik_perenimi_ei_ole_tyhi_string CHECK (perenimi <> ''),
	CONSTRAINT CHK_Isik_isikukood_ei_ole_tyhi CHECK ((isikukood <> '')),
	CONSTRAINT CHK_Isik_elukoht_ei_ole_tyhi CHECK ((elukoht <> '')),
	CONSTRAINT CHK_Isik_elukoht_ei_koosne_numritest CHECK ((elukoht !~ '^[[:digit:]]+$')),
	CONSTRAINT FK_Isik_Isiku_seisundi_liik FOREIGN KEY (isiku_seisundi_liik_kood) REFERENCES Isiku_seisundi_liik (isiku_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Isik_Riik FOREIGN KEY (isikukoodi_riik) REFERENCES Riik (riik_kood) ON DELETE No Action ON UPDATE Cascade
)
;

CREATE DOMAIN d_reg_aeg TIMESTAMP without time zone NOT NULL DEFAULT localtimestamp(0)
CONSTRAINT CHK_reg_aeg_ajavahemik CHECK (
  VALUE BETWEEN '2010-01-01' AND '2100-12-31 23:59:59'
)

CREATE DOMAIN d_nimetus VARCHAR(20) NOT NULL
  CONSTRAINT CHK_nimetus_ei_koosne_tyhikutest CHECK (VALUE !~ '^[[:space:]]+$'),
  CONSTRAINT CHK_nimetus_ei_ole_tyhi_string CHECK (VALUE <> '')



CREATE INDEX IXFK_Isik_Isiku_seisundi_liik ON Isik (isiku_seisundi_liik_kood ASC)
;
CREATE INDEX IXFK_Isik_Riik ON Isik (isikukoodi_riik ASC)
;


CREATE TABLE Tootaja
(
	isik_id integer NOT NULL,
	amet_kood varchar(5) NOT NULL,
	tootaja_seisundi_liik_kood smallint NOT NULL   DEFAULT 1,
	mentor integer NULL,
	CONSTRAINT PK_Tootaja PRIMARY KEY (isik_id),
	CONSTRAINT FK_Tootaja_Amet FOREIGN KEY (amet_kood) REFERENCES Amet (amet_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Tootaja_Isik FOREIGN KEY (isik_id) REFERENCES Isik (isik_id) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Tootaja_Tootaja_seisundi_liik FOREIGN KEY (tootaja_seisundi_liik_kood) REFERENCES Tootaja_seisundi_liik (tootaja_seisundi_liik_kood) ON DELETE No Action ON UPDATE Cascade,
	CONSTRAINT FK_Tootaja_mentor FOREIGN KEY (mentor) REFERENCES Tootaja (isik_id) ON DELETE Set Null ON UPDATE No Action
)
;
CREATE INDEX IXFK_Tootaja_Amet ON Tootaja (amet_kood ASC)
;
CREATE INDEX IXFK_Tootaja_Isik ON Tootaja (isik_id ASC)
;
CREATE INDEX IXFK_Tootaja_mentor ON Tootaja (mentor ASC)
;
CREATE INDEX IXFK_Tootaja_Tootaja_seisundi_liik ON Tootaja (tootaja_seisundi_liik_kood ASC)
;


CREATE TABLE Klient
(
	isik_id integer NOT NULL,
	on_nous_tylitamisega boolean NOT NULL   DEFAULT false,
	kliendi_seisundi_liik_kood smallint NOT NULL   DEFAULT 1,
	CONSTRAINT PK_Klient PRIMARY KEY (isik_id),
	CONSTRAINT FK_Klient_Kliendi_seisundi_liik FOREIGN KEY (kliendi_seisundi_liik_kood) REFERENCES Kliendi_seisundi_liik (kliendi_seisundi_liik_kood) ON DELETE No Action ON UPDATE No Action,
	CONSTRAINT FK_Klient_Isik FOREIGN KEY (isik_id) REFERENCES Isik (isik_id) ON DELETE Cascade ON UPDATE No Action
)
;
CREATE INDEX IXFK_Klient_Kliendi_seisundi_liik ON Klient (kliendi_seisundi_liik_kood ASC)
;
CREATE INDEX IXFK_Klient_Kliendi_seisundi_liik_02 ON Klient (kliendi_seisundi_liik_kood ASC)
;
CREATE INDEX IXFK_Klient_Kliendi_seisundi_liik_03 ON Klient (kliendi_seisundi_liik_kood ASC)
;


CREATE TABLE Rada
(
	Raja_kood integer NOT NULL,
	nimetus d_nimetus,
	pikkus smallint NOT NULL,
	reg_aeg d_reg_aeg,
	registreerija_id smallint NOT NULL,
	raja_seisundi_liik_kood smallint NOT NULL DEFAULT 1,
	raja_raskus_kood smallint NOT NULL,
	isik_id integer NULL,
	CONSTRAINT PK_Rada PRIMARY KEY (Raja_kood),
	CONSTRAINT AK_Rada_nimetus UNIQUE (nimetus),
	CONSTRAINT CHK_Rada_pikkus_nulli_suurem CHECK (pikkus > 0),
	CONSTRAINT FK_Rada_Raja_raskus FOREIGN KEY (raja_raskus_kood) REFERENCES Raja_raskus (raja_raskus_kood) ON DELETE No Action ON UPDATE No Action,
	CONSTRAINT FK_Rada_Raja_seisundi_liik FOREIGN KEY (raja_seisundi_liik_kood) REFERENCES Raja_seisundi_liik (raja_seisundi_liik_kood) ON DELETE No Action ON UPDATE No Action,
	CONSTRAINT FK_Rada_Tootaja FOREIGN KEY (isik_id) REFERENCES Tootaja (isik_id) ON DELETE No Action ON UPDATE No Action
)
;
CREATE INDEX IXFK_Rada_Raja_raskus ON Rada (raja_raskus_kood ASC)
;
CREATE INDEX IXFK_Rada_Raja_raskus_02 ON Rada (raja_raskus_kood ASC)
;
CREATE INDEX IXFK_Rada_Raja_seisundi_liik ON Rada (raja_seisundi_liik_kood ASC)
;
CREATE INDEX IXFK_Rada_Raja_seisundi_liik_02 ON Rada (raja_seisundi_liik_kood ASC)
;
CREATE INDEX IXFK_Rada_Tootaja ON Rada (registreerija_id ASC)
;
CREATE INDEX IXFK_Rada_Tootaja_02 ON Rada (isik_id ASC)
;


CREATE TABLE Raja_kategooria_omamine
(
	Raja_kood integer NOT NULL,
	Raja_kategooria_kood integer NOT NULL,
	CONSTRAINT PK_Raja_kategooria_omamine PRIMARY KEY (Raja_kood,Raja_kategooria_kood),
	CONSTRAINT FK_Raja_kategooria_omamine_Rada FOREIGN KEY (Raja_kood) REFERENCES Rada (Raja_kood) ON DELETE Cascade ON UPDATE Cascade,
	CONSTRAINT FK_Raja_kategooria_omamine_Raja_kategooria FOREIGN KEY (Raja_kategooria_kood) REFERENCES Raja_kategooria (raja_kategooria_kood) ON DELETE No Action ON UPDATE Cascade
)
;
CREATE INDEX IXFK_Raja_kategooria_omamine_Rada ON Raja_kategooria_omamine (Raja_kood ASC)
;
CREATE INDEX IXFK_Raja_kategooria_omamine_Raja_kategooria ON Raja_kategooria_omamine (Raja_kategooria_kood ASC)
;




 
