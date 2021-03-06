--------------------------------------------------------------------------
--DELETES DE LAS TABLAS--
-------------------------------------------------------------------------
DELETE FROM Transaccion;
DELETE FROM Ubicacion;
DELETE FROM Deuda;
DELETE FROM Cuenta;
DELETE FROM ES_APROBADA;
DELETE FROM Pertenece_a;
DELETE FROM Cuenta;
DELETE FROM Contacto_de;
DELETE FROM LiderGrupo;
DELETE FROM Grupo;
DELETE FROM Usuario;
DELETE FROM AuditoriaAprobada;
DELETE FROM AuditoriaContactos;
DELETE FROM AuditoriaCuenta;
DELETE FROM AuditoriaDeuda;
DELETE FROM AuditoriaGrupos;
DELETE FROM AuditoriaPertenece;
DELETE FROM AuditoriaTransaccion;
DELETE FROM AuditoriaUbicacion;
DELETE FROM AuditoriaUsuario;
DELETE FROM AuditoriaLiderGrupo;
-------------------------------------------------------------------------
--Tablas de Auditorias--
------------------------------------------------------------------------
DROP TABLE AuditoriaAprobada CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaContactos CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaCuenta CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaDeuda CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaGrupos CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaPertenece CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaTransaccion CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaUbicacion CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaUsuario CASCADE CONSTRAINTS ;

DROP TABLE AuditoriaLiderGrupo CASCADE CONSTRAINTS ;


CREATE TABLE AuditoriaLiderGrupo
  (
    fecha         DATE NOT NULL ,
    operacion     CHAR (1 CHAR) NOT NULL ,
    valorNuevo    VARCHAR2 (50 CHAR) ,
    valorAnterior VARCHAR2 (50 CHAR) ,
    columna       VARCHAR2 (50 CHAR) ,
    fechaIngreso  DATE NOT NULL ,
    Grupo_id      NUMBER (5) NOT NULL ,
    Usuario_id    NUMBER (5) NOT NULL
  ) ;
ALTER TABLE AuditoriaLiderGrupo ADD CONSTRAINT AuditoriaLiderGrupo_PK PRIMARY KEY ( operacion, fecha, fechaIngreso, Grupo_id, Usuario_id ) ;

CREATE TABLE AuditoriaAprobada
  (
    fecha                        DATE NOT NULL ,
    operacion                    CHAR (1 CHAR) NOT NULL ,
    valorNuevo                   VARCHAR2 (50 CHAR) ,
    valorAnterior                VARCHAR2 (50 CHAR) ,
    columna                      VARCHAR2 (50 CHAR) ,
    Transaccion_id               NUMBER (5) NOT NULL ,
    Transaccion_Deuda_Cuenta_id  NUMBER (10) NOT NULL ,
    Transaccion_Deuda_Usuario_id NUMBER (5) NOT NULL ,
    Transaccion_Deuda_id_Deuda   NUMBER (5) NOT NULL ,
    LiderGrupo_fechaIngreso      DATE NOT NULL ,
    LiderGrupo_Grupo_id          NUMBER (5) NOT NULL ,
    LiderGrupo_Usuario_id        NUMBER (5) NOT NULL
  ) ;
CREATE INDEX AuditoriaAprobada__IDX ON AuditoriaAprobada
  (
    Transaccion_id ASC ,
    Transaccion_Deuda_Cuenta_id ASC ,
    Transaccion_Deuda_Usuario_id ASC ,
    Transaccion_Deuda_id_Deuda ASC ,
    LiderGrupo_fechaIngreso ASC ,
    LiderGrupo_Grupo_id ASC ,
    LiderGrupo_Usuario_id ASC
  ) ;
ALTER TABLE AuditoriaAprobada ADD CONSTRAINT AuditoriaAprobada_PK PRIMARY KEY ( fecha, operacion, Transaccion_id, Transaccion_Deuda_Cuenta_id, Transaccion_Deuda_Usuario_id, LiderGrupo_Grupo_id, LiderGrupo_fechaIngreso, LiderGrupo_Usuario_id, Transaccion_Deuda_id_Deuda ) ;


CREATE TABLE AuditoriaContactos
  (
    fecha      DATE NOT NULL ,
    operacion  CHAR (1 CHAR) NOT NULL ,
    id_usuario NUMBER (5) NOT NULL ,
    contacto   NUMBER (5) NOT NULL
  ) ;
ALTER TABLE AuditoriaContactos ADD CONSTRAINT AuditoriaContactos_PK PRIMARY KEY ( fecha, operacion, id_usuario, contacto ) ;


CREATE TABLE AuditoriaCuenta
  (
    fecha         DATE NOT NULL ,
    operacion     CHAR (1 CHAR) NOT NULL ,
    valorNuevo    VARCHAR2 (50 CHAR) NOT NULL ,
    valorAnterior VARCHAR2 (50 CHAR) NOT NULL ,
    id_cuenta     NUMBER (10) NOT NULL ,
    columna       VARCHAR2 (50 CHAR)
  ) ;
ALTER TABLE AuditoriaCuenta ADD CONSTRAINT AuditoriaCuenta_PK PRIMARY KEY ( fecha, operacion, valorNuevo, valorAnterior, id_cuenta ) ;


CREATE TABLE AuditoriaDeuda
  (
    fecha         DATE NOT NULL ,
    operacion     CHAR (1 CHAR) NOT NULL ,
    id_deuda      NUMBER (10) NOT NULL ,
    usuario_id    NUMBER (5) NOT NULL ,
    cuenta_id     NUMBER (10) NOT NULL ,
    valorNuevo    VARCHAR2 (50 CHAR) ,
    valorAnterior VARCHAR2 (50 CHAR) ,
    columna       VARCHAR2 (50 CHAR)
  ) ;
ALTER TABLE AuditoriaDeuda ADD CONSTRAINT AuditoriaDeuda_PK PRIMARY KEY ( fecha, operacion, id_deuda, usuario_id, cuenta_id ) ;


CREATE TABLE AuditoriaGrupos
  (
    fecha         DATE NOT NULL ,
    operacion     CHAR (1 CHAR) NOT NULL ,
    valorNuevo    VARCHAR2 (50 CHAR) NOT NULL ,
    valorAnterior VARCHAR2 (50 CHAR) NOT NULL ,
    id_grupo      NUMBER (5) NOT NULL ,
    columna       VARCHAR2 (50 CHAR)
  ) ;
ALTER TABLE AuditoriaGrupos ADD CONSTRAINT AuditoriaGrupos_PK PRIMARY KEY ( id_grupo, valorAnterior, valorNuevo, operacion, fecha ) ;


CREATE TABLE AuditoriaPertenece
  (
    fecha         DATE NOT NULL ,
    operacion     CHAR (1 CHAR) NOT NULL ,
    id_usuario    NUMBER (5) NOT NULL ,
    grupo_id      NUMBER (10) NOT NULL ,
    fechaIngreso  DATE NOT NULL ,
    valorNuevo    VARCHAR2 (50 CHAR) ,
    valorAnterior VARCHAR2 (50 CHAR) ,
    columna       VARCHAR2 (50 CHAR)
  ) ;
ALTER TABLE AuditoriaPertenece ADD CONSTRAINT AuditoriaPertenece_PK PRIMARY KEY ( operacion, fecha, id_usuario, grupo_id, fechaIngreso ) ;


CREATE TABLE AuditoriaTransaccion
  (
    fecha            DATE NOT NULL ,
    operacion        CHAR (1 CHAR) NOT NULL ,
    valorNuevo       VARCHAR2 (50 CHAR) ,
    valorAnterior    VARCHAR2 (50 CHAR) ,
    columna          VARCHAR2 (50 CHAR) ,
    id_transaccion   NUMBER (5) NOT NULL ,
    Deuda_Cuenta_id  NUMBER (10) NOT NULL ,
    Deuda_Usuario_id NUMBER (5) NOT NULL ,
    Deuda_id_Deuda   NUMBER (10) NOT NULL
  ) ;
ALTER TABLE AuditoriaTransaccion ADD CONSTRAINT AuditoriaTransaccion_PK PRIMARY KEY ( fecha, operacion, Deuda_Cuenta_id, id_transaccion, Deuda_Usuario_id, Deuda_id_Deuda ) ;


CREATE TABLE AuditoriaUbicacion
  (
    fecha          DATE NOT NULL ,
    operacion      CHAR (1 CHAR) NOT NULL ,
    id_usuario     NUMBER (5) NOT NULL ,
    fechaUbicacion DATE NOT NULL ,
    valorNuevo     VARCHAR2 (50 CHAR) NOT NULL ,
    valorAntiguo   VARCHAR2 (50 CHAR) NOT NULL ,
    columna        VARCHAR2 (50 CHAR)
  ) ;
ALTER TABLE AuditoriaUbicacion ADD CONSTRAINT AuditoriaUbicacion_PK PRIMARY KEY ( fecha, operacion, valorNuevo, valorAntiguo, id_usuario, fechaUbicacion ) ;


CREATE TABLE AuditoriaUsuario
  (
    fecha         DATE NOT NULL ,
    operacion     CHAR (1 CHAR) NOT NULL ,
    valorNuevo    VARCHAR2 (50 CHAR) NOT NULL ,
    valorAnterior VARCHAR2 (50 CHAR) NOT NULL ,
    id_usuario    NUMBER (5) NOT NULL ,
    columna       VARCHAR2 (50 CHAR)
  ) ;
ALTER TABLE AuditoriaUsuario ADD CONSTRAINT AuditoriaUsuario_PK PRIMARY KEY ( fecha, operacion, valorNuevo, valorAnterior, id_usuario ) ;

---------------------------------------------------------------------------
-- Tablas de diseno --
---------------------------------------------------------------------------
DROP TABLE Cuenta CASCADE CONSTRAINTS ;

DROP TABLE Deuda CASCADE CONSTRAINTS ;

DROP TABLE Es_aprobada CASCADE CONSTRAINTS ;

DROP TABLE Grupo CASCADE CONSTRAINTS ;

DROP TABLE LiderGrupo CASCADE CONSTRAINTS ;

DROP TABLE Pertenece_a CASCADE CONSTRAINTS ;

DROP TABLE Transaccion CASCADE CONSTRAINTS ;

DROP TABLE Ubicacion CASCADE CONSTRAINTS ;

DROP TABLE Usuario CASCADE CONSTRAINTS ;

DROP TABLE contacto_de CASCADE CONSTRAINTS ;

CREATE TABLE Cuenta
  (
    id     NUMBER (10) NOT NULL ,
    nombre VARCHAR2 (20 CHAR) NOT NULL ,
    costo  NUMBER (20) NOT NULL ,
    recibo BLOB ,
    fecha_creacion DATE NOT NULL ,
    Grupo_id       NUMBER (5) NOT NULL ,
    Usuario_id     NUMBER (5) NOT NULL ,
    comentarios varchar2(200)
  ) ;
ALTER TABLE Cuenta ADD CONSTRAINT Cuenta_PK PRIMARY KEY ( id ) ;


CREATE TABLE Deuda
  (
    cantidad   NUMBER (8) ,
    Usuario_id NUMBER (5) NOT NULL ,
    Cuenta_id  NUMBER (10) NOT NULL ,
    Id_Deuda   NUMBER (3) NOT NULL
  ) ;
ALTER TABLE Deuda ADD CONSTRAINT Deuda_PK PRIMARY KEY ( Cuenta_id, Usuario_id, Id_Deuda ) ;


CREATE TABLE Es_aprobada
  (
    Transaccion_id               NUMBER (5) NOT NULL ,
    Transaccion_Deuda_Cuenta_id  NUMBER (10) NOT NULL ,
    Transaccion_Deuda_Usuario_id NUMBER (5) NOT NULL ,
    Transaccion_Deuda_Id_Deuda   NUMBER (3) NOT NULL ,
    LiderGrupo_fechaIngreso      DATE NOT NULL ,
    LiderGrupo_Grupo_id          NUMBER (5) NOT NULL ,
    LiderGrupo_Usuario_id        NUMBER (5) NOT NULL ,
    fecha_aprobacion             DATE NOT NULL
  ) ;
CREATE INDEX Es_aprobada__IDX ON Es_aprobada
  (
    Transaccion_id ASC ,
    Transaccion_Deuda_Cuenta_id ASC ,
    Transaccion_Deuda_Usuario_id ASC ,
    Transaccion_Deuda_Id_Deuda ASC ,
    LiderGrupo_fechaIngreso ASC ,
    LiderGrupo_Grupo_id ASC ,
    LiderGrupo_Usuario_id ASC
  ) ;
ALTER TABLE Es_aprobada ADD CONSTRAINT Es_aprobada_PK PRIMARY KEY ( Transaccion_id, Transaccion_Deuda_Cuenta_id, Transaccion_Deuda_Usuario_id, Transaccion_Deuda_Id_Deuda, LiderGrupo_fechaIngreso, LiderGrupo_Grupo_id, LiderGrupo_Usuario_id ) ;


CREATE TABLE Grupo
  (
    id              NUMBER (5) NOT NULL ,
    nombre          VARCHAR2 (20 CHAR) NOT NULL ,
    UsuarioDueno_id NUMBER (5) NOT NULL ,
    Fecha_creacion  DATE NOT NULL ,
    disuelto        CHAR (1 CHAR) NOT NULL ,
    retenido        CHAR (1 CHAR) NOT NULL
  ) ;
ALTER TABLE Grupo ADD CONSTRAINT valor_Disuelto_Invalido CHECK ( disuelto IN ('N', 'S', 'Y')) ;
ALTER TABLE Grupo ADD CONSTRAINT valor_Retenido_Invalido CHECK ( retenido IN ('N', 'S', 'Y')) ;
ALTER TABLE Grupo ADD CONSTRAINT Grupo_PK PRIMARY KEY ( id ) ;


CREATE TABLE LiderGrupo
  (
    fechaIngreso DATE NOT NULL ,
    fechaSalida  DATE ,
    Grupo_id     NUMBER (5) NOT NULL ,
    Usuario_id   NUMBER (5) NOT NULL
  ) ;
ALTER TABLE LiderGrupo ADD CONSTRAINT LiderGrupo_PK PRIMARY KEY ( fechaIngreso, Grupo_id, Usuario_id ) ;


CREATE TABLE Pertenece_a
  (
    Usuario_id    NUMBER (5) NOT NULL ,
    Grupo_id      NUMBER (5) NOT NULL ,
    fecha_ingreso DATE NOT NULL ,
    fecha_salida  DATE
  ) ;
ALTER TABLE Pertenece_a ADD CONSTRAINT Pertenece_a_PK PRIMARY KEY ( Usuario_id, Grupo_id, fecha_ingreso ) ;


CREATE TABLE Transaccion
  (
    id               NUMBER (5) NOT NULL ,
    fecha            DATE NOT NULL ,
    cantidad         NUMBER (10) NOT NULL ,
    Deuda_Cuenta_id  NUMBER (10) NOT NULL ,
    Deuda_Usuario_id NUMBER (5) NOT NULL ,
    Deuda_Id_Deuda   NUMBER (3) NOT NULL ,
    Tipo             CHAR (1 CHAR) NOT NULL ,
    fecha_aprobacion DATE
  ) ;
ALTER TABLE Transaccion ADD CONSTRAINT Transaccion_PK PRIMARY KEY ( id, Deuda_Cuenta_id, Deuda_Usuario_id, Deuda_Id_Deuda ) ;


CREATE TABLE Ubicacion
  (
    fecha            DATE NOT NULL ,
    longitudGrados   NUMBER (3) NOT NULL ,
    longitudMinutos  NUMBER (2) NOT NULL ,
    longitudSegundos NUMBER (2) NOT NULL ,
    latitudGrados    NUMBER (3) NOT NULL ,
    latitudMinutos   NUMBER (2) NOT NULL ,
    latitudSegundos  NUMBER (2) NOT NULL ,
    Usuario_id       NUMBER (5) NOT NULL
  ) ;
ALTER TABLE Ubicacion ADD CONSTRAINT Ubicacion_PK PRIMARY KEY ( fecha, Usuario_id ) ;


CREATE TABLE Usuario
  (
    id               NUMBER (5) NOT NULL ,
    nombre           VARCHAR2 (50 CHAR) NOT NULL ,
    numeroTelefono   NUMBER (10) ,
    email            VARCHAR2 (50 CHAR) NOT NULL ,
    Paypal           VARCHAR2 (20) NOT NULL ,
    apellidos        VARCHAR2 (50 CHAR) NOT NULL ,
    fecha_nacimiento DATE DEFAULT '01/01/1900' NOT NULL ,
    genero           CHAR (1 CHAR) NOT NULL ,
    user_name        VARCHAR2 (20 CHAR) NOT NULL ,
    contrasena       VARCHAR2 (20 CHAR) NOT NULL ,
    "online"         CHAR (1 CHAR) DEFAULT 'N' NOT NULL
  ) ;
ALTER TABLE Usuario ADD CONSTRAINT Genero_Invalido CHECK ( genero  IN ('F', 'M')) ;
ALTER TABLE Usuario ADD CONSTRAINT valor_Online_invalido CHECK ( "online" IN ('N', 'S', 'Y')) ;
ALTER TABLE Usuario ADD CONSTRAINT Usuario_PK PRIMARY KEY ( id ) ;
ALTER TABLE Usuario ADD CONSTRAINT Usuario_user_name_UN UNIQUE ( user_name ) ;


CREATE TABLE contacto_de
  (
    Usuario_id  NUMBER (5) NOT NULL ,
    Usuario_id1 NUMBER (5) NOT NULL
  ) ;
ALTER TABLE contacto_de ADD CONSTRAINT contacto_de_PK PRIMARY KEY ( Usuario_id, Usuario_id1 ) ;


ALTER TABLE Cuenta ADD CONSTRAINT Cuenta_Grupo_FK FOREIGN KEY ( Grupo_id ) REFERENCES Grupo ( id ) ;

ALTER TABLE Cuenta ADD CONSTRAINT Cuenta_Usuario_FK FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE Deuda ADD CONSTRAINT Deuda_Cuenta_FK FOREIGN KEY ( Cuenta_id ) REFERENCES Cuenta ( id ) ;

ALTER TABLE Deuda ADD CONSTRAINT Deuda_Usuario_FK FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE Pertenece_a ADD CONSTRAINT FK_ASS_1 FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE Pertenece_a ADD CONSTRAINT FK_ASS_2 FOREIGN KEY ( Grupo_id ) REFERENCES Grupo ( id ) ;

ALTER TABLE Es_aprobada ADD CONSTRAINT FK_ASS_3 FOREIGN KEY ( Transaccion_id, Transaccion_Deuda_Cuenta_id, Transaccion_Deuda_Usuario_id, Transaccion_Deuda_Id_Deuda ) REFERENCES Transaccion ( id, Deuda_Cuenta_id, Deuda_Usuario_id, Deuda_Id_Deuda ) ;

ALTER TABLE Es_aprobada ADD CONSTRAINT FK_ASS_4 FOREIGN KEY ( LiderGrupo_fechaIngreso, LiderGrupo_Grupo_id, LiderGrupo_Usuario_id ) REFERENCES LiderGrupo ( fechaIngreso, Grupo_id, Usuario_id ) ;

ALTER TABLE contacto_de ADD CONSTRAINT FK_ASS_5 FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE contacto_de ADD CONSTRAINT FK_ASS_6 FOREIGN KEY ( Usuario_id1 ) REFERENCES Usuario ( id ) ;

ALTER TABLE Grupo ADD CONSTRAINT Grupo_Usuario_FK FOREIGN KEY ( UsuarioDueno_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE LiderGrupo ADD CONSTRAINT LiderGrupo_Grupo_FK FOREIGN KEY ( Grupo_id ) REFERENCES Grupo ( id ) ;

ALTER TABLE LiderGrupo ADD CONSTRAINT LiderGrupo_Usuario_FK FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

ALTER TABLE Transaccion ADD CONSTRAINT Transaccion_Deuda_FK FOREIGN KEY ( Deuda_Cuenta_id, Deuda_Usuario_id, Deuda_Id_Deuda ) REFERENCES Deuda ( Cuenta_id, Usuario_id, Id_Deuda ) ;

ALTER TABLE Ubicacion ADD CONSTRAINT Ubicacion_Usuario_FK FOREIGN KEY ( Usuario_id ) REFERENCES Usuario ( id ) ;

DROP SEQUENCE CU_id_SEQ;
DROP SEQUENCE GR_id_SEQ;
DROP SEQUENCE TR_id_SEQ;
DROP SEQUENCE US_id_SEQ;

CREATE SEQUENCE CU_id_SEQ START WITH 1 MAXVALUE 9999999999 NOCACHE ORDER ;
CREATE SEQUENCE GR_id_SEQ START WITH 1 MAXVALUE 99999 NOCACHE ORDER ;
CREATE SEQUENCE TR_id_SEQ START WITH 1 MAXVALUE 99999 NOCACHE ORDER ;
CREATE SEQUENCE US_id_SEQ START WITH 1 MAXVALUE 99999 NOCACHE ORDER ;

-------------------------------------------------------------------------------------
--Insercion de datos a las tablas--
-------------------------------------------------------------------------------------

INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'andres',5645646,'asdasd@email.com','asddasddssd','contreras', TO_DATE('21-08-1986','DD-MM-YY'),'M','andres111','468946431');
commit;
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'felipe',6456487,'felipe@email.com','12121ww','ramirez',TO_DATE('22-08-1981','DD-MM-YY'),'M','felipe4564','12468qd');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'carlos',11122235,'carlos@email.com','11aa1d12s1','rodrigez',TO_DATE('15-01-1984','DD-MM-YY'),'M','carlos12q','87rer87r');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'pedro',78115775,'pedro@email.com','a121a1001a1','morales',TO_DATE('22-08-1985','DD-MM-YY'),'M','pedro154e','124qqasd');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'pablo',6456487,'pablo@email.com','ppppaaab','ariza',TO_DATE('11-05-1989','DD-MM-YY'),'M','pabloar','87121pgfh');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'alejandro',5489712,'alejandro@email.com','78dsafd','castro',TO_DATE('22-07-1983','DD-MM-YY'),'M','ajenjadro45d','121err');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'santiago',712347,'santiago@email.com','445sdggf','salamanca',TO_DATE('12-08-1983','DD-MM-YY'),'M','santiago12','78dsf41');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'julio',425215410,'julio@email.com','54fd12fg','torres',TO_DATE('12-12-1989','DD-MM-YY'),'M','juliot12','45we1sdf');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'juan',456473,'juan@email.com','421dff12','casta�eda',TO_DATE('12-09-1986','DD-MM-YY'),'M','juan4112','18112');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'santiago',425215410,'sanchuster@email.com','54fd12fg','chuster',TO_DATE('22-12-1986','DD-MM-YY'),'M','chuster12','41213fgh');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'maria',1586478,'maria@email.com','sdfsdfc4','lozano',TO_DATE('14-07-1987','DD-MM-YY'),'F','maria486d','13456dfd');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'juana',784523264,'juana@email.com','f1564sdf1d','perez',TO_DATE('12-12-1982','DD-MM-YY'),'F','juana4564','1214541sdf');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'tulia',4252154,'tulia@email.com','45d4f5fs','jimenez',TO_DATE('12-12-1982','DD-MM-YY'),'F','tulia154','011010101');
INSERT INTO usuario(id,nombre,numeroTelefono,email,Paypal,apellidos,fecha_nacimiento,genero,user_name,contrasena) values(US_id_SEQ.NEXTVAL,'lucia',425215410,'lucia@email.com','5454sdf','torres',TO_DATE('12-12-1987','DD-MM-YY'),'F','lucia81d','31101101');
commit;

INSERT INTO UBICACION values(TO_DATE('24-08-1986','DD-MM-YY'), 124,24,35,12,34,12,1);
INSERT INTO UBICACION values(TO_DATE('26-08-1986','DD-MM-YY'), 124,24,35,12,34,12,1);
INSERT INTO UBICACION values(TO_DATE('30-08-1986','DD-MM-YY'), 124,24,35,12,34,12,1);
INSERT INTO UBICACION values(TO_DATE('1-09-1986','DD-MM-YY'), 124,24,35,12,34,12,1);
INSERT INTO UBICACION values(TO_DATE('10-09-1986','DD-MM-YY'), 124,24,35,12,34,12,1);
INSERT INTO UBICACION values(TO_DATE('14-10-1986','DD-MM-YY'), 124,24,35,12,34,12,1);
INSERT INTO UBICACION values(TO_DATE('17-11-1986','DD-MM-YY'), 124,24,35,12,34,12,1);
INSERT INTO UBICACION values(TO_DATE('21-12-1986','DD-MM-YY'), 124,24,35,12,34,12,1);

INSERT INTO UBICACION values(TO_DATE('22-08-1986','DD-MM-YY'), 125,24,35,12,34,12,2);
INSERT INTO UBICACION values(TO_DATE('25-08-1986','DD-MM-YY'), 130,24,35,12,34,12,2);
INSERT INTO UBICACION values(TO_DATE('30-08-1986','DD-MM-YY'), 124,30,35,12,34,12,2);
INSERT INTO UBICACION values(TO_DATE('01-10-1986','DD-MM-YY'), 124,24,35,12,34,12,2);
INSERT INTO UBICACION values(TO_DATE('30-12-1986','DD-MM-YY'), 124,24,35,12,34,21,2);
INSERT INTO UBICACION values(TO_DATE('01-01-1987','DD-MM-YY'), 124,26,35,11,34,41,2);

INSERT INTO UBICACION values(TO_DATE('15-02-1986','DD-MM-YY'), 101,24,35,123,34,12,3);
INSERT INTO UBICACION values(TO_DATE('16-02-1986','DD-MM-YY'), 101,24,35,123,34,12,3);
INSERT INTO UBICACION values(TO_DATE('21-02-1986','DD-MM-YY'), 101,15,35,123,34,12,3);
INSERT INTO UBICACION values(TO_DATE('30-03-1986','DD-MM-YY'), 101,24,35,123,34,12,3);
INSERT INTO UBICACION values(TO_DATE('02-10-1986','DD-MM-YY'), 101,23,35,123,34,12,3);
INSERT INTO UBICACION values(TO_DATE('10-11-1986','DD-MM-YY'), 101,24,35,123,34,12,3);
INSERT INTO UBICACION values(TO_DATE('01-12-1986','DD-MM-YY'), 101,23,35,13,34,12,3);
INSERT INTO UBICACION values(TO_DATE('21-12-1986','DD-MM-YY'), 101,24,35,123,34,12,3);

INSERT INTO UBICACION values(TO_DATE('22-08-1985','DD-MM-YY'), 124,24,35,12,34,12,4);
INSERT INTO UBICACION values(TO_DATE('30-08-1986','DD-MM-YY'), 124,24,35,12,34,12,4);
INSERT INTO UBICACION values(TO_DATE('01-09-1986','DD-MM-YY'), 124,24,35,12,34,12,4);

INSERT INTO UBICACION values(TO_DATE('11-05-1989','DD-MM-YY'), 124,24,35,12,34,12,5);
INSERT INTO UBICACION values(TO_DATE('21-08-1990','DD-MM-YY'), 124,24,35,12,34,12,5);

INSERT INTO UBICACION values(TO_DATE('22-07-1983','DD-MM-YY'), 124,24,35,12,34,12,6);
INSERT INTO UBICACION values(TO_DATE('30-08-1986','DD-MM-YY'), 124,24,35,12,34,12,6);
INSERT INTO UBICACION values(TO_DATE('01-08-1987','DD-MM-YY'), 124,24,35,12,34,12,6);

INSERT INTO UBICACION values(TO_DATE('21-08-1990','DD-MM-YY'), 124,24,35,12,34,12,7);
INSERT INTO UBICACION values(TO_DATE('11-08-1991','DD-MM-YY'), 124,24,35,12,34,12,7);

INSERT INTO UBICACION values(TO_DATE('12-08-1990','DD-MM-YY'), 124,24,35,12,34,12,8);
INSERT INTO UBICACION values(TO_DATE('21-09-1990','DD-MM-YY'), 124,24,35,12,34,12,8);
INSERT INTO UBICACION values(TO_DATE('23-10-1990','DD-MM-YY'), 124,24,35,12,34,12,8);

INSERT INTO UBICACION values(TO_DATE('21-08-1990','DD-MM-YY'), 124,24,35,12,34,12,9);
INSERT INTO UBICACION values(TO_DATE('21-08-1991','DD-MM-YY'), 124,24,35,12,34,12,9);

INSERT INTO UBICACION values(TO_DATE('21-08-1990','DD-MM-YY'), 124,24,35,12,34,12,10);
INSERT INTO UBICACION values(TO_DATE('10-08-1992','DD-MM-YY'), 124,24,35,12,34,12,10);
INSERT INTO UBICACION values(TO_DATE('11-08-1992','DD-MM-YY'), 124,24,35,12,34,12,10);

INSERT INTO UBICACION values(TO_DATE('12-08-1990','DD-MM-YY'), 124,24,35,12,34,12,11);
INSERT INTO UBICACION values(TO_DATE('01-09-1990','DD-MM-YY'), 124,24,35,12,34,12,11);

INSERT INTO UBICACION values(TO_DATE('12-08-1990','DD-MM-YY'), 124,24,35,12,34,12,12);
INSERT INTO UBICACION values(TO_DATE('30-09-1990','DD-MM-YY'), 124,24,35,12,34,12,12);

INSERT INTO UBICACION values(TO_DATE('19-08-1990','DD-MM-YY'), 124,24,35,12,34,12,13);
INSERT INTO UBICACION values(TO_DATE('21-09-1990','DD-MM-YY'), 124,24,35,12,34,12,13);

INSERT INTO UBICACION values(TO_DATE('21-08-1990','DD-MM-YY'), 124,24,35,12,34,12,14);
INSERT INTO UBICACION values(TO_DATE('12-08-1992','DD-MM-YY'), 124,24,35,12,34,12,14);
commit;

INSERT INTO CONTACTO_DE values (1,2);
INSERT INTO CONTACTO_DE values (1,3);
INSERT INTO CONTACTO_DE values (1,4);
INSERT INTO CONTACTO_DE values (1,5);
INSERT INTO CONTACTO_DE values (1,6);
INSERT INTO CONTACTO_DE values (1,7);
INSERT INTO CONTACTO_DE values (1,8);
INSERT INTO CONTACTO_DE values (1,9);
INSERT INTO CONTACTO_DE values (1,10);
INSERT INTO CONTACTO_DE values (1,11);
INSERT INTO CONTACTO_DE values (2,1);
INSERT INTO CONTACTO_DE values (2,3);
INSERT INTO CONTACTO_DE values (2,4);
INSERT INTO CONTACTO_DE values (2,6);
INSERT INTO CONTACTO_DE values (2,7);
INSERT INTO CONTACTO_DE values (2,8);
INSERT INTO CONTACTO_DE values (2,9);
INSERT INTO CONTACTO_DE values (2,11);
INSERT INTO CONTACTO_DE values (3,2);
INSERT INTO CONTACTO_DE values (3,5);
INSERT INTO CONTACTO_DE values (3,6);
INSERT INTO CONTACTO_DE values (3,7);
INSERT INTO CONTACTO_DE values (3,9);
INSERT INTO CONTACTO_DE values (3,10);
INSERT INTO CONTACTO_DE values (4,1);
INSERT INTO CONTACTO_DE values (4,2);
INSERT INTO CONTACTO_DE values (4,3);
INSERT INTO CONTACTO_DE values (4,5);
INSERT INTO CONTACTO_DE values (4,8);
INSERT INTO CONTACTO_DE values (4,9);
INSERT INTO CONTACTO_DE values (4,10);
INSERT INTO CONTACTO_DE values (4,11);
INSERT INTO CONTACTO_DE values (5,6);
INSERT INTO CONTACTO_DE values (5,7);
INSERT INTO CONTACTO_DE values (5,8);
INSERT INTO CONTACTO_DE values (5,10);
INSERT INTO CONTACTO_DE values (5,11);
INSERT INTO CONTACTO_DE values (6,2);
INSERT INTO CONTACTO_DE values (6,3);
INSERT INTO CONTACTO_DE values (6,4);
INSERT INTO CONTACTO_DE values (6,7);
INSERT INTO CONTACTO_DE values (6,8);
INSERT INTO CONTACTO_DE values (6,9);
INSERT INTO CONTACTO_DE values (6,10);
INSERT INTO CONTACTO_DE values (6,11);
INSERT INTO CONTACTO_DE values (7,2);
INSERT INTO CONTACTO_DE values (7,3);
INSERT INTO CONTACTO_DE values (7,4);
INSERT INTO CONTACTO_DE values (7,8);
INSERT INTO CONTACTO_DE values (7,9);
INSERT INTO CONTACTO_DE values (7,10);
INSERT INTO CONTACTO_DE values (7,11);
INSERT INTO CONTACTO_DE values (8,2);
INSERT INTO CONTACTO_DE values (9,1);
INSERT INTO CONTACTO_DE values (9,10);
INSERT INTO CONTACTO_DE values (9,11);
INSERT INTO CONTACTO_DE values (10,1);
INSERT INTO CONTACTO_DE values (10,2);
INSERT INTO CONTACTO_DE values (10,3);
INSERT INTO CONTACTO_DE values (10,4);
INSERT INTO CONTACTO_DE values (10,5);
INSERT INTO CONTACTO_DE values (10,6);
INSERT INTO CONTACTO_DE values (10,7);
INSERT INTO CONTACTO_DE values (10,8);
INSERT INTO CONTACTO_DE values (10,9);
INSERT INTO CONTACTO_DE values (10,11);
INSERT INTO CONTACTO_DE values (11,2);
INSERT INTO CONTACTO_DE values (11,3);
INSERT INTO CONTACTO_DE values (11,4);
INSERT INTO CONTACTO_DE values (11,5);
INSERT INTO CONTACTO_DE values (11,7);
INSERT INTO CONTACTO_DE values (11,8);
INSERT INTO CONTACTO_DE values (11,9);
INSERT INTO CONTACTO_DE values (11,10);
commit;

INSERT INTO grupo values(GR_id_SEQ.NEXTVAL,'grupo_1',1,TO_DATE('21-08-2016','DD-MM-YY'),'N','N');
commit;
INSERT INTO grupo values(GR_id_SEQ.NEXTVAL,'grupo_2',2,TO_DATE('14-02-2016','DD-MM-YY'),'N','N');
INSERT INTO grupo values(GR_id_SEQ.NEXTVAL,'grupo_3',3,TO_DATE('29-09-2016','DD-MM-YY'),'N','N');
INSERT INTO grupo values(GR_id_SEQ.NEXTVAL,'grupo_4',1,TO_DATE('05-01-2016','DD-MM-YY'),'N','N');
INSERT INTO grupo values(GR_id_SEQ.NEXTVAL,'grupo_5',1,TO_DATE('20-08-2016','DD-MM-YY'),'N','N');
commit;

INSERT INTO LIDERGRUPO values(TO_DATE('21-08-2016','DD-MM-YY'),null,1,1);
INSERT INTO LIDERGRUPO values(TO_DATE('14-02-2016','DD-MM-YY'),null,2,2);
INSERT INTO LIDERGRUPO values(TO_DATE('21-08-2016','DD-MM-YY'),null,3,3);
INSERT INTO LIDERGRUPO values(TO_DATE('29-09-2016','DD-MM-YY'),null,4,1);
INSERT INTO LIDERGRUPO values(TO_DATE('21-08-2016','DD-MM-YY'),null,5,1);
commit;

INSERT INTO pertenece_a values(1,1,TO_DATE('22-07-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(1,2,TO_DATE('12-07-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(1,3,TO_DATE('05-07-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(2,1,TO_DATE('14-07-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(2,2,TO_DATE('11-05-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(2,3,TO_DATE('24-12-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(3,1,TO_DATE('31-07-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(3,2,TO_DATE('02-08-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(3,3,TO_DATE('29-09-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(4,5,TO_DATE('23-10-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(4,2,TO_DATE('18-02-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(4,4,TO_DATE('02-03-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(5,5,TO_DATE('28-05-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(6,1,TO_DATE('14-07-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(7,1,TO_DATE('22-12-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(8,5,TO_DATE('14-02-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(9,4,TO_DATE('20-11-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(10,4,TO_DATE('09-03-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(11,3,TO_DATE('16-10-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(12,4,TO_DATE('22-09-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(13,4,TO_DATE('22-06-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(8,1,TO_DATE('22-06-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(4,3,TO_DATE('22-06-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(7,3,TO_DATE('22-06-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(5,4,TO_DATE('22-06-2016','DD-MM-YY'),null);
INSERT INTO pertenece_a values(6,4,TO_DATE('22-06-2016','DD-MM-YY'),null);
commit;

INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'almuerzo',300000,null,TO_DATE('22-07-2016','DD-MM-YY'),1,1);
commit;
INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'spotify',800000,null,TO_DATE('03-07-2016','DD-MM-YY'),1,2);
INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'televisor',450000,null,TO_DATE('22-07-2016','DD-MM-YY'),1,8);
INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'utiles',600000,null,TO_DATE('22-07-2016','DD-MM-YY'),1,3);

INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'salida',500000,null,TO_DATE('13-05-2016','DD-MM-YY'),2,3);
INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'transporte',300000,null,TO_DATE('18-07-2016','DD-MM-YY'),2,1);

INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'paseo',900000,null,TO_DATE('22-02-2016','DD-MM-YY'),3,4);
INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'donacion',100000,null,TO_DATE('22-08-2016','DD-MM-YY'),3,7);

INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'reunion',100000,null,TO_DATE('22-10-2016','DD-MM-YY'),4,5);
INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'deuda',250000,null,sysdate,4,6);

INSERT INTO cuenta(id,nombre,costo,recibo,FECHA_CREACION,GRUPO_ID,USUARIO_ID) values(CU_id_SEQ.NEXTVAL,'evento',600000,null,sysdate,5,5);
commit;

INSERT INTO Deuda values(60000,2,1,1);
INSERT INTO Deuda values(60000,3,1,2);
INSERT INTO Deuda values(60000,6,1,3);
INSERT INTO Deuda values(60000,7,1,4);
INSERT INTO Deuda values(60000,8,1,5);

INSERT INTO Deuda values(90000,1,9,6);
INSERT INTO Deuda values(90000,3,9,7);
INSERT INTO Deuda values(90000,6,9,8);
INSERT INTO Deuda values(90000,7,9,9);
INSERT INTO Deuda values(90000,2,9,10);

INSERT INTO Deuda values(120000,1,10,11);
INSERT INTO Deuda values(120000,2,10,12);
INSERT INTO Deuda values(120000,6,10,13);
INSERT INTO Deuda values(120000,7,10,14);
INSERT INTO Deuda values(120000,8,10,15);

INSERT INTO Deuda values(160000,1,2,16);
INSERT INTO Deuda values(160000,3,2,17);
INSERT INTO Deuda values(160000,6,2,18);
INSERT INTO Deuda values(160000,7,2,19);
INSERT INTO Deuda values(160000,8,2,20);

INSERT INTO Deuda values(166667,1,3,21);
INSERT INTO Deuda values(166667,2,3,22);
INSERT INTO Deuda values(166667,4,3,23);

INSERT INTO Deuda values(100000,2,8,24);
INSERT INTO Deuda values(100000,3,8,25);
INSERT INTO Deuda values(100000,4,8,26);

INSERT INTO Deuda values(180000,1,4,27);
INSERT INTO Deuda values(180000,2,4,28);
INSERT INTO Deuda values(180000,3,4,29);
INSERT INTO Deuda values(180000,11,4,30);
INSERT INTO Deuda values(180000,7,4,31);

INSERT INTO Deuda values(20000,1,7,32);
INSERT INTO Deuda values(20000,2,7,33);
INSERT INTO Deuda values(20000,3,7,34);
INSERT INTO Deuda values(20000,4,7,35);
INSERT INTO Deuda values(20000,11,7,36);

INSERT INTO Deuda values(16667,4,5,37);
INSERT INTO Deuda values(16667,6,5,38);
INSERT INTO Deuda values(16667,9,5,39);
INSERT INTO Deuda values(16667,10,5,40);
INSERT INTO Deuda values(16667,12,5,41);
INSERT INTO Deuda values(16667,13,5,42);

INSERT INTO Deuda values(41667,4,6,43);
INSERT INTO Deuda values(41667,5,6,44);
INSERT INTO Deuda values(41667,9,6,45);
INSERT INTO Deuda values(41667,10,6,46);
INSERT INTO Deuda values(41667,12,6,47);
INSERT INTO Deuda values(41667,13,6,48);

INSERT INTO Deuda values(300000,4,11,49);
INSERT INTO Deuda values(300000,8,11,50);
commit;

INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('23-07-2015','DD-MM-YY'),20000,1,2,1,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('24-07-2015','DD-MM-YY'),2000,1,2,1,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('25-07-2015','DD-MM-YY'),10000,1,2,1,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('12-09-2015','DD-MM-YY'),5000,1,3,2,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('12-09-2015','DD-MM-YY'),1000,1,3,2,'O');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('12-09-2015','DD-MM-YY'),3000,1,3,2,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('07-07-2015','DD-MM-YY'),10000,9,1,6,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('07-07-2015','DD-MM-YY'),30000,9,1,6,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('08-10-2015','DD-MM-YY'),22000,9,3,7,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('08-10-2015','DD-MM-YY'),12000,9,3,7,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('08-10-2015','DD-MM-YY'),4000,9,3,7,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('24-05-2015','DD-MM-YY'),35000,10,1,11,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('24-05-2015','DD-MM-YY'),12000,10,1,11,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('22-02-2015','DD-MM-YY'),15000,10,2,12,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('22-02-2015','DD-MM-YY'),15000,10,2,12,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('28-03-2015','DD-MM-YY'),50000,2,7,19,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('28-03-2015','DD-MM-YY'),10000,2,7,19,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('28-03-2015','DD-MM-YY'),5000,2,7,19,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('10-08-2015','DD-MM-YY'),50000,2,8,20,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('10-08-2015','DD-MM-YY'),10000,2,8,20,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('20-07-2015','DD-MM-YY'),35000,3,2,22,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('24-08-2015','DD-MM-YY'),42000,3,4,23,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('01-10-2015','DD-MM-YY'),50000,8,3,25,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('01-10-2015','DD-MM-YY'),5000,8,3,25,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('02-07-2015','DD-MM-YY'),30000,8,4,26,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('03-10-2015','DD-MM-YY'),20000,4,3,29,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('03-10-2015','DD-MM-YY'),12000,4,3,29,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('04-05-2015','DD-MM-YY'),65000,4,11,30,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('11-05-2015','DD-MM-YY'),46000,4,7,31,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('11-05-2015','DD-MM-YY'),8000,4,7,31,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('18-07-2015','DD-MM-YY'),3000,7,3,34,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('25-11-2015','DD-MM-YY'),8000,7,4,35,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('23-07-2015','DD-MM-YY'),3000,5,9,39,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('23-07-2015','DD-MM-YY'),1000,5,9,39,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('19-10-2015','DD-MM-YY'),5000,5,10,40,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('19-05-2015','DD-MM-YY'),9000,5,12,41,'P');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('27-05-2015','DD-MM-YY'),13000,6,5,44,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('27-05-2015','DD-MM-YY'),2000,6,5,44,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('03-07-2015','DD-MM-YY'),18000,6,10,46,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('09-02-2015','DD-MM-YY'),22000,6,13,48,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('05-07-2015','DD-MM-YY'),115000,11,4,49,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('05-07-2015','DD-MM-YY'),8000,11,4,49,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('04-07-2015','DD-MM-YY'),98000,11,8,50,'C');
INSERT INTO transaccion(id,FECHA,CANTIDAD,DEUDA_CUENTA_ID,DEUDA_USUARIO_ID,DEUDA_ID_DEUDA,TIPO) values(TR_id_SEQ.NEXTVAL,TO_DATE('04-07-2015','DD-MM-YY'),5000,11,8,50,'O');

commit;