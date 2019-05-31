/*
PADR?O DE PROJETO
Foi adotado como padr?o de projeto a inclus?o de constraints a n?vel de tabela

TIPOS DE CONSTRAINTS
- PK (Primary Key)
- FK (Foreign Key)
- UQ (Unique)
- CK (Check)

NOMENCLATURA DE CONSTRAINTS
- Se for uma constraint de uma coluna da pr?pria tabela
    (tipo)_(nome da coluna)    
    EX: pk_cat_codigo (primary key da tabela categoria)
        uq_usu_login  (unique da tabela usuario) 

- Se for uma constraint de uma coluna estrangeira
    (tipo)_(trigrama da tabela atual)_(nome da coluna)
    EX: fk_alu_usu_codigo (foreign key da tabela aluno que referencia a tabela usuario)
        fk_ins_usu_codigo (foreign key da tabela instrutor que referencia a tabela usuario)
    
EXECU??O DO SCRIPT
Ao rodar o script pela segunda vez, descomentar as linhas que excluem as constraints e as tabelas

CREATE TABLESPACE  PROJETO_BD_FATEC
DATAFILE  'D:\BD\PROJETO_BD_FATEC.dbf' SIZE 1M 
AUTOEXTEND ON;

CREATE USER PROEJETO
IDENTIFIED BY aluno
DEFAULT TABLESPACE PROJETO_BD_FATEC
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON PROJETO_BD_FATEC;

GRANT DBA TO PROEJETO WITH ADMIN OPTION;
*/

DROP TABLE categoria CASCADE CONSTRAINTS;
DROP TABLE aluno CASCADE CONSTRAINTS;
DROP TABLE instrutorcurso CASCADE CONSTRAINTS;
DROP TABLE instrutor CASCADE CONSTRAINTS;
DROP TABLE anexo CASCADE CONSTRAINTS;
DROP TABLE aula CASCADE CONSTRAINTS;
DROP TABLE modulo CASCADE CONSTRAINTS;
DROP TABLE curso CASCADE CONSTRAINTS;
DROP TABLE itemcompra CASCADE CONSTRAINTS;
DROP TABLE parcelas CASCADE CONSTRAINTS;
DROP TABLE compra CASCADE CONSTRAINTS;
DROP TABLE usuario CASCADE CONSTRAINTS;

CREATE TABLE usuario(
    usu_codigo NUMBER(5),
    usu_login VARCHAR2(30) NOT NULL,
    usu_email VARCHAR2(50) NOT NULL,
    usu_senha VARCHAR2(32) NOT NULL,
    usu_nome VARCHAR2(50) NOT NULL,
    usu_foto VARCHAR2(255),
    usu_status CHAR(1) NOT NULL,
    
    CONSTRAINT pk_usu_codigo PRIMARY KEY(usu_codigo),
    CONSTRAINT ck_usu_status CHECK(usu_status in('A','I')),
    CONSTRAINT uq_usu_login UNIQUE(usu_login),
    CONSTRAINT uq_usu_email UNIQUE(usu_email)    
);

CREATE TABLE instrutor(
    usu_codigo NUMBER(5),
    ins_documento VARCHAR2(30) NOT NULL,    
    
    CONSTRAINT pk_ins_usu_codigo PRIMARY KEY(usu_codigo),
    CONSTRAINT fk_ins_usu_codigo FOREIGN KEY(usu_codigo) REFERENCES usuario(usu_codigo),    
    CONSTRAINT uq_ins_documento UNIQUE(ins_documento)
);

CREATE TABLE aluno(
    usu_codigo NUMBER(5),
    alu_matricula VARCHAR2(30) NOT NULL,
    
    CONSTRAINT pk_alu_usu_codigo PRIMARY KEY(usu_codigo),
    CONSTRAINT fk_alu_usu_codigo FOREIGN KEY(usu_codigo) REFERENCES usuario(usu_codigo),
    CONSTRAINT uq_alu_matricula UNIQUE(alu_matricula)
);

CREATE TABLE categoria(
    cat_codigo NUMBER(5),
    cat_nome VARCHAR2(50) NOT NULL,
    cat_descricao VARCHAR2(255),
    cat_status CHAR(1) NOT NULL,
    
    CONSTRAINT pk_cat_codigo PRIMARY KEY(cat_codigo),
    CONSTRAINT ck_cat_status CHECK(cat_status in('A','I'))
);

CREATE TABLE curso(
    cur_codigo NUMBER(5),
    cat_codigo NUMBER(5),
    cur_titulo VARCHAR2(50) NOT NULL,
    cur_descricao VARCHAR2(255) NOT NULL,
    cur_duracao VARCHAR2(10) NOT NULL,
    cur_preco NUMBER(10,2) NOT NULL,
    cur_thumbnail VARCHAR2(255) NOT NULL,
    cur_avaliacao NUMBER(1),
    cur_status CHAR(1),
    
    CONSTRAINT pk_cur_codigo PRIMARY KEY(cur_codigo),
    CONSTRAINT fk_cur_cat_codigo FOREIGN KEY(cat_codigo) REFERENCES categoria(cat_codigo),
    CONSTRAINT ck_cur_status CHECK(cur_status in('A','I'))    
);

CREATE TABLE instrutorcurso(
    usu_codigo NUMBER(5),
    cur_codigo NUMBER(5),
    
    CONSTRAINT pk_inc_codigo PRIMARY KEY(usu_codigo, cur_codigo),
    CONSTRAINT fk_inc_cur_codigo FOREIGN KEY(cur_codigo) REFERENCES curso(cur_codigo),
    CONSTRAINT fk_inc_uso_codigo FOREIGN KEY(usu_codigo) REFERENCES usuario(usu_codigo)
);

CREATE TABLE modulo(
    mod_codigo NUMBER(5),
    cur_codigo NUMBER(5),
    mod_titulo VARCHAR2(50) NOT NULL,
    mod_descricao VARCHAR2(255) NOT NULL,
    mod_duracao VARCHAR2(10) NOT NULL,
    mod_thumbnail VARCHAR2(255) NOT NULL,
    mod_status CHAR(1) NOT NULL,
    
    CONSTRAINT pk_mod_codigo PRIMARY KEY(mod_codigo),
    CONSTRAINT fk_mod_cur_codigo FOREIGN KEY(cur_codigo) REFERENCES curso(cur_codigo),
    CONSTRAINT ck_mod_status CHECK(mod_status in('A','I'))
);

CREATE TABLE aula(
    aul_codigo NUMBER(5),
    mod_codigo NUMBER(5),
    aul_titulo VARCHAR2(50) NOT NULL,
    aul_descricao VARCHAR2(255) NOT NULL,
    aul_conteudo LONG NOT NULL,
    aul_video VARCHAR2(255),
    aul_status CHAR(1) NOT NULL,
    
    CONSTRAINT pk_aul_codigo PRIMARY KEY(aul_codigo),
    CONSTRAINT fk_aul_mod_codigo FOREIGN KEY(mod_codigo) REFERENCES modulo(mod_codigo),
    CONSTRAINT ck_aul_status CHECK(aul_status in('A','I'))
);

CREATE TABLE anexo(
    ane_codigo NUMBER(5),
    aul_codigo NUMBER(5),
    ane_titulo VARCHAR2(50) NOT NULL,
    ane_comentario VARCHAR2(255),
    ane_link VARCHAR2(255) NOT NULL,
    ane_status CHAR(1) NOT NULL,
    
    CONSTRAINT pk_ane_codigo PRIMARY KEY(ane_codigo),
    CONSTRAINT fk_ane_aul_codigo FOREIGN KEY(aul_codigo) REFERENCES aula(aul_codigo),
    CONSTRAINT ck_ane_status CHECK(ane_status in('A','I'))
);

CREATE TABLE compra(
    com_codigo NUMBER(5),
    usu_codigo NUMBER(5),
    com_data DATE NOT NULL,
    com_formapgto VARCHAR2(30),
    com_parcelas NUMBER(2),
    com_status CHAR(2) NOT NULL,
    
    CONSTRAINT pk_com_codigo PRIMARY KEY(com_codigo),
    CONSTRAINT fk_com_usu_codigo FOREIGN KEY(usu_codigo) REFERENCES aluno(usu_codigo),
    CONSTRAINT ck_com_status CHECK(com_status in('AG','PG')),
    CONSTRAINT ck_com_formapgto CHECK(com_formapgto in('CREDITO','DEBITO','BOLETO','TRANSFERENCIA')),
    CONSTRAINT ck_com_nparcelas CHECK(com_parcelas <= 12));

CREATE TABLE itemcompra(    
    cur_codigo NUMBER(5),
    com_codigo NUMBER(5),
    itc_avaliacao NUMBER(1),
    itc_valor NUMBER(10,2),
    
    CONSTRAINT pk_itc_codigo PRIMARY KEY(cur_codigo, com_codigo),
    CONSTRAINT fk_itc_cur_codigo FOREIGN KEY(cur_codigo) REFERENCES curso(cur_codigo),
    CONSTRAINT fk_itc_com_codigo FOREIGN KEY(com_codigo) REFERENCES compra(com_codigo)  
);   

CREATE TABLE parcelas(
    par_codigo NUMBER(5),
    com_codigo NUMBER(5),
    par_valor NUMBER(10,2) NOT NULL,
    par_data DATE NOT NULL,
    par_status CHAR(2) NOT NULL,
    
    CONSTRAINT pk_par_codigo PRIMARY KEY(par_codigo, com_codigo),/*Coloquei parcelas com chave composta*/
    CONSTRAINT fk_par_com_codigo FOREIGN KEY(com_codigo) REFERENCES compra(com_codigo),
    CONSTRAINT ck_par_status CHECK(par_status in('AG','PG'))
);

