CREATE TABLE radio (
    nombre VARCHAR2(30) PRIMARY KEY,
    direccion VARCHAR2(30) NOT NULL,
    web VARCHAR2(30) NOT NULL,
    email VARCHAR2(30) NOT NULL,
    telefono VARCHAR2(15) NOT NULL
);

CREATE TABLE emision (
    radio VARCHAR2(30) PRIMARY KEY,
    fechahora VARCHAR2(30) PRIMARY KEY,
    numPista NUMBER(2) NOT NULL,
    cara VARCHAR2(30) NOT NULL,
    ISVN VARCHAR2(30) NOT NULL,
    FOREIGN KEY (numPista) REFERENCES radio,
    FOREIGN KEY (cara) REFERENCES radio,
    FOREIGN KEY (ISVN) REFERENCES radio
);

CREATE TABLE tema (
    numPista NUMBER(2) PRIMARY KEY,
    cara VARCHAR2(30) PRIMARY KEY,
    ISVN VARCHAR2(30) PRIMARY KEY,
    duracion NUMBER(5) NOT NULL,
    autor VARCHAR2(30)NOT NULL,
    titulo VARCHAR2(30) NOT NULL,
    estudio VARCHAR2(30) NOT NULL,
    FOREIGN KEY (estudio) REFERENCES estudio
);

CREATE TABLE estudio (
    nombreEstudio VARCHAR2(30) PRIMARY KEY,
    direccion VARCHAR2(30) NOT NULL,
    nombreTecnico VARCHAR2(30) NOT NULL,
    apellido1tecnico VARCHAR2(30) NOT NULL,
    apellido2tecnico VARCHAR2(30) NULL
);

CREATE TABLE manager (
    idManager NUMBER(5) PRIMARY KEY,
    nombre VARCHAR2(30) NOT NULL,
    apellido1 VARCHAR2(30) NOT NULL,
    apellido2 VARCHAR2(30) NULL,
    telefono VARCHAR2(15) NOT NULL
);

CREATE TABLE discografica(
    nombre VARCHAR2(30) PRIMARY KEY,
    telefono VARCHAR2(15) NOT NULL
);

CREATE TABLE vinilo(
    ISVN VARCHAR2(30) PRIMARY KEY,
    formato VARCHAR2(30) NOT NULL,
    velocidad NUMBER(4) NOT NULL,
    agujero NUMBER(5) NOT NULL,
    artista VARCHAR2(30) NOT NULL,
    FOREIGN KEY (artista) REFERENCES artista,
    discografica VARCHAR2(30) NOT NULL,
    FOREIGN KEY (discografica) REFERENCES discografica,
    fechaLanz VARCHAR2(8) NOT NULL,
    manager NUMBER(5) NOT NULL,
    FOREIGN KEY (manager) REFERENCES manager,
    maqA VARCHAR2(30) NOT NULL,
    FOREIGN KEY (maqA) REFERENCES empresagrafica,
    maqB VARCHAR2(30) NOT NULL,
    FOREIGN KEY (maqB) REFERENCES empresagrafica
);

CREATE TABLE artista(
    nombre VARCHAR2(30) PRIMARY KEY,
    nacionnalidad VARCHAR2(30) NOT NULL,
    idioma varchar2(30) NOT NULL
);

CREATE TABLE miembro(
    grupo VARCHAR2(30) PRIMARY KEY ,
    rol VARCHAR2(30) PRIMARY KEY ,
    nombre VARCHAR2(30) PRIMARY KEY ,
    FOREIGN KEY (grupo) REFERENCES artista
);

CREATE TABLE ranking(
    ISVN VARCHAR2(30) PRIMARY KEY ,
    posicion VARCHAR2(30) NOT NULL ,
    semanas NUMBER(2) NOT NULL,
    FOREIGN KEY (ISVN) REFERENCES single
);

CREATE TABLE single(
    ISVN VARCHAR2(30) PRIMARY KEY ,
    ISVNAlbum VARCHAR2(30) ,
    FOREIGN KEY (ISVN) REFERENCES vinilo
);

CREATE TABLE album(
    ISVN VARCHAR2(30) PRIMARY KEY ,
    copiasLanzamiento NUMBER(5) NOT NULL ,
    copiasTotales NUMBER(5) NOT NULL
);

CREATE TABLE empresagrafica(
    nombre VARCHAR2(30) PRIMARY KEY ,
    direccion VARCHAR2(30) NOT NULL
);

CREATE TABLE portada(
    ISVN VARCHAR2(30) PRIMARY KEY ,
    cara VARCHAR2(30) PRIMARY KEY ,
    rol VARCHAR2(30) PRIMARY KEY ,
    nombreProfesional VARCHAR2(30) NOT NULL ,
    FOREIGN KEY (ISVN) REFERENCES vinilo
);
