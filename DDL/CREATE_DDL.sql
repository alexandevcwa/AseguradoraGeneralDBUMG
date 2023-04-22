CREATE TABLE MIUMG.TIPOSSEGUROS
(
    IDTSEGURO NUMBER(3, 0) GENERATED ALWAYS AS IDENTITY, --ID DE SEGURO CON ID AUTOGENERADO
    SEGURO    NVARCHAR2(48) NOT NULL UNIQUE,             --TIPO DE SEGURO
    PRIMARY KEY (IDTSEGURO)                              --LLAVE PRIMARIA DE TABLA
);

CREATE TABLE MIUMG.MARCAS
(
    IDMARCA NUMBER(7, 0) GENERATED ALWAYS AS IDENTITY, --ID DE MARCA
    MARCA   NVARCHAR2(48) NOT NULL UNIQUE,             --NOMBRE DE MARCA
    PRIMARY KEY (IDMARCA)                              --LLAVE PRIMARIA DE TABLA
);

CREATE TABLE MIUMG.TIPOSMATRICULAS
(
    IDTMATRICULA NUMBER(4, 0) GENERATED ALWAYS AS IDENTITY, --ID DE TIPO DE MATROCULA
    TMATRICULA   NVARCHAR2(4) NOT NULL UNIQUE,              --TIPO DE MATRICULA
    PRIMARY KEY (IDTMATRICULA)                              --LLAVE PRIMARIA DE TABLA
);

CREATE TABLE MIUMG.DEPARTAMENTOS
(
    IDDEPTO NUMBER(4, 0) GENERATED ALWAYS AS IDENTITY, --ID DE DEPARTAMENTO
    DEPTO   NVARCHAR2(48) NOT NULL UNIQUE,             --NOMBRE DE DEPARTAMENTO
    PRIMARY KEY (IDDEPTO)                              --LLAVE PRIMARIA DE DEPARTAMENTO
);

CREATE TABLE MIUMG.MUNICIPIOS
(
    IDMUNI    NUMBER(5, 0) GENERATED ALWAYS AS IDENTITY,     --ID DE MUNICIPIO
    MUNICIPIO NVARCHAR2(48) NOT NULL,                        --NOMBRE DE MUNICIPIO
    IDDEPTO   NUMBER(4, 0)  NOT NULL,                        --ID DE LA PK DE LA TABLA DEPARTAMENTOS
    PRIMARY KEY (IDMUNI),                                    --LLAVE PRIMARIA DE TABLA
    FOREIGN KEY (IDDEPTO) REFERENCES DEPARTAMENTOS (IDDEPTO) --LLAVE FORANEA DEL ATRIBUTO IDDEPTO
);

CREATE TABLE MIUMG.CLIENTES
(
    CUI       NVARCHAR2(13)  NOT NULL UNIQUE, --CUI DEL CLIENTE
    NIT       NVARCHAR2(12) PRIMARY KEY,      --NIT DEL CLIENTE
    NOMBRE    NVARCHAR2(60)  NOT NULL,        --NOMBRE COMPLETO DEL CLIENTE
    DIRECCION NVARCHAR2(160) NOT NULL,        --DIRECCIÓN DEL CLIENTE
    IDMUNI    NUMBER(5, 0)   NOT NULL,        --ID DEL MUNICIPIO AL QUE PERTENECE EL CLIENTE
    FOREIGN KEY (IDMUNI) REFERENCES MUNICIPIOS (IDMUNI)
);

CREATE TABLE MIUMG.MODELOSVEHICULOS
(
    IDMODELO NUMERIC(4, 0) PRIMARY KEY,
    MODELO   DATE NOT NULL
);

CREATE TABLE MIUMG.CILINDROSMOTOR
(
    IDCILINDROS NUMERIC(2, 0),
    NOCILINDROS NUMERIC(2, 0)
);

CREATE TABLE MIUMG.COLORES
(
    IDCOLOR NUMERIC(5, 0),
    COLOR   NVARCHAR2(45)
);

CREATE TABLE MIUMG.VEHICULOS
(
    MATRICULA      NVARCHAR2(12) PRIMARY KEY, --MATRICULO DEL VEHICULO
    IDTMATRICULA   NUMBER(4)     NOT NULL,    --ID DE TIPO DE MATRICULAS VALIDAS
    FECHAMATRICULA DATE          NOT NULL,    --FECHA DE LA MATRICULA
    IDMODELO       NUMBER(4, 0)  NOT NULL,    --MODELO DEL VEHICULO
    IDCILINDROS    NUMBER(2, 0)  NOT NULL,    --CILINDROS DEL VEHICULO
    IDCOLOR        NUMERIC(5, 0) NOT NULL,    --COLOR DEL VEHICULO DESCRITO EN LETRAS
    IDMARCA        NUMBER(7, 0)  NOT NULL,    --ID DE LA MARCA DEL VEHICULO
    PRECIO         NUMBER(11, 3) NOT NULL,    --PRECIO DEL VEHICULO
    FOREIGN KEY (IDTMATRICULA) REFERENCES TIPOSMATRICULAS (IDTMATRICULA),
    FOREIGN KEY (IDMARCA) REFERENCES MARCAS (IDMARCA),
    FOREIGN KEY (IDMODELO) REFERENCES MODELOSVEHICULOS (IDMODELO),
    FOREIGN KEY (IDCILINDROS) REFERENCES CILINDROSMOTOR (IDCILINDROS),
    FOREIGN KEY (IDCOLOR) REFERENCES COLORES (IDCOLOR)
);

CREATE TABLE MIUMG.CLIENTESVEHICULOS
(
    NIT       NVARCHAR2(12) NOT NULL, --NIT DEL CLIETE
    MATRICULA NVARCHAR2(12) NOT NULL, --MATRICULA DEL VEHICULO
    PRIMARY KEY (NIT, MATRICULA),
    FOREIGN KEY (NIT) REFERENCES CLIENTES (NIT),
    FOREIGN KEY (MATRICULA) REFERENCES VEHICULOS (MATRICULA)
);

CREATE TABLE MIUMG.SEGUROS
(
    IDSEGURO     NUMBER(8) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    IDTSEGURO    NUMBER(3)     NOT NULL,
    VALORPRIMA   NUMBER(11, 3) NOT NULL,
    FECHAINICIO  DATE          NOT NULL,
    FECHAFINAL   DATE          NOT NULL,
    NOPOLIZA     NVARCHAR2(24) NOT NULL UNIQUE,
    FECHACOTIZA  DATE DEFAULT SYSDATE,
    ESTADOPOLIZA NUMBER(1)     NOT NULL,
    NIT          NVARCHAR2(12) NOT NULL,
    FOREIGN KEY (IDTSEGURO) REFERENCES TIPOSSEGUROS (IDTSEGURO),
    FOREIGN KEY (NIT) REFERENCES CLIENTES (NIT)
);

CREATE TABLE MIUMG.SEGUROSDETALLE
(
    IDSEGURODETALLE NUMBER(8, 0) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    IDSEGURO        NUMBER(8, 0)  NOT NULL,
    MATRICULA       NVARCHAR2(12) NOT NULL,
    FOREIGN KEY (IDSEGURO) REFERENCES SEGUROS (IDSEGURO),
    FOREIGN KEY (MATRICULA) REFERENCES VEHICULOS (MATRICULA)
);

CREATE INDEX INDEX_CLIENTES_CUI_NIT_NOMBRE
    ON CLIENTES (CUI, NIT, NOMBRE);

CREATE INDEX INDEX_VEHICULOS_MATRICULA
    ON VEHICULOS (MATRICULA);

CREATE PUBLIC SYNONYM DEPARTAMENTOS FOR MIUMG.DEPARTAMENTOS;

CREATE PUBLIC SYNONYM MUNICIPIOS FOR MIUMG.MUNICIPIOS;

CREATE OR REPLACE VIEW MIUMG.VM_VITACORA_TRASPASOS_VEHICULOS AS
SELECT CLIENTESVEHICULOS.MATRICULA MATRICULA,
       MARCA,
       TO_DATE('YYYY',MODELOSVEHICULOS.MODELO),
       VEHICULOS.PRECIO,
       CLIENTESVEHICULOS.NIT,
       CLIENTES.NOMBRE,
       CLIENTES.CUI,
       CLIENTES.DIRECCION
FROM CLIENTESVEHICULOS,
     MARCAS,MODELOSVEHICULOS
         INNER JOIN VEHICULOS ON MATRICULA = VEHICULOS.MATRICULA
         INNER JOIN CLIENTES ON NIT = CLIENTES.NIT
WHERE VEHICULOS.IDMARCA = MARCAS.IDMARCA AND VEHICULOS.IDMODELO = MODELOSVEHICULOS.IDMODELO;