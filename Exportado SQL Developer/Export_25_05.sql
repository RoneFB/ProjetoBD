--------------------------------------------------------
--  Arquivo criado - Sábado-Maio-25-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence USU_ID_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "USU_ID_SEQ"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE
--------------------------------------------------------
--  DDL for Table ALUNO
--------------------------------------------------------

  CREATE TABLE "ALUNO" ("USU_CODIGO" NUMBER(5,0), "ALU_MATRICULA" VARCHAR2(30)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table ANEXO
--------------------------------------------------------

  CREATE TABLE "ANEXO" ("ANE_CODIGO" NUMBER(5,0), "AUL_CODIGO" NUMBER(5,0), "ANE_TITULO" VARCHAR2(50), "ANE_COMENTARIO" VARCHAR2(255), "ANE_LINK" VARCHAR2(255), "ANE_STATUS" CHAR(1)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table AULA
--------------------------------------------------------

  CREATE TABLE "AULA" ("AUL_CODIGO" NUMBER(5,0), "MOD_CODIGO" NUMBER(5,0), "AUL_TITULO" VARCHAR2(50), "AUL_DESCRICAO" VARCHAR2(255), "AUL_CONTEUDO" LONG, "AUL_VIDEO" VARCHAR2(255), "AUL_STATUS" CHAR(1)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table CATEGORIA
--------------------------------------------------------

  CREATE TABLE "CATEGORIA" ("CAT_CODIGO" NUMBER(5,0), "CAT_NOME" VARCHAR2(50), "CAT_DESCRICAO" VARCHAR2(255), "CAT_STATUS" CHAR(1)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table COMPRA
--------------------------------------------------------

  CREATE TABLE "COMPRA" ("COM_CODIGO" NUMBER(5,0), "USU_CODIGO" NUMBER(5,0), "COM_DATA" DATE, "COM_SUBTOTAL" NUMBER(10,2), "COM_DESCONTO" NUMBER(10,2), "COM_TOTAL" NUMBER(10,2), "COM_FORMAPGTO" VARCHAR2(30), "COM_PARCELAS" NUMBER(2,0), "COM_STATUS" CHAR(2)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table CURSO
--------------------------------------------------------

  CREATE TABLE "CURSO" ("CUR_CODIGO" NUMBER(5,0), "CAT_CODIGO" NUMBER(5,0), "CUR_TITULO" VARCHAR2(50), "CUR_DESCRICAO" VARCHAR2(255), "CUR_DURACAO" VARCHAR2(10), "CUR_PRECO" NUMBER(10,2), "CUR_THUMBNAIL" VARCHAR2(255), "CUR_AVALIACAO" NUMBER(1,0), "CUR_STATUS" CHAR(1)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table INSTRUTOR
--------------------------------------------------------

  CREATE TABLE "INSTRUTOR" ("USU_CODIGO" NUMBER(5,0), "INS_DOCUMENTO" VARCHAR2(30)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table INSTRUTORCURSO
--------------------------------------------------------

  CREATE TABLE "INSTRUTORCURSO" ("USU_CODIGO" NUMBER(5,0), "CUR_CODIGO" NUMBER(5,0)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table ITEMCOMPRA
--------------------------------------------------------

  CREATE TABLE "ITEMCOMPRA" ("CUR_CODIGO" NUMBER(5,0), "COM_CODIGO" NUMBER(5,0), "ITC_AVALIACAO" NUMBER(1,0), "ITC_VALOR" NUMBER(10,2)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table MODULO
--------------------------------------------------------

  CREATE TABLE "MODULO" ("MOD_CODIGO" NUMBER(5,0), "CUR_CODIGO" NUMBER(5,0), "MOD_TITULO" VARCHAR2(50), "MOD_DESCRICAO" VARCHAR2(255), "MOD_DURACAO" VARCHAR2(10), "MOD_THUMBNAIL" VARCHAR2(255), "MOD_STATUS" CHAR(1)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table PARCELAS
--------------------------------------------------------

  CREATE TABLE "PARCELAS" ("PAR_CODIGO" NUMBER(5,0), "COM_CODIGO" NUMBER(5,0), "PAR_VALOR" NUMBER(10,2), "PAR_STATUS" CHAR(2)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
--------------------------------------------------------
--  DDL for Table USUARIO
--------------------------------------------------------

  CREATE TABLE "USUARIO" ("USU_CODIGO" NUMBER(5,0), "USU_LOGIN" VARCHAR2(30), "USU_EMAIL" VARCHAR2(50), "USU_SENHA" VARCHAR2(32), "USU_NOME" VARCHAR2(50), "USU_FOTO" VARCHAR2(255), "USU_STATUS" CHAR(1)) SEGMENT CREATION IMMEDIATE PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645 PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT) TABLESPACE "PROJETO_BD_FATEC"
REM INSERTING into ALUNO
SET DEFINE OFF;
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('1','67510-0633');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('2','0699-1081');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('3','66382-223');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('4','55154-6775');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('5','21695-851');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('6','45014-139');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('7','17478-101');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('8','49999-878');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('9','43353-771');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('10','67684-1901');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('11','68788-9782');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('12','60760-059');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('13','58668-4221');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('14','53808-0356');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('15','35356-593');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('16','57664-167');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('17','65862-556');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('18','49035-851');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('19','49349-478');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('20','42787-102');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('21','0085-1322');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('22','54868-5023');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('23','66949-252');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('24','52125-933');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('25','54868-4532');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('26','51389-112');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('27','0067-6716');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('28','35418-136');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('29','59316-205');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('30','47335-046');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('31','10812-146');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('32','42507-431');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('33','52125-018');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('34','75874-701');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('35','51138-076');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('36','68258-3029');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('37','49035-928');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('38','10631-113');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('39','49738-101');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('40','41190-281');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('41','59972-0106');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('42','65044-3041');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('43','37205-321');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('44','63739-448');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('45','17312-019');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('46','48951-5007');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('47','55154-6664');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('48','59779-590');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('49','63777-204');
Insert into ALUNO (USU_CODIGO,ALU_MATRICULA) values ('50','49999-797');
REM INSERTING into ANEXO
SET DEFINE OFF;
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('1','1','Apostila 1','Bacteremia','/vel/ipsum/praesent/blandit/lacinia/erat.html','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('2','2','Apostila 1','Gambling and betting','/risus/auctor.aspx','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('3','3','Apostila 1','Exfl d/t eryth 80-89 bdy','/cras/non/velit/nec/nisi.js','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('4','4','Apostila 1','Taeniasis NOS','/eget/orci/vehicula/condimentum/curabitur/in/libero.aspx','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('5','5','Apostila 1','Tubal ligation status','/nisl/aenean/lectus/pellentesque/eget/nunc.aspx','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('6','6','Apostila 1','Ob trauma NEC-del w p/p','/sit/amet/eleifend/pede/libero/quis/orci.png','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('7','7','Apostila 1','Cicatricial entropion','/maecenas/ut/massa/quis/augue.jpg','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('8','8','Apostila 1','Food pois: v. parahaem','/a/libero/nam/dui/proin/leo.json','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('9','9','Apostila 1','Venomous bite/sting NOS','/ipsum/ac.png','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('10','10','Apostila 1','Submers NEC-crew','/vestibulum/proin/eu/mi/nulla/ac/enim.aspx','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('11','11','Apostila 1','Ascending colon inj-open','/quisque.js','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('13','2','Apostila 2','Inf mcrg rstn sulfnmides','/consequat/dui.xml','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('14','5','Apostila 2','Ca in situ fem gen NEC','/in/magna/bibendum/imperdiet.js','A');
Insert into ANEXO (ANE_CODIGO,AUL_CODIGO,ANE_TITULO,ANE_COMENTARIO,ANE_LINK,ANE_STATUS) values ('15','13','Apostila 1','Cl skull fx NEC-brf coma','/eu.html','A');
REM INSERTING into AULA
SET DEFINE OFF;
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('1','1','Apresentação a Linguagem Java','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('2','2','Tipos de Variaveis','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('3','2','Constantes','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('4','2','Public, Private e Protect','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('5','3','Abstract','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('6','3','Enum','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('7','3','Interface','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('8','4','Construtores','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('9','4','Getters e Setters','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('10','4','Abstratos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('11','5','Herança','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('12','5','Upccasting e Downcasting','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
Insert into AULA (AUL_CODIGO,MOD_CODIGO,AUL_TITULO,AUL_DESCRICAO,AUL_CONTEUDO,AUL_VIDEO,AUL_STATUS) values ('13','5','Soreposição, anotação, super','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt','A');
REM INSERTING into CATEGORIA
SET DEFINE OFF;
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('1','Back-End','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('2','Front-End','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('3','Design Gráfico','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('4','Modelagem 3D','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('5','Mobile','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('6','Bussiness','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('7','Cloud','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('8','Banco de Dados','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('9','Programação Orentada a Objeto','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('10','Inteligencia Artificial','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('11','Block Chain','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('12','Big Data','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('13','Machine Learning','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('14','Linux','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
Insert into CATEGORIA (CAT_CODIGO,CAT_NOME,CAT_DESCRICAO,CAT_STATUS) values ('15','SEO','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
REM INSERTING into COMPRA
SET DEFINE OFF;
Insert into COMPRA (COM_CODIGO,USU_CODIGO,COM_DATA,COM_SUBTOTAL,COM_DESCONTO,COM_TOTAL,COM_FORMAPGTO,COM_PARCELAS,COM_STATUS) values ('1','1',to_date('25/05/19','DD/MM/RR'),'280','0','0','Crédito','1','AG');
Insert into COMPRA (COM_CODIGO,USU_CODIGO,COM_DATA,COM_SUBTOTAL,COM_DESCONTO,COM_TOTAL,COM_FORMAPGTO,COM_PARCELAS,COM_STATUS) values ('2','2',to_date('11/04/19','DD/MM/RR'),'220','0','0','Débito','1','AG');
Insert into COMPRA (COM_CODIGO,USU_CODIGO,COM_DATA,COM_SUBTOTAL,COM_DESCONTO,COM_TOTAL,COM_FORMAPGTO,COM_PARCELAS,COM_STATUS) values ('3','3',to_date('08/03/19','DD/MM/RR'),'200','0','0','Boleto','1','AG');
Insert into COMPRA (COM_CODIGO,USU_CODIGO,COM_DATA,COM_SUBTOTAL,COM_DESCONTO,COM_TOTAL,COM_FORMAPGTO,COM_PARCELAS,COM_STATUS) values ('4','4',to_date('01/03/19','DD/MM/RR'),'290','0','0','Débito','1','AG');
Insert into COMPRA (COM_CODIGO,USU_CODIGO,COM_DATA,COM_SUBTOTAL,COM_DESCONTO,COM_TOTAL,COM_FORMAPGTO,COM_PARCELAS,COM_STATUS) values ('5','5',to_date('02/02/19','DD/MM/RR'),'440','0','0','Crédito','2','AG');
REM INSERTING into CURSO
SET DEFINE OFF;
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('1','1','Curso de Java','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','40 Horas','150','http://lorempixel.com/400/200/sports/1/Dummy-Text/','4','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('2','1','PHP PDO','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','33 Horas','130','http://lorempixel.com/400/200/sports/1/Dummy-Text/','5','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('3','3','UX Design','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','31 Horas','90','http://lorempixel.com/400/200/sports/1/Dummy-Text/','4','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('4','8','Oracle','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','10 Horas','70','http://lorempixel.com/400/200/sports/1/Dummy-Text/','5','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('5','7','Bussiness Analytics c Power BI','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','20 Horas','200','http://lorempixel.com/400/200/sports/1/Dummy-Text/','3','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('6','5','APLICAÇÕES COM REACT E REDUX','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','15 Horas','139','http://lorempixel.com/400/200/sports/1/Dummy-Text/','5','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('7','7','Virtualização com AWS','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','50 Horas','259','http://lorempixel.com/400/200/sports/1/Dummy-Text/','4','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('8','2','HTML, CSS e JavaScript','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','40 Horas','160','http://lorempixel.com/400/200/sports/1/Dummy-Text/','2','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('9','1','Programação com Python','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','35 Horas','55','http://lorempixel.com/400/200/sports/1/Dummy-Text/','4','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('10','1','Curso de Java','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','60 Horas','49,9','http://lorempixel.com/400/200/sports/1/Dummy-Text/','5','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('11','8','Arqt e Modelagem de Dados','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','40 Horas','35','http://lorempixel.com/400/200/sports/1/Dummy-Text/','3','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('12','4','Fundamentos de Densenvolvimento Games','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','30 Horas','100','http://lorempixel.com/400/200/sports/1/Dummy-Text/','5','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('13','14','Comandos Básicos Linux','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5 Horas','120','http://lorempixel.com/400/200/sports/1/Dummy-Text/','4','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('14','15','Otimização de Código HTML','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','12 Horas','279','http://lorempixel.com/400/200/sports/1/Dummy-Text/','5','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('15','7','Amazon em AWS','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','100 Horas','140','http://lorempixel.com/400/200/sports/1/Dummy-Text/','3','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('16','5','Programação Android','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','65 Horas','345','http://lorempixel.com/400/200/sports/1/Dummy-Text/','1','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('17','8','Programação SQL','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','40 Horas','155','http://lorempixel.com/400/200/sports/1/Dummy-Text/','3','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('18','10','R, Python e Weka','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','32 Horas','239','http://lorempixel.com/400/200/sports/1/Dummy-Text/','5','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('19','15','Google Adwards','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','70 Horas','510','http://lorempixel.com/400/200/sports/1/Dummy-Text/','4','A');
Insert into CURSO (CUR_CODIGO,CAT_CODIGO,CUR_TITULO,CUR_DESCRICAO,CUR_DURACAO,CUR_PRECO,CUR_THUMBNAIL,CUR_AVALIACAO,CUR_STATUS) values ('20','2','Javascript e JQuery','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','50 Horas','220','http://lorempixel.com/400/200/sports/1/Dummy-Text/','3','A');
REM INSERTING into INSTRUTOR
SET DEFINE OFF;
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('51','55312-020');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('52','44237-016');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('53','55154-9391');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('54','0069-3120');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('55','52125-226');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('56','42043-142');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('57','59726-025');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('58','37000-845');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('59','36987-3139');
Insert into INSTRUTOR (USU_CODIGO,INS_DOCUMENTO) values ('60','63148-215');
REM INSERTING into INSTRUTORCURSO
SET DEFINE OFF;
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('51','1');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('51','13');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('51','15');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('52','2');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('52','5');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('52','6');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('53','2');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('53','3');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('54','4');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('54','19');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('55','5');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('55','18');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('56','6');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('56','12');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('56','20');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('57','7');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('57','11');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('57','17');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('58','8');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('58','10');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('58','16');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('59','8');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('59','9');
Insert into INSTRUTORCURSO (USU_CODIGO,CUR_CODIGO) values ('60','14');
REM INSERTING into ITEMCOMPRA
SET DEFINE OFF;
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('1','1','4','150');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('2','1','4','130');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('2','2','4','130');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('3','2','4','90');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('5','3','5','200');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('5','4','5','200');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('3','4','5','90');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('1','5','5','150');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('2','5','3','130');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('3','5','4','90');
Insert into ITEMCOMPRA (CUR_CODIGO,COM_CODIGO,ITC_AVALIACAO,ITC_VALOR) values ('4','5','5','70');
REM INSERTING into MODULO
SET DEFINE OFF;
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('1','1','Conceitos Orientada a Objetos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('2','1','Tipos Primitivos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('3','1','Classe','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('4','1','Métodos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('5','1','Herança','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('6','1','Polimorfismo','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','2h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('7','1','Encapsulamento','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','4h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('8','2','Introdução a PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('9','2','Declarações','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('10','2','Funções','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('11','2','Get e Post, Session','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('12','2','PHP e Mysql','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('13','3','Introdução a UX','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('14','3','Métodos e Ferramentas','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('15','3','Estratégia de Produto','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('16','3','Planejamento','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('17','3','Validação e Pesquisa','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('18','3','Desenho de interfaces','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','2h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('19','3','Experiencia do usuário','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','4h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('20','4','Introdução Oracle SQL','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('21','4','Comandos SQL Basico','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('22','4','Restringindo e ordenando dados','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('23','4','Funções básicos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('24','4','Multiplas Tables','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('25','4','Funções de Grupo','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','2h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('26','4','Sub-consultas','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','4h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('27','5','O que voce precisa saber sobre BI','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('28','5','Construindo o cenário','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('29','5','Instanlando ferramentas de Business Intelligence','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('30','5','Montando o Ambiente OLTP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('31','5','Cirando Área de Stage','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('32','5','Carregando o Datawarehouse','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','2h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
Insert into MODULO (MOD_CODIGO,CUR_CODIGO,MOD_TITULO,MOD_DESCRICAO,MOD_DURACAO,MOD_THUMBNAIL,MOD_STATUS) values ('33','5','Bi Self no Excel','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','4h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
REM INSERTING into PARCELAS
SET DEFINE OFF;
Insert into PARCELAS (PAR_CODIGO,COM_CODIGO,PAR_VALOR,PAR_STATUS) values ('1','1','280','AG');
Insert into PARCELAS (PAR_CODIGO,COM_CODIGO,PAR_VALOR,PAR_STATUS) values ('1','2','220','AG');
Insert into PARCELAS (PAR_CODIGO,COM_CODIGO,PAR_VALOR,PAR_STATUS) values ('1','3','200','AG');
Insert into PARCELAS (PAR_CODIGO,COM_CODIGO,PAR_VALOR,PAR_STATUS) values ('1','4','290','AG');
Insert into PARCELAS (PAR_CODIGO,COM_CODIGO,PAR_VALOR,PAR_STATUS) values ('1','5','220','AG');
Insert into PARCELAS (PAR_CODIGO,COM_CODIGO,PAR_VALOR,PAR_STATUS) values ('2','5','220','AG');
REM INSERTING into USUARIO
SET DEFINE OFF;
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('1','Lars','lduly0@nhs.uk','IW2FE0fhanib','Lars Duly','http://dummyimage.com/117x175.bmp/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('2','Killy','kkinlock1@cnet.com','7DuM8gRz6wQ','Killy Kinlock','http://dummyimage.com/216x158.jpg/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('3','Katti','kbrigman2@artisteer.com','BSFyp2zrBlhl','Katti Brigman','http://dummyimage.com/247x157.png/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('4','Etta','ebuddles3@scribd.com','bMQb3IPYYtk','Etta Buddles','http://dummyimage.com/144x196.png/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('5','Rudolf','rtesimon4@loc.gov','gwDG1zp9Gk','Rudolf Tesimon','http://dummyimage.com/224x133.png/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('6','Ferguson','fandri5@facebook.com','2zXWzoFit','Ferguson Andri','http://dummyimage.com/230x153.jpg/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('7','Cullan','cabrehart6@theglobeandmail.com','UDMsSpm7v','Cullan Abrehart','http://dummyimage.com/196x194.jpg/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('8','Corri','chedgecock7@home.pl','UM8SeyGD2u8','Corri Hedgecock','http://dummyimage.com/239x126.bmp/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('9','Cherye','csanbrook8@tiny.cc','LwjDY4Q','Cherye Sanbrook','http://dummyimage.com/130x115.jpg/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('10','Hendrika','hwittrington9@columbia.edu','ib7aBlb1uO2','Hendrika Wittrington','http://dummyimage.com/160x242.bmp/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('11','Carey','cdea@example.com','rR9wPTzJ','Carey De Luna','http://dummyimage.com/183x231.jpg/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('12','Bonni','bkitherb@jugem.jp','cVZhOWM','Bonni Kither','http://dummyimage.com/128x224.bmp/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('13','Laureen','lcettellc@geocities.com','J7KfLIKhq','Laureen Cettell','http://dummyimage.com/206x179.png/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('14','Delia','dmelanaphyd@netscape.com','hNzUa8lvb','Delia Melanaphy','http://dummyimage.com/200x217.bmp/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('15','Mozes','mwildene@ihg.com','8GlnEqdnD','Mozes Wilden','http://dummyimage.com/100x209.bmp/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('16','Rheta','rrosenf@psu.edu','5Io1oTTQ','Rheta Rosen','http://dummyimage.com/157x160.png/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('17','Lucia','lpavolinig@technorati.com','W8bmQxNVuh','Lucia Pavolini','http://dummyimage.com/247x147.bmp/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('18','Nat','ngumbyh@psu.edu','HQzvnUde4x','Nat Gumby','http://dummyimage.com/141x159.bmp/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('19','Ferdie','fbuntingi@imdb.com','8ggv7yHco92','Ferdie Bunting','http://dummyimage.com/101x111.png/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('20','Margaretha','mstrongmanj@nhs.uk','WIast7mHtj','Margaretha Strongman','http://dummyimage.com/174x228.png/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('21','Udall','udukelowk@ehow.com','yqQSarwJ1J','Udall Dukelow','http://dummyimage.com/239x135.bmp/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('22','Denny','drastalll@gov.uk','hl1PsX7i17k','Denny Rastall','http://dummyimage.com/178x227.jpg/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('23','Genna','gpresnailm@marketwatch.com','mdWAeE','Genna Presnail','http://dummyimage.com/234x181.png/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('24','Margarethe','mwyken@shinystat.com','YBSjts3Grcya','Margarethe Wyke','http://dummyimage.com/172x141.bmp/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('25','Arlyne','ameaseo@zimbio.com','66nAeMwa8j','Arlyne Mease','http://dummyimage.com/104x120.png/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('26','Alta','asimoensp@princeton.edu','7TlrmL7','Alta Simoens','http://dummyimage.com/199x183.jpg/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('27','Shelley','skringeq@phoca.cz','VJcsAX6','Shelley Kringe','http://dummyimage.com/218x167.jpg/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('28','Ronnie','rruder@clickbank.net','7q5q76','Ronnie Rude','http://dummyimage.com/244x140.jpg/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('29','Trista','thazlewoods@seesaa.net','s6PaCd39hkrs','Trista Hazlewood','http://dummyimage.com/136x198.png/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('30','Saudra','sknellent@cbslocal.com','GsRkMHj','Saudra Knellen','http://dummyimage.com/127x203.bmp/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('31','Guillemette','gbotfieldu@theguardian.com','oKygV9','Guillemette Botfield','http://dummyimage.com/206x211.png/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('32','Conny','cberendsv@fda.gov','evZzlp5c','Conny Berends','http://dummyimage.com/178x197.jpg/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('33','Alysia','asaunderw@ezinearticles.com','CjPwUnVXZRAH','Alysia Saunder','http://dummyimage.com/219x239.bmp/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('34','Hephzibah','harnouldx@bbb.org','fyBLzcHNOp','Hephzibah Arnould','http://dummyimage.com/183x220.jpg/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('35','Rhys','ryersony@webs.com','u4MwB9','Rhys Yerson','http://dummyimage.com/223x194.jpg/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('36','Karlan','klamplughz@techcrunch.com','dULinbBG','Karlan Lamplugh','http://dummyimage.com/171x112.jpg/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('37','Xymenes','xatwell10@cafepress.com','wyTGXlc2','Xymenes Atwell','http://dummyimage.com/179x199.png/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('38','Poul','pbabcock11@simplemachines.org','Kka57D55Zl16','Poul Babcock','http://dummyimage.com/203x138.png/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('39','Chadd','cbitchener12@shareasale.com','KpivmH','Chadd Bitchener','http://dummyimage.com/186x207.png/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('40','Rudolfo','redelmann13@digg.com','7bXrUV5uoG','Rudolfo Edelmann','http://dummyimage.com/179x214.jpg/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('41','Joycelin','jjanecki14@bloglines.com','ohfGM1snfi','Joycelin Janecki','http://dummyimage.com/128x220.jpg/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('42','Carleton','ckinahan15@engadget.com','nNamgjf5Xmc','Carleton Kinahan','http://dummyimage.com/232x146.jpg/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('43','Selig','sriddock16@tamu.edu','yjt3Y3uM','Selig Riddock','http://dummyimage.com/146x147.bmp/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('44','Yelena','ysommerfeld17@blogger.com','IzHQecl','Yelena Sommerfeld','http://dummyimage.com/124x236.bmp/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('45','Kerri','kgorst18@elpais.com','tOLwlZ','Kerri Gorst','http://dummyimage.com/210x159.jpg/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('46','Dorisa','dcampana19@amazon.co.uk','C8WYrVhBlV','Dorisa Campana','http://dummyimage.com/190x164.png/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('47','Karylin','kbiaggetti1a@4shared.com','iNblRjUUS','Karylin Biaggetti','http://dummyimage.com/248x240.png/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('48','Inessa','iraise1b@gmpg.org','EEDRD59','Inessa Raise','http://dummyimage.com/151x202.jpg/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('49','Paulo','pwitnall1c@statcounter.com','XHlmw90mfmg','Paulo Witnall','http://dummyimage.com/223x143.bmp/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('50','Kyrstin','ksills1d@tripadvisor.com','ScQwlUgat9','Kyrstin Sills','http://dummyimage.com/221x197.bmp/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('51','Rone','rone@nhs.uk','IW2FE0fhanib','Rone Felipe','http://dummyimage.com/117x175.bmp/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('52','Felipe','felipe@cnet.com','7DuM8gRz6wQ','Felipe Bento','http://dummyimage.com/216x158.jpg/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('53','Bento','bento@artisteer.com','BSFyp2zrBlhl','Bento Felipe','http://dummyimage.com/247x157.png/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('54','Othon','othon@scribd.com','bMQb3IPYYtk','Othon Rafael','http://dummyimage.com/144x196.png/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('55','Rafael','rafael@loc.gov','gwDG1zp9Gk','Rafael Ferreira','http://dummyimage.com/224x133.png/cc0000/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('56','Ferreira','ferreira@facebook.com','2zXWzoFit','Ferreira Godoy','http://dummyimage.com/230x153.jpg/5fa2dd/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('57','Godoy','godoy@theglobeandmail.com','UDMsSpm7v','Godoy Ferreira','http://dummyimage.com/196x194.jpg/ff4444/ffffff','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('58','Juliana','juju@home.pl','UM8SeyGD2u8','Juliana Fagundes','http://dummyimage.com/239x126.bmp/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('59','Francisco','francisco@tiny.cc','LwjDY4Q','Francisco Silva','http://dummyimage.com/130x115.jpg/dddddd/000000','A');
Insert into USUARIO (USU_CODIGO,USU_LOGIN,USU_EMAIL,USU_SENHA,USU_NOME,USU_FOTO,USU_STATUS) values ('60','Joaquina','joaquina@columbia.edu','ib7aBlb1uO2','Joaquina Silva','http://dummyimage.com/160x242.bmp/cc0000/ffffff','A');
