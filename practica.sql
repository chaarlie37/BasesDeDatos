
DROP TABLE radio CASCADE CONSTRAINTS;
CREATE TABLE radio (
    nombre VARCHAR2(30),
    direccion VARCHAR2(30) NOT NULL,
    web VARCHAR2(30) NOT NULL UNIQUE ,
    email VARCHAR2(30) NOT NULL,
    telefono VARCHAR2(15) NOT NULL,
    PRIMARY KEY (nombre)
);

DROP TABLE emision CASCADE CONSTRAINTS;
CREATE TABLE emision (
    radio VARCHAR2(30),
    fechahora VARCHAR2(30),
    numPista NUMBER(2) NOT NULL,
    cara VARCHAR2(30) NOT NULL,
    ISVN VARCHAR2(30) NOT NULL,
    FOREIGN KEY (numPista, cara, ISVN) REFERENCES tema,
    PRIMARY KEY (radio, fechahora)
);

DROP TABLE estudio CASCADE CONSTRAINTS;
CREATE TABLE estudio (
    nombreEstudio VARCHAR2(30),
    direccion VARCHAR2(30) NOT NULL,
    nombreTecnico VARCHAR2(30) NOT NULL,
    apellido1tecnico VARCHAR2(30) NOT NULL,
    apellido2tecnico VARCHAR2(30) NULL,
    PRIMARY KEY (nombreEstudio)
);

DROP TABLE tema CASCADE CONSTRAINTS;
CREATE TABLE tema (
    numPista NUMBER(2),
    cara VARCHAR2(30),
    ISVN VARCHAR2(30),
    duracion NUMBER(5) NOT NULL,
    autor VARCHAR2(30)NOT NULL,
    titulo VARCHAR2(30) NOT NULL,
    estudio VARCHAR2(30) NOT NULL,
    FOREIGN KEY (estudio) REFERENCES estudio,
    PRIMARY KEY (numPista, cara, ISVN)
);


DROP TABLE manager CASCADE CONSTRAINTS;
CREATE TABLE manager (
    idManager NUMBER(5),
    nombre VARCHAR2(30) NOT NULL,
    apellido1 VARCHAR2(30) NOT NULL,
    apellido2 VARCHAR2(30) NULL,
    telefono VARCHAR2(15) NOT NULL,
    PRIMARY KEY (idManager)
);

DROP TABLE discografica CASCADE CONSTRAINTS;
CREATE TABLE discografica(
    nombre VARCHAR2(30),
    telefono VARCHAR2(15) NOT NULL,
    PRIMARY KEY (nombre)
);

DROP TABLE vinilo CASCADE CONSTRAINTS;
CREATE TABLE vinilo(
    ISVN VARCHAR2(30),
    formato VARCHAR2(30) NOT NULL,
    velocidad NUMBER(4) NOT NULL,
    agujero NUMBER(5) NOT NULL,
    artista VARCHAR2(30) NOT NULL,
    FOREIGN KEY (artista) REFERENCES artista,
    discografica VARCHAR2(30) NOT NULL,
    FOREIGN KEY (discografica) REFERENCES discografica,
    fechaLanz VARCHAR2(15) NOT NULL,
    manager NUMBER(5) NOT NULL,
    FOREIGN KEY (manager) REFERENCES manager,
    maqA VARCHAR2(30) NOT NULL,
    FOREIGN KEY (maqA) REFERENCES empresagrafica,
    maqB VARCHAR2(30) NOT NULL,
    FOREIGN KEY (maqB) REFERENCES empresagrafica,
    PRIMARY KEY (ISVN)
);

DROP TABLE artista CASCADE CONSTRAINTS;
CREATE TABLE artista(
    nombre VARCHAR2(30),
    nacionnalidad VARCHAR2(30) NOT NULL,
    idioma varchar2(30) NOT NULL,
    PRIMARY KEY (nombre)
);

DROP TABLE miembro CASCADE CONSTRAINTS;
CREATE TABLE miembro(
    grupo VARCHAR2(30),
    rol VARCHAR2(30),
    nombre VARCHAR2(30),
    FOREIGN KEY (grupo) REFERENCES artista,
    PRIMARY KEY (grupo, rol, nombre)
);

DROP TABLE ranking CASCADE CONSTRAINTS;
CREATE TABLE ranking(
    ISVN VARCHAR2(30),
    posicion NUMBER(3) NOT NULL ,
    semanas NUMBER(2) NOT NULL,
    FOREIGN KEY (ISVN) REFERENCES single,
    PRIMARY KEY (ISVN)
);

DROP TABLE single CASCADE CONSTRAINTS;
CREATE TABLE single(
    ISVN VARCHAR2(30),
    ISVNAlbum VARCHAR2(30) ,
    FOREIGN KEY (ISVN) REFERENCES vinilo,
    PRIMARY KEY (ISVN)
);

DROP TABLE album CASCADE CONSTRAINTS;
CREATE TABLE album(
    ISVN VARCHAR2(30),
    copiasLanzamiento NUMBER(5) NOT NULL ,
    copiasTotales NUMBER(5) NOT NULL,
    PRIMARY KEY (ISVN)
);

DROP TABLE empresagrafica CASCADE CONSTRAINTS;
CREATE TABLE empresagrafica(
    nombre VARCHAR2(30),
    direccion VARCHAR2(30) NOT NULL,
    PRIMARY KEY (nombre)
);

DROP TABLE portada CASCADE CONSTRAINTS;
CREATE TABLE portada(
    ISVN VARCHAR2(30),
    cara VARCHAR2(30),
    rol VARCHAR2(30),
    CONSTRAINT check_rol CHECK (rol IN ('fotografo', 'dibujante', 'maquetador')),
    nombreProfesional VARCHAR2(30) NOT NULL ,
    FOREIGN KEY (ISVN) REFERENCES vinilo,
    PRIMARY KEY (ISVN, cara, rol)
);



ALTER TABLE miembro ADD fecha_incorporacion VARCHAR2(10);
UPDATE miembro SET fecha_incorporacion = '1/1/79' WHERE fecha_incorporacion IS NULL;
ALTER TABLE miembro MODIFY fecha_incorporacion VARCHAR2(10) NOT NULL;
INSERT INTO radio VALUES ('Ser', 'Calle Gran Vía', 'www.ser.es', 'ser@ser.es', '123456789');
INSERT INTO radio VALUES ('Cadena 100', 'Calle Gran Vía', 'www.cadena100.com', 'ser@ser.es', '123456789');
INSERT INTO emision VALUES ('Ser', '27/11/2019 12:52', 27, 'A', '1234567A');
INSERT INTO estudio VALUES ('NombreEstudio1', 'Calle Estudio1', 'NombreTecnico1', 'Apellido1Tecnico', NULL);
INSERT INTO tema VALUES (1, 'A', '1234567A', 327, 'Autor1', 'Titulo1', 'NombreEstudio1');
INSERT INTO manager VALUES (00000, 'NombreManager1', 'Apellido1Manager1', 'Apellido2Manager1', '987654321');
INSERT INTO discografica VALUES ('Discografica1', '192837465');
INSERT INTO vinilo VALUES ('1234567A', 'Formato1', 300, 2, 'Artista1', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO artista VALUES ('Artista1', 'Española', 'ESP');
INSERT INTO miembro (grupo, rol, nombre) VALUES ('Artista1', 'Bateria', 'Miembro1');
UPDATE miembro SET fecha_incorporacion = '1/1/10' WHERE nombre = 'Miembro1' AND rol = 'Bateria' AND grupo = 'Artista1';
INSERT INTO ranking VALUES ('11111111A', 1, 2);
INSERT INTO single VALUES ('1234567A', '1234567A');
INSERT INTO album VALUES ('1234567A', 5000, 15000);
INSERT INTO empresagrafica VALUES ('EmpresaGrafica1', 'Calle Empresa Grafica 1');
INSERT INTO portada VALUES ('1234567A', 'A', 'fotografo', 'Nombre Profesional 1');

ALTER TABLE tema MODIFY estudio VARCHAR2(30);

INSERT INTO artista VALUES ('DjRAR', 'Inglesa', 'ING');
INSERT INTO album VALUES ('1234567B', 100, 15000);
INSERT INTO vinilo VALUES ('1234567B', 'Formato1', 300, 2, 'DjRAR', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
UPDATE album SET copiasLanzamiento = copiasLanzamiento * 2 WHERE ISVN IN (SELECT ISVN FROM vinilo WHERE vinilo.artista = 'DjRAR');
SELECT album.copiasLanzamiento FROM album;

INSERT INTO discografica VALUES ('Discografica2', '192837465');
INSERT INTO vinilo VALUES ('1234567C', 'Formato1', 300, 2, 'DjRAR', 'Discografica2', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO album VALUES ('1234567C', 100, 30000);
UPDATE album SET copiasTotales = copiasTotales + 100 WHERE ISVN IN (SELECT ISVN FROM vinilo WHERE vinilo.discografica = 'Discografica2');
SELECT album.copiasTotales FROM album;

INSERT INTO vinilo VALUES ('1234567G', 'Formato1', 300, 2, 'DjRAR', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO vinilo VALUES ('1234567D', 'Formato1', 300, 2, 'DjRAR', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO vinilo VALUES ('1234567E', 'Formato1', 300, 2, 'DjRAR', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO vinilo VALUES ('1234567F', 'Formato1', 300, 2, 'DjRAR', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO single VALUES ('1234567G', '1234567C');
INSERT INTO single VALUES ('1234567D', '1234567D');
INSERT INTO single VALUES ('1234567E', '1234567E');
INSERT INTO single VALUES ('1234567F', '1234567F');
INSERT INTO ranking VALUES ('1234567G', 3, 7);
INSERT INTO ranking VALUES ('1234567D', 4, 1);
INSERT INTO ranking VALUES ('1234567E', 12, 8);
INSERT INTO ranking VALUES ('1234567F', 14, 5);

SELECT * FROM ranking;

DELETE ranking WHERE semanas < (SELECT AVG(semanas) FROM ranking) AND posicion < 10;

SELECT * FROM ranking;

INSERT INTO artista VALUES ('DjRAR', 'Inglesa', 'ING');
INSERT INTO artista VALUES ('DjRAR1', 'Inglesa', 'ING');
INSERT INTO artista VALUES ('DjRAR2', 'Inglesa', 'ING');
INSERT INTO artista VALUES ('DjRAR3', 'Inglesa', 'ING');
INSERT INTO artista VALUES ('Manolo Escobar', 'Española', 'ING');

INSERT INTO vinilo VALUES ('1234567L', 'Formato1', 300, 2, 'DjRAR', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO vinilo VALUES ('1234567I', 'Formato1', 300, 2, 'DjRAR1', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO vinilo VALUES ('1234567J', 'Formato1', 300, 2, 'DjRAR2', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO vinilo VALUES ('1234567K', 'Formato1', 300, 2, 'DjRAR3', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');
INSERT INTO vinilo VALUES ('1234567M', 'Formato1', 300, 2, 'Manolo Escobar', 'Discografica1', '01/01/2019', 00000, 'EmpresaGrafica1', 'EmpresaGrfica2');

SELECT * FROM vinilo WHERE artista IN (SELECT nombre FROM artista WHERE nacionnalidad = 'Inglesa');

--SELECT nombre FROM artista WHERE nacionnalidad = 'Española';

INSERT INTO emision VALUES ('Ser', '27/11/2019 12:59', 1, 'A', '1234567A');

SELECT * FROM tema WHERE ISVN NOT IN (SELECT emision.ISVN FROM emision);

INSERT INTO tema VALUES (1, 'A', '1234567B', 277, 'Autor1', 'Titulo1', 'NombreEstudio1');

SELECT * FROM album WHERE ISVN NOT IN (SELECT ISVN FROM single);

INSERT INTO album VALUES ('1234567M', 100, 30000);
INSERT INTO single VALUES ('1234567M', '1234567M');
INSERT INTO single VALUES ('1234567B', '1234567M');

SELECT AVG(duracion) FROM tema WHERE ISVN IN (SELECT ISVN FROM single);

ALTER TABLE emision DROP PRIMARY KEY;
ALTER TABLE emision DROP COLUMN fechahora;
ALTER TABLE emision ADD (fechahora DATE);
ALTER TABLE emision ADD PRIMARY KEY (radio, fechahora);
UPDATE emision SET fechahora = TO_DATE('01/01/2019 00:00:05', 'DD/MM/YYYY HH24:MI:SS') WHERE radio = 'Ser';

INSERT INTO emision VALUES ('Ser', 27, 'A', '1234567M', TO_DATE('27/11/2019 10:13:47', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO emision VALUES ('Ser', 27, 'A', '1234567J', TO_DATE('27/11/2019 10:14:47', 'DD/MM/YYYY HH24:MI:SS'));
INSERT INTO emision VALUES ('Ser', 27, 'A', '1234567I', TO_DATE('27/11/2019 10:15:47', 'DD/MM/YYYY HH24:MI:SS'));

SELECT nombre, COUNT() c FROM (SELECT nombre FROM radio WHERE nombre IN (SELECT nombre FROM emision WHERE SYSDATE - emision.fechahora <= 30))as n, (SELECT COUNT(*) FROM emision WHERE SYSDATE - emision.fechahora <= 30) as c );

INSERT INTO emision VALUES ('Cadena 100', 27, 'A', '1234567I', TO_DATE('27/11/2019 10:15:47', 'DD/MM/YYYY HH24:MI:SS'));

-- 6.6
SELECT radio, COUNT(*) FROM emision GROUP BY radio;

SELECT emision.ISVN FROM emision GROUP BY ISVN
