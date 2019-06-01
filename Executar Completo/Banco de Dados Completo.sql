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
    CONSTRAINT ck_com_status CHECK(com_status in('AG','PG','CN')),
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
    CONSTRAINT ck_par_status CHECK(par_status in('AG','PG','CN'))
);


/*INSERTS*/

/*Usuário*/
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (1, 'Lars', 'lduly0@nhs.uk', 'IW2FE0fhanib', 'Lars Duly', 'http://dummyimage.com/117x175.bmp/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (2, 'Killy', 'kkinlock1@cnet.com', '7DuM8gRz6wQ', 'Killy Kinlock', 'http://dummyimage.com/216x158.jpg/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (3, 'Katti', 'kbrigman2@artisteer.com', 'BSFyp2zrBlhl', 'Katti Brigman', 'http://dummyimage.com/247x157.png/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (4, 'Etta', 'ebuddles3@scribd.com', 'bMQb3IPYYtk', 'Etta Buddles', 'http://dummyimage.com/144x196.png/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (5, 'Rudolf', 'rtesimon4@loc.gov', 'gwDG1zp9Gk', 'Rudolf Tesimon', 'http://dummyimage.com/224x133.png/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (6, 'Ferguson', 'fandri5@facebook.com', '2zXWzoFit', 'Ferguson Andri', 'http://dummyimage.com/230x153.jpg/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (7, 'Cullan', 'cabrehart6@theglobeandmail.com', 'UDMsSpm7v', 'Cullan Abrehart', 'http://dummyimage.com/196x194.jpg/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (8, 'Corri', 'chedgecock7@home.pl', 'UM8SeyGD2u8', 'Corri Hedgecock', 'http://dummyimage.com/239x126.bmp/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (9, 'Cherye', 'csanbrook8@tiny.cc', 'LwjDY4Q', 'Cherye Sanbrook', 'http://dummyimage.com/130x115.jpg/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (10, 'Hendrika', 'hwittrington9@columbia.edu', 'ib7aBlb1uO2', 'Hendrika Wittrington', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (11, 'Carey', 'cdea@example.com', 'rR9wPTzJ', 'Carey De Luna', 'http://dummyimage.com/183x231.jpg/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (12, 'Bonni', 'bkitherb@jugem.jp', 'cVZhOWM', 'Bonni Kither', 'http://dummyimage.com/128x224.bmp/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (13, 'Laureen', 'lcettellc@geocities.com', 'J7KfLIKhq', 'Laureen Cettell', 'http://dummyimage.com/206x179.png/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (14, 'Delia', 'dmelanaphyd@netscape.com', 'hNzUa8lvb', 'Delia Melanaphy', 'http://dummyimage.com/200x217.bmp/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (15, 'Mozes', 'mwildene@ihg.com', '8GlnEqdnD', 'Mozes Wilden', 'http://dummyimage.com/100x209.bmp/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (16, 'Rheta', 'rrosenf@psu.edu', '5Io1oTTQ', 'Rheta Rosen', 'http://dummyimage.com/157x160.png/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (17, 'Lucia', 'lpavolinig@technorati.com', 'W8bmQxNVuh', 'Lucia Pavolini', 'http://dummyimage.com/247x147.bmp/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (18, 'Nat', 'ngumbyh@psu.edu', 'HQzvnUde4x', 'Nat Gumby', 'http://dummyimage.com/141x159.bmp/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (19, 'Ferdie', 'fbuntingi@imdb.com', '8ggv7yHco92', 'Ferdie Bunting', 'http://dummyimage.com/101x111.png/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (20, 'Margaretha', 'mstrongmanj@nhs.uk', 'WIast7mHtj', 'Margaretha Strongman', 'http://dummyimage.com/174x228.png/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (21, 'Udall', 'udukelowk@ehow.com', 'yqQSarwJ1J', 'Udall Dukelow', 'http://dummyimage.com/239x135.bmp/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (22, 'Denny', 'drastalll@gov.uk', 'hl1PsX7i17k', 'Denny Rastall', 'http://dummyimage.com/178x227.jpg/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (23, 'Genna', 'gpresnailm@marketwatch.com', 'mdWAeE', 'Genna Presnail', 'http://dummyimage.com/234x181.png/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (24, 'Margarethe', 'mwyken@shinystat.com', 'YBSjts3Grcya', 'Margarethe Wyke', 'http://dummyimage.com/172x141.bmp/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (25, 'Arlyne', 'ameaseo@zimbio.com', '66nAeMwa8j', 'Arlyne Mease', 'http://dummyimage.com/104x120.png/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (26, 'Alta', 'asimoensp@princeton.edu', '7TlrmL7', 'Alta Simoens', 'http://dummyimage.com/199x183.jpg/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (27, 'Shelley', 'skringeq@phoca.cz', 'VJcsAX6', 'Shelley Kringe', 'http://dummyimage.com/218x167.jpg/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (28, 'Ronnie', 'rruder@clickbank.net', '7q5q76', 'Ronnie Rude', 'http://dummyimage.com/244x140.jpg/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (29, 'Trista', 'thazlewoods@seesaa.net', 's6PaCd39hkrs', 'Trista Hazlewood', 'http://dummyimage.com/136x198.png/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (30, 'Saudra', 'sknellent@cbslocal.com', 'GsRkMHj', 'Saudra Knellen', 'http://dummyimage.com/127x203.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (31, 'Guillemette', 'gbotfieldu@theguardian.com', 'oKygV9', 'Guillemette Botfield', 'http://dummyimage.com/206x211.png/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (32, 'Conny', 'cberendsv@fda.gov', 'evZzlp5c', 'Conny Berends', 'http://dummyimage.com/178x197.jpg/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (33, 'Alysia', 'asaunderw@ezinearticles.com', 'CjPwUnVXZRAH', 'Alysia Saunder', 'http://dummyimage.com/219x239.bmp/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (34, 'Hephzibah', 'harnouldx@bbb.org', 'fyBLzcHNOp', 'Hephzibah Arnould', 'http://dummyimage.com/183x220.jpg/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (35, 'Rhys', 'ryersony@webs.com', 'u4MwB9', 'Rhys Yerson', 'http://dummyimage.com/223x194.jpg/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (36, 'Karlan', 'klamplughz@techcrunch.com', 'dULinbBG', 'Karlan Lamplugh', 'http://dummyimage.com/171x112.jpg/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (37, 'Xymenes', 'xatwell10@cafepress.com', 'wyTGXlc2', 'Xymenes Atwell', 'http://dummyimage.com/179x199.png/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (38, 'Poul', 'pbabcock11@simplemachines.org', 'Kka57D55Zl16', 'Poul Babcock', 'http://dummyimage.com/203x138.png/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (39, 'Chadd', 'cbitchener12@shareasale.com', 'KpivmH', 'Chadd Bitchener', 'http://dummyimage.com/186x207.png/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (40, 'Rudolfo', 'redelmann13@digg.com', '7bXrUV5uoG', 'Rudolfo Edelmann', 'http://dummyimage.com/179x214.jpg/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (41, 'Joycelin', 'jjanecki14@bloglines.com', 'ohfGM1snfi', 'Joycelin Janecki', 'http://dummyimage.com/128x220.jpg/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (42, 'Carleton', 'ckinahan15@engadget.com', 'nNamgjf5Xmc', 'Carleton Kinahan', 'http://dummyimage.com/232x146.jpg/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (43, 'Selig', 'sriddock16@tamu.edu', 'yjt3Y3uM', 'Selig Riddock', 'http://dummyimage.com/146x147.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (44, 'Yelena', 'ysommerfeld17@blogger.com', 'IzHQecl', 'Yelena Sommerfeld', 'http://dummyimage.com/124x236.bmp/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (45, 'Kerri', 'kgorst18@elpais.com', 'tOLwlZ', 'Kerri Gorst', 'http://dummyimage.com/210x159.jpg/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (46, 'Dorisa', 'dcampana19@amazon.co.uk', 'C8WYrVhBlV', 'Dorisa Campana', 'http://dummyimage.com/190x164.png/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (47, 'Karylin', 'kbiaggetti1a@4shared.com', 'iNblRjUUS', 'Karylin Biaggetti', 'http://dummyimage.com/248x240.png/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (48, 'Inessa', 'iraise1b@gmpg.org', 'EEDRD59', 'Inessa Raise', 'http://dummyimage.com/151x202.jpg/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (49, 'Paulo', 'pwitnall1c@statcounter.com', 'XHlmw90mfmg', 'Paulo Witnall', 'http://dummyimage.com/223x143.bmp/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (50, 'Kyrstin', 'ksills1d@tripadvisor.com', 'ScQwlUgat9', 'Kyrstin Sills', 'http://dummyimage.com/221x197.bmp/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (51, 'Rone', 'rone@nhs.uk', 'IW2FE0fhanib', 'Rone Felipe', 'http://dummyimage.com/117x175.bmp/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (52, 'Felipe', 'felipe@cnet.com', '7DuM8gRz6wQ', 'Felipe Bento', 'http://dummyimage.com/216x158.jpg/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (53, 'Bento', 'bento@artisteer.com', 'BSFyp2zrBlhl', 'Bento Felipe', 'http://dummyimage.com/247x157.png/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (54, 'Othon', 'othon@scribd.com', 'bMQb3IPYYtk', 'Othon Rafael', 'http://dummyimage.com/144x196.png/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (55, 'Rafael', 'rafael@loc.gov', 'gwDG1zp9Gk', 'Rafael Ferreira', 'http://dummyimage.com/224x133.png/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (56, 'Ferreira', 'ferreira@facebook.com', '2zXWzoFit', 'Ferreira Godoy', 'http://dummyimage.com/230x153.jpg/5fa2dd/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (57, 'Godoy', 'godoy@theglobeandmail.com', 'UDMsSpm7v', 'Godoy Ferreira', 'http://dummyimage.com/196x194.jpg/ff4444/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (58, 'Juliana', 'juju@home.pl', 'UM8SeyGD2u8', 'Juliana Fagundes', 'http://dummyimage.com/239x126.bmp/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (59, 'Francisco', 'francisco@tiny.cc', 'LwjDY4Q', 'Francisco Silva', 'http://dummyimage.com/130x115.jpg/dddddd/000000', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (60, 'Joaquina', 'joaquina@columbia.edu', 'ib7aBlb1uO2', 'Joaquina Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (61, 'José', 'jose@columbia.edu', 'ib7aBlb1uO2', 'José Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (62, 'Raimundo', 'raimundo@columbia.edu', 'ib7aBlb1uO2', 'Raimundo Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (63, 'Junio', 'Junio@columbia.edu', 'ib7aBlb1uO2', 'Junio Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (64, 'Henrique', 'henrique@columbia.edu', 'ib7aBlb1uO2', 'Henrique Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (65, 'Carolina', 'carolina@columbia.edu', 'ib7aBlb1uO2', 'Carolina Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (66, 'Fernando', 'fernando@columbia.edu', 'ib7aBlb1uO2', 'Fernando Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (67, 'Alex', 'Alex@columbia.edu', 'ib7aBlb1uO2', 'Alex Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (68, 'Antonio', 'antonio@columbia.edu', 'ib7aBlb1uO2', 'Antonio Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (69, 'Gustavo', 'gustavo@columbia.edu', 'ib7aBlb1uO2', 'Gustavo Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (70, 'Alfredo', 'alfredo@columbia.edu', 'ib7aBlb1uO2', 'Alfredo Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (71, 'Fulando de Tal', 'fulano@columbia.edu', 'ib7aBlb1uO2', 'Fulando Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (72, 'Vanessa', 'vanessa@columbia.edu', 'ib7aBlb1uO2', 'Vanessa Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (73, 'Cléber', 'cleber@columbia.edu', 'ib7aBlb1uO2', 'Cléber Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (74, 'James', 'james@columbia.edu', 'ib7aBlb1uO2', 'James Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (75, 'João', 'jooao@columbia.edu', 'ib7aBlb1uO2', 'João Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (76, 'Maria', 'maria@columbia.edu', 'ib7aBlb1uO2', 'Maria Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (77, 'Pedro', 'pedro@columbia.edu', 'ib7aBlb1uO2', 'Pedro Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (78, 'Tiago', 'tiago@columbia.edu', 'ib7aBlb1uO2', 'Tiago Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');
insert into usuario (usu_codigo, usu_login, usu_email, usu_senha, usu_nome, usu_foto, usu_status) values (79, 'Rita', 'rita@columbia.edu', 'ib7aBlb1uO2', 'Rita Silva', 'http://dummyimage.com/160x242.bmp/cc0000/ffffff', 'A');

/*Intrutor*/
insert into instrutor (usu_codigo, ins_documento) values (51, '45312-020');
insert into instrutor (usu_codigo, ins_documento) values (52, '54237-016');
insert into instrutor (usu_codigo, ins_documento) values (53, '65154-9391');
insert into instrutor (usu_codigo, ins_documento) values (54, '7069-3120');
insert into instrutor (usu_codigo, ins_documento) values (55, '82125-226');
insert into instrutor (usu_codigo, ins_documento) values (56, '92043-142');
insert into instrutor (usu_codigo, ins_documento) values (57, '59796-025');
insert into instrutor (usu_codigo, ins_documento) values (58, '37050-845');
insert into instrutor (usu_codigo, ins_documento) values (59, '35987-3139');
insert into instrutor (usu_codigo, ins_documento) values (60, '63548-215');
insert into instrutor (usu_codigo, ins_documento) values (61, '45512-020');
insert into instrutor (usu_codigo, ins_documento) values (62, '44237-016');
insert into instrutor (usu_codigo, ins_documento) values (63, '35454-9391');
insert into instrutor (usu_codigo, ins_documento) values (64, '2069-3120');
insert into instrutor (usu_codigo, ins_documento) values (65, '52125-226');
insert into instrutor (usu_codigo, ins_documento) values (66, '12043-142');
insert into instrutor (usu_codigo, ins_documento) values (67, '555776-025');
insert into instrutor (usu_codigo, ins_documento) values (68, '47700-8688');
insert into instrutor (usu_codigo, ins_documento) values (69, '36987-3669');
insert into instrutor (usu_codigo, ins_documento) values (70, '63148-555');
insert into instrutor (usu_codigo, ins_documento) values (71, '55312-324');
insert into instrutor (usu_codigo, ins_documento) values (72, '44787-016');
insert into instrutor (usu_codigo, ins_documento) values (73, '12154-9391');
insert into instrutor (usu_codigo, ins_documento) values (74, '8869-3120');
insert into instrutor (usu_codigo, ins_documento) values (75, '77125-226');
insert into instrutor (usu_codigo, ins_documento) values (76, '55043-142');
insert into instrutor (usu_codigo, ins_documento) values (77, '33726-025');
insert into instrutor (usu_codigo, ins_documento) values (78, '34000-845');
insert into instrutor (usu_codigo, ins_documento) values (79, '38000-845');
insert into instrutor (usu_codigo, ins_documento) values (48, '59779-590');
insert into instrutor (usu_codigo, ins_documento) values (49, '63777-204');
insert into instrutor (usu_codigo, ins_documento) values (50, '49999-797');

/*Aluno*/
insert into aluno (usu_codigo, alu_matricula) values (1, '67510-0633');
insert into aluno (usu_codigo, alu_matricula) values (2, '0699-1081');
insert into aluno (usu_codigo, alu_matricula) values (3, '66382-223');
insert into aluno (usu_codigo, alu_matricula) values (4, '55154-6775');
insert into aluno (usu_codigo, alu_matricula) values (5, '21695-851');
insert into aluno (usu_codigo, alu_matricula) values (6, '45014-139');
insert into aluno (usu_codigo, alu_matricula) values (7, '17478-101');
insert into aluno (usu_codigo, alu_matricula) values (8, '49999-878');
insert into aluno (usu_codigo, alu_matricula) values (9, '43353-771');
insert into aluno (usu_codigo, alu_matricula) values (10, '67684-1901');
insert into aluno (usu_codigo, alu_matricula) values (11, '68788-9782');
insert into aluno (usu_codigo, alu_matricula) values (12, '60760-059');
insert into aluno (usu_codigo, alu_matricula) values (13, '58668-4221');
insert into aluno (usu_codigo, alu_matricula) values (14, '53808-0356');
insert into aluno (usu_codigo, alu_matricula) values (15, '35356-593');
insert into aluno (usu_codigo, alu_matricula) values (16, '57664-167');
insert into aluno (usu_codigo, alu_matricula) values (17, '65862-556');
insert into aluno (usu_codigo, alu_matricula) values (18, '49035-851');
insert into aluno (usu_codigo, alu_matricula) values (19, '49349-478');
insert into aluno (usu_codigo, alu_matricula) values (20, '42787-102');
insert into aluno (usu_codigo, alu_matricula) values (21, '0085-1322');
insert into aluno (usu_codigo, alu_matricula) values (22, '54868-5023');
insert into aluno (usu_codigo, alu_matricula) values (23, '66949-252');
insert into aluno (usu_codigo, alu_matricula) values (24, '52125-933');
insert into aluno (usu_codigo, alu_matricula) values (25, '54868-4532');
insert into aluno (usu_codigo, alu_matricula) values (26, '51389-112');
insert into aluno (usu_codigo, alu_matricula) values (27, '0067-6716');
insert into aluno (usu_codigo, alu_matricula) values (28, '35418-136');
insert into aluno (usu_codigo, alu_matricula) values (29, '59316-205');
insert into aluno (usu_codigo, alu_matricula) values (30, '47335-046');
insert into aluno (usu_codigo, alu_matricula) values (31, '10812-146');
insert into aluno (usu_codigo, alu_matricula) values (32, '42507-431');
insert into aluno (usu_codigo, alu_matricula) values (33, '52125-018');
insert into aluno (usu_codigo, alu_matricula) values (34, '75874-701');
insert into aluno (usu_codigo, alu_matricula) values (35, '51138-076');
insert into aluno (usu_codigo, alu_matricula) values (36, '68258-3029');
insert into aluno (usu_codigo, alu_matricula) values (37, '49035-928');
insert into aluno (usu_codigo, alu_matricula) values (38, '10631-113');
insert into aluno (usu_codigo, alu_matricula) values (39, '49738-101');
insert into aluno (usu_codigo, alu_matricula) values (40, '41190-281');
insert into aluno (usu_codigo, alu_matricula) values (41, '59972-0106');
insert into aluno (usu_codigo, alu_matricula) values (42, '65044-3041');
insert into aluno (usu_codigo, alu_matricula) values (43, '37205-321');
insert into aluno (usu_codigo, alu_matricula) values (44, '63739-448');
insert into aluno (usu_codigo, alu_matricula) values (45, '17312-019');
insert into aluno (usu_codigo, alu_matricula) values (46, '48951-5007');
insert into aluno (usu_codigo, alu_matricula) values (47, '55154-6664');

/*Categoria*/
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (1,'Back-End','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (2,'Front-End','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (3,'Design Gráfico','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (4,'Modelagem 3D','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (5,'Mobile','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (6,'Bussiness','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (7,'Cloud','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (8,'Banco de Dados','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (9,'Programação Orentada a Objeto','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (10,'Inteligencia Artificial','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (11,'Block Chain','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (12,'Big Data','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (13,'Machine Learning','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (14,'Linux','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (15,'SEO','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (16,'React','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (17,'Autocad','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (18,'Office','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (19,'Catia V5','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (20,'Solid Works','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (21,'Power Bi','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (22,'Canvas','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (23,'Administração de Banco de Dados','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (24,'Web Service','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (25,'Etical Hacking','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (26,'Power Shell','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (27,'Ruby on Rails','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (28,'Bootstrap 4','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (29,'AngularJS','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');
insert into categoria(cat_codigo, cat_nome, cat_descricao, cat_status) values (30,'Node.js','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.','A');

/*Curso*/
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (1, 1, 'Curso de Java','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'40 Horas', 150.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (2, 1, 'PHP PDO','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'33 Horas', 130.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (3, 3, 'UX Design','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'31 Horas', 90.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (4, 8, 'Oracle','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'10 Horas', 70.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (5, 7, 'Bussiness Analytics c Power BI','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'20 Horas', 200.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',3, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (6, 5, 'APLICAÇÕES COM REACT E REDUX','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'15 Horas', 139.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (7, 7, 'Virtualização com AWS','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'50 Horas', 259.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (8, 2, 'HTML, CSS e JavaScript','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'40 Horas', 160.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',2, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (9, 1, 'Programação com Python','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'35 Horas', 55.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (10, 1, 'Curso de Java','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'60 Horas', 49.90, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (11, 8, 'Arqt e Modelagem de Dados','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'40 Horas', 35.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',3, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (12, 4, 'Fundamentos de Densenvolvimento Games','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'30 Horas', 100.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (13, 14, 'Comandos Básicos Linux','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'5 Horas', 120.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (14, 15, 'Otimização de Código HTML','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'12 Horas', 279.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (15, 7, 'Amazon em AWS','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'100 Horas', 140.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',3, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (16, 5, 'Programação Android','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'65 Horas', 345.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',1, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (17, 8, 'Programação SQL','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'40 Horas', 155.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',3, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (18, 10, 'R, Python e Weka','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'32 Horas', 239.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (19, 15, 'Google Adwards','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'70 Horas', 510.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (20, 2, 'Javascript e JQuery','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'50 Horas', 220.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',3, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (21, 19, 'Catia','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'40 Horas', 150.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (22, 20, 'Projetos com Solid Works','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'33 Horas', 130.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (23, 21, 'Power BI','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'31 Horas', 90.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (24, 23, 'Introdução DBA','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'10 Horas', 70.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (25, 24, 'REST Java','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'20 Horas', 200.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',3, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (26, 25, 'Kali Linux','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'15 Horas', 139.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (27, 26,'Comandos Básicos Power Shell','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'50 Horas', 259.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (28, 27, 'Ruby on Rails - Introdução','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'40 Horas', 160.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',2, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (29, 28, 'Site responsivo com bootstrap 4','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'35 Horas', 55.0, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',4, 'A');
insert into curso(cur_codigo, cat_codigo, cur_titulo, cur_descricao, cur_duracao, cur_preco, cur_thumbnail, cur_avaliacao, cur_status)
values (30, 29, 'Introdução Angular','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
'60 Horas', 49.90, 'http://lorempixel.com/400/200/sports/1/Dummy-Text/',5, 'A');

/*Instrutor*/
insert into instrutorcurso(usu_codigo, cur_codigo) values (51,1);
insert into instrutorcurso(usu_codigo, cur_codigo) values (52,2);
insert into instrutorcurso(usu_codigo, cur_codigo) values (53,3);
insert into instrutorcurso(usu_codigo, cur_codigo) values (54,4);
insert into instrutorcurso(usu_codigo, cur_codigo) values (55,5);
insert into instrutorcurso(usu_codigo, cur_codigo) values (56,6);
insert into instrutorcurso(usu_codigo, cur_codigo) values (57,7);
insert into instrutorcurso(usu_codigo, cur_codigo) values (58,8);
insert into instrutorcurso(usu_codigo, cur_codigo) values (59,9);
insert into instrutorcurso(usu_codigo, cur_codigo) values (58,10);
insert into instrutorcurso(usu_codigo, cur_codigo) values (57,11);
insert into instrutorcurso(usu_codigo, cur_codigo) values (56,12);
insert into instrutorcurso(usu_codigo, cur_codigo) values (51,13);
insert into instrutorcurso(usu_codigo, cur_codigo) values (53,2);
insert into instrutorcurso(usu_codigo, cur_codigo) values (52,5);
insert into instrutorcurso(usu_codigo, cur_codigo) values (52,6);
insert into instrutorcurso(usu_codigo, cur_codigo) values (59,8);
insert into instrutorcurso(usu_codigo, cur_codigo) values (58,16);
insert into instrutorcurso(usu_codigo, cur_codigo) values (54,19);
insert into instrutorcurso(usu_codigo, cur_codigo) values (55,18);
insert into instrutorcurso(usu_codigo, cur_codigo) values (60,14);
insert into instrutorcurso(usu_codigo, cur_codigo) values (51,15);
insert into instrutorcurso(usu_codigo, cur_codigo) values (57,17);
insert into instrutorcurso(usu_codigo, cur_codigo) values (56,20);

/*Modulo*/
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(1,1,'Conceitos Orientada a Objetos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(2,1,'Tipos Primitivos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(3,1,'Classe','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(4,1,'Métodos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(5,1,'Herança','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(6,1,'Polimorfismo','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','2h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(7,1,'Encapsulamento','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','4h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(8,2,'Introdução a PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(9,2,'Declarações','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(10,2,'Funções','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(11,2,'Get e Post, Session','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(12,2,'PHP e Mysql','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(13,3,'Introdução a UX','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(14,3,'Métodos e Ferramentas','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(15,3,'Estratégia de Produto','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(16,3,'Planejamento','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(17,3,'Validação e Pesquisa','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(18,3,'Desenho de interfaces','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','2h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(19,3,'Experiencia do usuário','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','4h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(20,4,'Introdução Oracle SQL','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(21,4,'Comandos SQL Basico','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(22,4,'Restringindo e ordenando dados','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(23,4,'Funções básicos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(24,4,'Multiplas Tables','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(25,4,'Funções de Grupo','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','2h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(26,4,'Sub-consultas','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','4h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(27,5,'O que voce precisa saber sobre BI','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(28,5,'Construindo o cenário','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(29,5,'Instanlando ferramentas de Business Intelligence','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','5h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(30,5,'Montando o Ambiente OLTP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','6h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(31,5,'Cirando Área de Stage','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','3h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(32,5,'Carregando o Datawarehouse','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','2h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');
insert into modulo(mod_codigo, cur_codigo, mod_titulo, mod_descricao, mod_duracao, mod_thumbnail, mod_status)
values(33,5,'Bi Self no Excel','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua','4h','http://lorempixel.com/400/200/sports/1/Dummy-Text/','A');


/*Aulas*/
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(1,1,'Apresentação a Linguagem Java','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(2,2,'Tipos de Variaveis','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(3,2,'Constantes','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(4,2,'Public, Private e Protect','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(5,3,'Abstract','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(6,3,'Enum','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(7,3,'Interface','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(8,4,'Construtores','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(9,4,'Getters e Setters','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(10,4,'Abstratos','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(11,5,'Herança','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(12,5,'Upccasting e Downcasting','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(13,5,'Soreposição, anotação, super','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');


insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(14,8,'Aula 1 Modulo 1 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(15,8,'Aula 2 Modulo 1 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(16,8,'Aula 3 Modulo 1 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(17,8,'Aula 4 Modulo 1 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(18,8,'Aula 5 Modulo 1 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');

insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(19,8,'Aula 1 Modulo 2 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');

insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(20,9,'Aula 2 Modulo 2 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(21,9,'Aula 3 Modulo 2 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(22,9,'Aula 4 Modulo 2 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(23,9,'Aula 5 Modulo 2 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');

insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(24,10,'Aula 1 Modulo 3 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(25,10,'Aula 2 Modulo 3 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(26,10,'Aula 3 Modulo 3 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(27,10,'Aula 4 Modulo 3 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');

insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(28,11,'Aula 1 Modulo 4 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(29,11,'Aula 2 Modulo 4 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(30,11,'Aula 3 Modulo 4 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');

insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(31,12,'Aula 1 Modulo 5 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');
insert into aula(aul_codigo, mod_codigo, aul_titulo, aul_descricao, aul_conteudo, aul_video, aul_status)
values(32,12,'Aula 2 Modulo 5 PHP','Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
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
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','https://www.youtube.com/?gl=BRhl=pt', 'A');

/*Anexo*/
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (1, 1, 'Apostila 1', 'Bacteremia', '/vel/ipsum/praesent/blandit/lacinia/erat.html', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (2, 1, 'Apostila 2', 'Gambling and betting', '/risus/auctor.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (3, 3, 'Apostila 1', 'Exfl d/t eryth 80-89 bdy', '/cras/non/velit/nec/nisi.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (4, 3, 'Apostila 2', 'Taeniasis NOS', '/eget/orci/vehicula/condimentum/curabitur/in/libero.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (5, 4, 'Apostila 1', 'Tubal ligation status', '/nisl/aenean/lectus/pellentesque/eget/nunc.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (6, 5, 'Apostila 1', 'Ob trauma NEC-del w p/p', '/sit/amet/eleifend/pede/libero/quis/orci.png', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (7, 5, 'Apostila 2', 'Cicatricial entropion', '/maecenas/ut/massa/quis/augue.jpg', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (8, 5, 'Apostila 3', 'Food pois: v. parahaem', '/a/libero/nam/dui/proin/leo.json', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (9, 5, 'Apostila 4', 'Venomous bite/sting NOS', '/ipsum/ac.png', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (10, 6, 'Apostila 1', 'Submers NEC-crew', '/vestibulum/proin/eu/mi/nulla/ac/enim.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (11, 7, 'Apostila 1', 'Ascending colon inj-open', '/quisque.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (13, 8, 'Apostila 1', 'Inf mcrg rstn sulfnmides', '/consequat/dui.xml', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (14, 9, 'Apostila 1', 'Ca in situ fem gen NEC', '/in/magna/bibendum/imperdiet.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (15, 9, 'Apostila 2', 'Cl skull fx NEC-brf coma', '/eu.html', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (16, 9, 'Apostila 3', 'Bacteremia', '/vel/ipsum/praesent/blandit/lacinia/erat.html', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (17, 10, 'Apostila 1', 'Gambling and betting', '/risus/auctor.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (18, 10, 'Apostila 2', 'Exfl d/t eryth 80-89 bdy', '/cras/non/velit/nec/nisi.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (19, 12, 'Apostila 1', 'Taeniasis NOS', '/eget/orci/vehicula/condimentum/curabitur/in/libero.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (20, 13, 'Apostila 1', 'Tubal ligation status', '/nisl/aenean/lectus/pellentesque/eget/nunc.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (21, 14, 'Apostila 1', 'Ob trauma NEC-del w p/p', '/sit/amet/eleifend/pede/libero/quis/orci.png', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (22, 15, 'Apostila 1', 'Cicatricial entropion', '/maecenas/ut/massa/quis/augue.jpg', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (23, 15, 'Apostila 2', 'Food pois: v. parahaem', '/a/libero/nam/dui/proin/leo.json', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (24, 16, 'Apostila 1', 'Venomous bite/sting NOS', '/ipsum/ac.png', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (25, 17, 'Apostila 1', 'Submers NEC-crew', '/vestibulum/proin/eu/mi/nulla/ac/enim.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (26, 18, 'Apostila 1', 'Ascending colon inj-open', '/quisque.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (27, 18, 'Apostila 2', 'Inf mcrg rstn sulfnmides', '/consequat/dui.xml', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (29, 18, 'Apostila 3', 'Ca in situ fem gen NEC', '/in/magna/bibendum/imperdiet.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (30, 19, 'Apostila 1', 'Cl skull fx NEC-brf coma', '/eu.html', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (31, 25, 'Apostila 2', 'Inf mcrg rstn sulfnmides', '/consequat/dui.xml', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (32, 26, 'Apostila 2', 'Ca in situ fem gen NEC', '/in/magna/bibendum/imperdiet.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (33, 27, 'Apostila 1', 'Cl skull fx NEC-brf coma', '/eu.html', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (34, 25, 'Apostila 2', 'Inf mcrg rstn sulfnmides', '/consequat/dui.xml', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (35, 26, 'Apostila 2', 'Ca in situ fem gen NEC', '/in/magna/bibendum/imperdiet.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (36, 27, 'Apostila 2', 'Cl skull fx NEC-brf coma', '/eu.html', 'A');


/*Compra*/

insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (1, 35, '16/08/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (2, 24, '16/08/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (3, 18, '20/03/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (4, 20, '25/12/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (5, 23, '02/05/2019', 'DEBITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (6, 47, '22/07/2017', 'BOLETO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (7, 15, '07/08/2017', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (8, 2, '19/01/2017', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (9, 29, '21/10/2018', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (10, 14, '15/03/2018', 'DEBITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (11, 5, '04/06/2018', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (12, 12, '17/02/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (13, 7, '27/02/2017', 'TRANSFERENCIA', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (14, 38, '12/10/2017', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (15, 36, '04/06/2017', 'BOLETO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (16, 14, '19/01/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (17, 36, '01/09/2017', 'BOLETO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (18, 2, '22/03/2017', 'BOLETO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (19, 3, '19/07/2017', 'DEBITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (20, 32, '11/07/2018', 'BOLETO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (21, 42, '04/02/2019', 'DEBITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (22, 26, '19/06/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (23, 1, '25/02/2017', 'DEBITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (24, 16, '02/10/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (25, 17, '16/12/2018', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (26, 9, '06/11/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (27, 26, '30/04/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (28, 45, '27/08/2018', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (29, 26, '01/09/2017', 'BOLETO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (30, 44, '08/09/2018', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (31, 41, '12/11/2017', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (32, 30, '05/04/2017', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (33, 46, '02/03/2017', 'DEBITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (34, 24, '31/05/2018', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (35, 4, '07/07/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (36, 43, '15/10/2018', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (37, 36, '01/12/2017', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (38, 1, '24/06/2017', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (39, 21, '28/12/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (40, 27, '06/06/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (41, 39, '20/09/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (42, 41, '12/10/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (43, 4, '07/12/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (44, 18, '25/06/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (45, 32, '18/03/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (46, 39, '30/06/2018', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (47, 9, '15/05/2019', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (48, 24, '26/01/2017', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (49, 2, '19/08/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (50, 25, '27/01/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (51, 24, '24/01/2019', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (52, 7, '03/02/2019', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (53, 3, '26/05/2019', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (54, 42, '25/05/2019', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (55, 46, '11/01/2018', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (56, 29, '28/05/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (57, 36, '02/11/2017', 'TRANSFERENCIA', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (58, 19, '12/04/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (59, 28, '23/04/2019', 'DEBITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (60, 46, '06/08/2018', 'BOLETO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (61, 40, '24/01/2019', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (62, 6, '13/05/2019', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (63, 46, '31/08/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (64, 4, '24/10/2017', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (65, 30, '26/04/2019', 'BOLETO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (66, 24, '05/01/2018', 'TRANSFERENCIA', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (67, 37, '29/01/2017', 'BOLETO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (68, 2, '20/04/2019', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (69, 14, '30/11/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (70, 9, '15/06/2018', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (71, 18, '21/06/2017', 'DEBITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (72, 13, '03/01/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (73, 26, '16/05/2019', 'DEBITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (74, 21, '25/04/2017', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (75, 10, '17/03/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (76, 3, '16/12/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (77, 5, '28/03/2019', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (78, 45, '05/02/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (79, 46, '07/06/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (80, 41, '27/09/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (81, 42, '14/02/2018', 'BOLETO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (82, 6, '08/10/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (83, 44, '23/08/2017', 'TRANSFERENCIA', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (84, 1, '30/03/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (85, 13, '13/08/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (86, 15, '17/03/2017', 'BOLETO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (87, 42, '28/10/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (88, 20, '27/09/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (89, 37, '06/06/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (90, 36, '14/04/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (91, 18, '25/11/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (92, 8, '16/02/2017', 'DEBITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (93, 1, '24/12/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (94, 16, '03/01/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (95, 18, '04/04/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (96, 6, '05/08/2018', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (97, 26, '28/12/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (98, 5, '18/05/2018', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (99, 13, '23/07/2018', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (100, 20, '16/08/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (101, 7, '16/05/2018', 'DEBITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (102, 9, '14/03/2018', 'BOLETO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (103, 47, '21/01/2019', 'TRANSFERENCIA', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (104, 47, '15/04/2018', 'DEBITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (105, 7, '11/07/2017', 'DEBITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (106, 3, '10/02/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (107, 5, '11/11/2018', 'BOLETO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (108, 3, '19/08/2018', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (109, 34, '09/10/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (110, 38, '07/08/2018', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (111, 15, '16/04/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (112, 43, '03/10/2018', 'BOLETO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (113, 38, '02/05/2017', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (114, 27, '07/09/2017', 'DEBITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (115, 8, '25/01/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (116, 39, '14/02/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (117, 7, '02/12/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (118, 25, '28/05/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (119, 44, '30/04/2017', 'BOLETO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (120, 25, '06/08/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (121, 13, '04/06/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (122, 27, '25/03/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (123, 11, '19/11/2017', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (124, 25, '08/10/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (125, 17, '21/08/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (126, 34, '15/06/2017', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (127, 33, '26/06/2017', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (128, 4, '26/06/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (129, 12, '14/06/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (130, 10, '07/07/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (131, 2, '07/03/2018', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (132, 47, '08/08/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (133, 3, '16/11/2018', 'DEBITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (134, 11, '28/06/2018', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (135, 12, '21/02/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (136, 15, '11/04/2019', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (137, 47, '18/12/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (138, 33, '25/06/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (139, 9, '20/01/2019', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (140, 24, '30/05/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (141, 22, '02/12/2017', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (142, 11, '21/11/2017', 'TRANSFERENCIA', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (143, 47, '02/07/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (144, 20, '07/09/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (145, 36, '10/06/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (146, 9, '10/10/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (147, 13, '07/06/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (148, 22, '09/09/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (149, 8, '24/02/2017', 'DEBITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (150, 18, '09/05/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (151, 36, '09/11/2018', 'DEBITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (152, 20, '18/03/2019', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (153, 40, '31/08/2017', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (154, 1, '02/01/2019', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (155, 33, '31/03/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (156, 29, '28/08/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (157, 36, '23/02/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (158, 12, '08/01/2017', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (159, 9, '07/12/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (160, 5, '22/11/2018', 'TRANSFERENCIA', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (161, 19, '16/04/2018', 'BOLETO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (162, 47, '23/04/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (163, 33, '02/06/2018', 'TRANSFERENCIA', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (164, 12, '20/02/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (165, 26, '15/02/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (166, 2, '25/04/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (167, 8, '19/05/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (168, 18, '13/09/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (169, 29, '19/03/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (170, 21, '09/11/2018', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (171, 32, '16/03/2019', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (172, 2, '03/07/2018', 'BOLETO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (173, 2, '30/07/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (174, 5, '13/03/2019', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (175, 5, '17/07/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (176, 38, '11/03/2018', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (177, 7, '12/01/2019', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (178, 21, '08/09/2017', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (179, 46, '19/01/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (180, 24, '21/04/2018', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (181, 13, '07/11/2017', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (182, 11, '16/11/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (183, 43, '17/03/2018', 'BOLETO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (184, 13, '30/08/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (185, 42, '09/08/2017', 'DEBITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (186, 35, '24/03/2019', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (187, 26, '06/04/2018', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (188, 27, '02/03/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (189, 22, '28/02/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (190, 39, '15/05/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (191, 26, '16/10/2018', 'BOLETO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (192, 39, '19/01/2017', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (193, 5, '09/06/2018', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (194, 7, '06/03/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (195, 27, '29/03/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (196, 9, '02/01/2019', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (197, 27, '03/04/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (198, 27, '03/05/2018', 'TRANSFERENCIA', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (199, 22, '12/05/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (200, 33, '06/11/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (201, 10, '02/01/2017', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (202, 24, '25/06/2017', 'BOLETO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (203, 1, '25/02/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (204, 32, '04/03/2018', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (205, 47, '15/02/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (206, 23, '17/10/2018', 'DEBITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (207, 4, '03/02/2018', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (208, 34, '19/11/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (209, 18, '02/05/2018', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (210, 40, '20/11/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (211, 18, '17/04/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (212, 11, '22/07/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (213, 38, '22/06/2018', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (214, 4, '12/01/2017', 'BOLETO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (215, 45, '07/02/2019', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (216, 35, '10/06/2017', 'TRANSFERENCIA', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (217, 16, '01/08/2018', 'BOLETO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (218, 5, '11/02/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (219, 44, '09/01/2019', 'TRANSFERENCIA', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (220, 19, '01/07/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (221, 19, '25/08/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (222, 20, '03/02/2019', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (223, 44, '11/08/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (224, 4, '17/01/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (225, 39, '14/03/2018', 'DEBITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (226, 33, '06/01/2018', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (227, 4, '20/04/2017', 'DEBITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (228, 19, '10/05/2019', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (229, 28, '22/05/2019', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (230, 28, '06/11/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (231, 11, '28/04/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (232, 42, '04/03/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (233, 37, '05/01/2018', 'BOLETO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (234, 44, '13/11/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (235, 42, '07/11/2018', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (236, 1, '06/01/2018', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (237, 33, '27/08/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (238, 2, '20/02/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (239, 36, '22/11/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (240, 11, '11/04/2017', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (241, 31, '28/02/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (242, 16, '27/01/2017', 'DEBITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (243, 14, '14/11/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (244, 20, '10/04/2018', 'DEBITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (245, 24, '18/09/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (246, 47, '03/02/2019', 'BOLETO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (247, 21, '10/08/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (248, 2, '12/08/2018', 'DEBITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (249, 11, '27/12/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (250, 11, '19/07/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (251, 4, '06/01/2017', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (252, 15, '17/02/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (253, 8, '16/03/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (254, 46, '01/11/2017', 'BOLETO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (255, 33, '22/12/2017', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (256, 1, '11/10/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (257, 26, '01/11/2018', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (258, 31, '12/09/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (259, 32, '11/02/2019', 'DEBITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (260, 41, '14/04/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (261, 41, '10/01/2019', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (262, 46, '26/06/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (263, 6, '08/05/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (264, 38, '05/05/2019', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (265, 11, '22/05/2017', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (266, 10, '21/03/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (267, 44, '03/06/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (268, 7, '19/11/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (269, 15, '09/11/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (270, 36, '07/07/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (271, 45, '20/10/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (272, 47, '06/03/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (273, 6, '22/09/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (274, 10, '10/11/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (275, 10, '14/12/2017', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (276, 6, '14/11/2018', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (277, 2, '08/12/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (278, 7, '29/11/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (279, 21, '23/02/2017', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (280, 2, '25/10/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (281, 28, '02/01/2017', 'DEBITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (282, 28, '05/02/2019', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (283, 2, '12/07/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (284, 5, '11/12/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (285, 14, '16/03/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (286, 29, '05/11/2017', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (287, 8, '06/05/2018', 'TRANSFERENCIA', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (288, 35, '09/03/2019', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (289, 9, '20/03/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (290, 4, '17/01/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (291, 12, '23/01/2017', 'TRANSFERENCIA', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (292, 31, '06/01/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (293, 7, '24/02/2017', 'TRANSFERENCIA', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (294, 36, '26/12/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (295, 31, '20/04/2018', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (296, 23, '19/09/2018', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (297, 14, '22/02/2017', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (298, 28, '24/12/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (299, 47, '03/11/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (300, 8, '06/03/2019', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (301, 2, '05/01/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (302, 40, '11/08/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (303, 26, '13/10/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (304, 30, '08/03/2017', 'DEBITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (305, 37, '07/04/2018', 'DEBITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (306, 45, '05/08/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (307, 24, '30/05/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (308, 22, '16/03/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (309, 21, '08/05/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (310, 30, '16/11/2018', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (311, 9, '17/12/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (312, 8, '23/05/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (313, 44, '15/03/2017', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (314, 6, '30/04/2019', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (315, 13, '09/07/2018', 'DEBITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (316, 7, '18/12/2018', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (317, 7, '17/10/2017', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (318, 41, '19/01/2017', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (319, 25, '12/12/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (320, 14, '12/09/2017', 'DEBITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (321, 15, '25/02/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (322, 23, '27/06/2018', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (323, 35, '23/07/2018', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (324, 24, '01/12/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (325, 33, '19/04/2017', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (326, 23, '26/03/2017', 'BOLETO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (327, 14, '25/06/2018', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (328, 9, '08/05/2017', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (329, 20, '24/03/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (330, 22, '24/01/2019', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (331, 8, '25/10/2018', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (332, 5, '10/06/2018', 'DEBITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (333, 8, '06/02/2019', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (334, 19, '20/10/2017', 'DEBITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (335, 23, '07/10/2017', 'DEBITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (336, 27, '05/12/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (337, 1, '03/02/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (338, 14, '28/08/2018', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (339, 34, '23/04/2019', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (340, 27, '20/10/2018', 'DEBITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (341, 40, '03/10/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (342, 16, '03/10/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (343, 45, '05/03/2019', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (344, 4, '15/03/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (345, 41, '15/03/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (346, 29, '23/12/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (347, 21, '25/03/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (348, 21, '10/11/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (349, 6, '21/07/2018', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (350, 41, '11/04/2019', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (351, 7, '11/05/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (352, 22, '20/07/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (353, 12, '17/09/2017', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (354, 17, '28/06/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (355, 40, '18/01/2018', 'DEBITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (356, 11, '28/01/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (357, 33, '26/04/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (358, 14, '12/08/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (359, 46, '25/02/2019', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (360, 43, '24/07/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (361, 37, '13/06/2018', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (362, 38, '30/10/2017', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (363, 23, '26/06/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (364, 9, '17/10/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (365, 19, '18/05/2019', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (366, 18, '16/10/2018', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (367, 33, '16/01/2019', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (368, 32, '07/01/2018', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (369, 1, '02/11/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (370, 25, '30/10/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (371, 30, '25/12/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (372, 7, '09/02/2017', 'BOLETO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (373, 10, '25/06/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (374, 35, '07/08/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (375, 25, '16/02/2019', 'BOLETO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (376, 26, '26/01/2019', 'BOLETO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (377, 26, '12/09/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (378, 24, '13/02/2018', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (379, 42, '30/06/2018', 'BOLETO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (380, 30, '13/08/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (381, 5, '22/04/2017', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (382, 44, '18/04/2018', 'BOLETO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (383, 26, '14/01/2018', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (384, 12, '12/04/2018', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (385, 34, '15/02/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (386, 47, '18/11/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (387, 43, '20/11/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (388, 11, '17/02/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (389, 14, '15/01/2017', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (390, 36, '29/05/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (391, 33, '24/10/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (392, 9, '30/11/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (393, 23, '01/09/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (394, 36, '09/12/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (395, 39, '09/06/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (396, 12, '26/12/2018', 'DEBITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (397, 9, '07/02/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (398, 46, '26/01/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (399, 10, '30/08/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (400, 27, '31/01/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (401, 18, '08/07/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (402, 31, '24/05/2019', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (403, 44, '22/04/2019', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (404, 18, '02/03/2018', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (405, 37, '30/06/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (406, 13, '09/09/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (407, 16, '08/06/2018', 'TRANSFERENCIA', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (408, 7, '06/03/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (409, 47, '11/01/2018', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (410, 22, '11/01/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (411, 19, '20/03/2018', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (412, 29, '03/12/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (413, 13, '17/05/2018', 'TRANSFERENCIA', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (414, 43, '20/06/2017', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (415, 22, '31/08/2018', 'DEBITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (416, 45, '08/01/2017', 'BOLETO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (417, 5, '31/03/2017', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (418, 16, '09/01/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (419, 5, '01/05/2017', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (420, 5, '19/11/2018', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (421, 12, '05/04/2019', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (422, 21, '07/08/2017', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (423, 9, '20/10/2017', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (424, 9, '11/12/2017', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (425, 6, '24/02/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (426, 21, '24/04/2018', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (427, 29, '14/12/2018', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (428, 30, '19/02/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (429, 38, '03/03/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (430, 8, '25/04/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (431, 37, '15/05/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (432, 9, '18/06/2017', 'DEBITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (433, 41, '24/08/2018', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (434, 20, '11/02/2019', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (435, 27, '03/01/2019', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (436, 16, '20/01/2017', 'BOLETO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (437, 41, '12/07/2018', 'BOLETO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (438, 5, '25/08/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (439, 27, '12/05/2019', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (440, 26, '11/01/2017', 'TRANSFERENCIA', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (441, 45, '09/04/2019', 'CREDITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (442, 6, '13/11/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (443, 14, '17/11/2017', 'TRANSFERENCIA', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (444, 10, '18/11/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (445, 11, '14/08/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (446, 39, '10/11/2017', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (447, 47, '23/10/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (448, 46, '15/09/2017', 'TRANSFERENCIA', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (449, 46, '24/10/2018', 'DEBITO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (450, 42, '06/02/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (451, 12, '05/05/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (452, 2, '06/07/2018', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (453, 15, '28/10/2018', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (454, 3, '06/06/2017', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (455, 12, '19/01/2019', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (456, 35, '13/01/2019', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (457, 5, '29/03/2017', 'DEBITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (458, 39, '01/11/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (459, 47, '21/11/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (460, 27, '04/10/2017', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (461, 26, '15/06/2017', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (462, 30, '12/11/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (463, 30, '21/03/2018', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (464, 5, '23/12/2018', 'DEBITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (465, 46, '21/07/2018', 'DEBITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (466, 42, '30/10/2017', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (467, 29, '13/10/2017', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (468, 34, '12/08/2017', 'BOLETO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (469, 38, '09/01/2019', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (470, 16, '07/05/2017', 'DEBITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (471, 2, '15/08/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (472, 24, '30/04/2018', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (473, 23, '28/01/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (474, 24, '18/04/2017', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (475, 19, '18/03/2018', 'BOLETO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (476, 42, '08/02/2018', 'BOLETO', 5, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (477, 27, '10/12/2017', 'CREDITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (478, 45, '02/03/2019', 'TRANSFERENCIA', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (479, 12, '05/05/2018', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (480, 4, '06/03/2017', 'DEBITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (481, 18, '14/07/2018', 'CREDITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (482, 46, '09/07/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (483, 32, '17/12/2017', 'TRANSFERENCIA', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (484, 6, '20/05/2017', 'BOLETO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (485, 37, '13/10/2017', 'DEBITO', 2, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (486, 15, '30/06/2017', 'CREDITO', 4, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (487, 37, '06/08/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (488, 7, '12/05/2019', 'CREDITO', 3, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (489, 26, '15/12/2017', 'CREDITO', 7, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (490, 42, '26/01/2018', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (491, 26, '16/05/2019', 'CREDITO', 6, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (492, 1, '13/03/2018', 'TRANSFERENCIA', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (493, 20, '13/03/2019', 'DEBITO', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (494, 16, '21/10/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (495, 45, '21/08/2018', 'CREDITO', 1, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (496, 41, '24/01/2019', 'CREDITO', 9, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (497, 23, '14/03/2017', 'TRANSFERENCIA', 8, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (498, 35, '13/04/2018', 'DEBITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (499, 12, '12/03/2017', 'CREDITO', 10, 'AG');
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS) values (500, 4, '31/05/2017', 'TRANSFERENCIA', 1, 'AG');

/*ItemCompra*/
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 101, 3, 95.77);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 118, 4, 180.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 459, 4, 383.39);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 232, 4, 378.08);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 262, 1, 462.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 226, 2, 298.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 467, 1, 165.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 162, 5, 204.67);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 375, 3, 268.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 208, 3, 461.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 438, 5, 128.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 126, 4, 302.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 413, 4, 206.65);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 149, 1, 165.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 456, 5, 126.55);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 133, 1, 232.00);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 241, 4, 98.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 321, 1, 118.77);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 333, 3, 59.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 274, 2, 392.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 238, 3, 299.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 478, 1, 230.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 434, 5, 471.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 351, 3, 314.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 317, 3, 103.66);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 222, 3, 84.14);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 35, 5, 407.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 265, 4, 415.89);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 406, 4, 415.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 97, 4, 93.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 114, 4, 492.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 365, 4, 154.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 191, 1, 233.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 374, 4, 416.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 38, 1, 305.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 279, 5, 206.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 322, 4, 469.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 40, 5, 415.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 383, 2, 305.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 202, 3, 366.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 458, 2, 180.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 490, 1, 470.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 377, 1, 417.15);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 70, 5, 382.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 36, 3, 218.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 9, 5, 100.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 360, 5, 329.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 135, 1, 143.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 32, 1, 463.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 214, 1, 381.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 175, 2, 318.43);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 304, 3, 285.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 476, 3, 290.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 320, 2, 303.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 189, 2, 230.97);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 286, 1, 441.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 312, 3, 432.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 303, 3, 258.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 401, 2, 183.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 267, 2, 345.22);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 253, 4, 299.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 123, 5, 127.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 237, 3, 192.15);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 156, 3, 75.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 111, 4, 323.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 76, 1, 452.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 464, 1, 283.31);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 66, 3, 432.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 15, 2, 222.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 231, 2, 122.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 462, 2, 183.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 174, 5, 56.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 34, 5, 104.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 261, 4, 249.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 305, 3, 344.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 45, 1, 76.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 372, 5, 388.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 237, 2, 214.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 143, 3, 160.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 164, 5, 255.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 3, 4, 228.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 407, 2, 158.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 423, 2, 332.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 71, 3, 483.50);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 33, 1, 91.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 419, 5, 404.50);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 109, 4, 320.75);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 281, 4, 440.07);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 115, 5, 321.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 499, 3, 353.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 387, 2, 362.39);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 276, 3, 438.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 131, 5, 342.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 103, 2, 96.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 422, 1, 450.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 333, 3, 129.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 57, 3, 66.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 480, 1, 100.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 195, 4, 470.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 490, 1, 405.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 459, 5, 432.57);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 206, 5, 291.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 232, 5, 462.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 246, 5, 210.07);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 412, 3, 386.40);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 178, 3, 255.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 493, 3, 384.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 427, 5, 214.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 223, 2, 391.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 336, 3, 432.67);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 434, 3, 60.15);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 428, 4, 107.67);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 204, 5, 96.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 303, 1, 329.15);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 465, 4, 153.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 5, 3, 496.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 29, 1, 498.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 396, 3, 312.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 75, 2, 81.51);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 324, 1, 253.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 356, 5, 133.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 434, 3, 338.61);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 310, 5, 128.82);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 443, 5, 375.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 387, 2, 192.31);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 118, 5, 427.80);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 11, 1, 58.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 410, 5, 67.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 354, 3, 339.61);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 255, 5, 489.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 348, 5, 201.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 51, 3, 427.70);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 398, 5, 371.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 483, 2, 333.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 388, 4, 459.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 174, 1, 92.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 271, 4, 427.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 417, 2, 227.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 97, 4, 82.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 320, 3, 99.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 42, 5, 269.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 6, 2, 463.29);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 135, 1, 187.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 83, 4, 176.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 207, 1, 223.80);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 349, 5, 463.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 55, 2, 365.75);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 335, 5, 406.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 20, 1, 182.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 44, 1, 106.98);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 326, 1, 227.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 467, 2, 453.39);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 339, 5, 409.07);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 399, 2, 420.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 324, 2, 425.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 463, 4, 458.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 248, 5, 417.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 64, 1, 66.98);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 315, 5, 158.32);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 346, 1, 146.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 129, 3, 430.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 329, 2, 456.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 47, 5, 250.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 219, 1, 304.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 491, 2, 250.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 321, 1, 298.82);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 17, 5, 351.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 351, 5, 433.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 297, 5, 400.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 101, 2, 239.82);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 50, 1, 380.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 9, 2, 105.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 132, 3, 115.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 447, 3, 362.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 67, 3, 490.00);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 331, 3, 388.97);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 301, 2, 295.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 62, 5, 234.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 450, 2, 322.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 490, 2, 98.87);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 136, 3, 437.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 278, 5, 254.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 305, 1, 165.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 116, 5, 471.50);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 451, 1, 193.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 205, 4, 211.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 368, 5, 329.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 169, 2, 235.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 251, 5, 209.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 115, 5, 159.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 48, 4, 487.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 378, 1, 277.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 278, 4, 103.47);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 367, 1, 487.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 186, 1, 407.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 273, 3, 115.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 387, 1, 286.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 240, 1, 493.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 104, 2, 346.29);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 142, 1, 286.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 217, 1, 154.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 127, 3, 116.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 437, 2, 412.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 441, 4, 99.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 183, 2, 199.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 363, 2, 427.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 162, 5, 229.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 464, 5, 257.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 61, 1, 378.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 468, 5, 213.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 264, 3, 404.96);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 242, 3, 189.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 235, 3, 493.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 431, 4, 426.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 251, 3, 352.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 446, 5, 322.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 254, 1, 483.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 177, 1, 388.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 430, 5, 416.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 88, 2, 467.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 482, 1, 231.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 82, 5, 86.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 90, 3, 63.43);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 66, 1, 445.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 58, 2, 172.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 161, 5, 397.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 397, 1, 309.14);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 31, 5, 433.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 62, 5, 472.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 288, 1, 252.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 38, 4, 329.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 466, 4, 114.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 261, 1, 320.32);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 3, 2, 71.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 192, 5, 309.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 72, 5, 321.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 311, 3, 180.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 355, 1, 421.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 290, 2, 189.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 341, 2, 311.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 61, 3, 164.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 1, 3, 277.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 63, 4, 263.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 356, 2, 305.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 57, 5, 264.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 418, 3, 230.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 302, 2, 265.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 499, 4, 354.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 387, 1, 293.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 336, 1, 289.96);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 424, 3, 479.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 423, 5, 290.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 56, 3, 494.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 166, 2, 136.22);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 230, 1, 136.96);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 285, 3, 54.65);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 298, 4, 201.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 26, 2, 203.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 298, 5, 64.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 51, 4, 180.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 348, 3, 131.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 313, 3, 438.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 422, 2, 457.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 215, 3, 96.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 459, 3, 321.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 148, 5, 259.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 235, 5, 390.65);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 299, 2, 114.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 23, 2, 308.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 476, 4, 293.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 423, 2, 165.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 435, 3, 244.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 233, 1, 481.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 181, 2, 102.80);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 120, 2, 268.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 51, 1, 234.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 447, 5, 148.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 132, 4, 314.75);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 151, 2, 189.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 37, 1, 423.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 64, 2, 273.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 110, 2, 80.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 440, 5, 430.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 305, 3, 417.39);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 109, 3, 394.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 169, 5, 96.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 27, 1, 321.00);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 102, 3, 164.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 91, 2, 263.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 210, 2, 59.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 273, 2, 311.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 395, 5, 237.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 345, 5, 332.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 440, 4, 213.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 151, 1, 288.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 121, 5, 53.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 62, 5, 92.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 163, 4, 122.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 462, 5, 258.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 260, 1, 443.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 124, 3, 383.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 255, 2, 195.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 398, 5, 265.08);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 448, 2, 291.75);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 273, 2, 171.40);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 217, 2, 341.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 204, 5, 478.66);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 253, 2, 306.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 194, 3, 249.66);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 112, 2, 257.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 350, 2, 471.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 439, 5, 335.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 20, 5, 146.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 46, 2, 51.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 25, 2, 258.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 278, 2, 381.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 198, 4, 240.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 474, 4, 385.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 457, 2, 194.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 197, 3, 455.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 191, 5, 475.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 163, 4, 51.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 107, 3, 454.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 215, 2, 462.82);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 396, 4, 201.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 232, 3, 64.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 145, 4, 209.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 207, 4, 161.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 473, 3, 409.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 414, 1, 228.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 322, 5, 450.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 493, 4, 322.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 100, 4, 474.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 443, 1, 103.36);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 70, 5, 455.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 135, 2, 187.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 293, 3, 140.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 404, 3, 453.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 297, 4, 252.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 23, 3, 444.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 110, 2, 154.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 45, 2, 426.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 122, 3, 249.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 179, 4, 315.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 396, 5, 279.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 351, 1, 173.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 355, 4, 80.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 425, 5, 95.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 194, 1, 192.61);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 391, 1, 164.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 349, 1, 174.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 276, 2, 212.00);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 14, 2, 294.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 173, 1, 468.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 156, 2, 168.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 166, 5, 132.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 180, 3, 235.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 168, 4, 478.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 437, 5, 188.40);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 41, 2, 389.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 328, 1, 129.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 259, 4, 355.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 221, 4, 102.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 308, 1, 50.96);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 151, 5, 56.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 289, 5, 471.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 19, 5, 337.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 198, 1, 399.87);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 25, 3, 55.51);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 473, 2, 244.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 331, 1, 180.66);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 63, 5, 165.57);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 174, 3, 144.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 467, 4, 383.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 291, 5, 80.22);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 151, 2, 159.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 386, 4, 470.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 71, 1, 135.50);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 94, 2, 368.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 245, 4, 440.47);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 76, 3, 421.47);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 21, 2, 380.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 191, 2, 486.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 458, 1, 454.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 418, 4, 466.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 272, 1, 413.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 238, 1, 355.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 92, 3, 260.65);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 433, 1, 256.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 452, 2, 467.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 412, 5, 360.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 344, 2, 174.61);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 475, 2, 488.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 418, 4, 71.40);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 417, 1, 253.36);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 365, 3, 179.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 151, 5, 188.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 65, 1, 72.24);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 344, 4, 298.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 480, 2, 154.70);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 157, 5, 129.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 93, 2, 250.47);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 347, 4, 483.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 275, 4, 429.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 311, 4, 432.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 475, 1, 458.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 425, 3, 189.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 252, 4, 401.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 483, 1, 102.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 302, 1, 269.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 265, 2, 82.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 48, 1, 337.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 110, 4, 270.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 403, 1, 252.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 1, 2, 95.66);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 150, 1, 495.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 310, 3, 53.94);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 198, 1, 455.88);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 86, 2, 155.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 172, 5, 67.43);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 68, 4, 139.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 263, 4, 439.39);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 25, 4, 388.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 284, 2, 336.31);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 324, 1, 247.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 118, 4, 392.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 294, 1, 273.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 49, 5, 371.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 367, 2, 254.47);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 483, 4, 187.00);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 380, 1, 192.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 459, 2, 350.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 391, 2, 126.80);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 460, 2, 440.89);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 371, 3, 203.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 312, 2, 226.23);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 310, 3, 345.94);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 25, 2, 300.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 291, 3, 163.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 74, 5, 236.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 211, 1, 123.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 304, 5, 279.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 263, 4, 156.61);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 21, 3, 410.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 412, 2, 293.47);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 331, 5, 63.65);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 303, 3, 467.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 6, 1, 356.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 371, 4, 143.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 348, 5, 427.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 498, 4, 206.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 316, 5, 227.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 344, 1, 93.57);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 464, 5, 399.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 252, 2, 74.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 377, 1, 450.43);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 85, 1, 258.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 460, 5, 466.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 411, 5, 394.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 415, 1, 307.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 27, 5, 138.94);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 220, 3, 395.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 82, 4, 213.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 436, 3, 476.24);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 458, 1, 476.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 101, 1, 71.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 244, 5, 359.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 331, 2, 368.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 117, 1, 493.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 284, 3, 313.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 230, 3, 246.14);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 18, 4, 364.51);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 347, 1, 236.23);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 233, 2, 313.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 415, 4, 249.75);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 282, 3, 341.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 469, 5, 148.39);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 20, 2, 167.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 419, 5, 236.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 330, 2, 333.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 393, 5, 248.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 153, 2, 356.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 82, 5, 189.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 269, 2, 167.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 426, 1, 346.00);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 25, 5, 294.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 353, 2, 206.57);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 383, 4, 308.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 359, 5, 135.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 47, 2, 369.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 475, 3, 288.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 182, 4, 362.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 176, 3, 315.07);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 219, 1, 470.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 183, 4, 202.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 30, 5, 179.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 411, 4, 299.39);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 376, 5, 359.32);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 319, 3, 158.15);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 445, 1, 375.08);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 223, 2, 127.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 239, 3, 214.98);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 450, 5, 289.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 334, 3, 59.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 105, 4, 78.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 476, 2, 432.55);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 48, 2, 74.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 201, 4, 234.75);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 49, 1, 178.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 168, 5, 101.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 6, 2, 182.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 399, 5, 136.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 243, 2, 233.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 16, 3, 299.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 120, 2, 343.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 81, 3, 390.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 281, 2, 99.07);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 134, 5, 214.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 159, 4, 253.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 345, 1, 360.94);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 108, 3, 111.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 429, 2, 438.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 399, 5, 373.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 269, 2, 107.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 41, 3, 216.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 250, 3, 276.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 71, 5, 325.43);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 333, 5, 150.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 279, 1, 314.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 453, 2, 495.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 152, 3, 287.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 235, 2, 89.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 287, 4, 358.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 483, 2, 250.80);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 70, 1, 469.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 298, 1, 453.87);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 148, 1, 363.14);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 125, 4, 274.22);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 123, 4, 467.50);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 161, 1, 423.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 239, 3, 218.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 303, 2, 369.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 396, 2, 393.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 409, 4, 125.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 127, 3, 114.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 77, 5, 328.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 140, 3, 333.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 457, 3, 232.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 250, 4, 238.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 315, 1, 54.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 458, 3, 245.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 65, 3, 138.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 412, 4, 332.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 173, 3, 255.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 174, 4, 268.89);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 446, 3, 428.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 376, 2, 498.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 233, 1, 355.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 481, 4, 234.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 251, 5, 58.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 381, 5, 290.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 46, 3, 262.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 342, 2, 160.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 372, 5, 153.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 314, 3, 267.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 478, 2, 402.22);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 304, 3, 362.61);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 106, 1, 464.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 321, 3, 196.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 455, 1, 186.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 382, 2, 171.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 53, 3, 155.23);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 406, 3, 120.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 160, 2, 336.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 326, 3, 134.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 459, 3, 264.40);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 446, 5, 441.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 9, 1, 399.31);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 359, 3, 171.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 431, 4, 186.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 317, 1, 188.94);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 238, 3, 200.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 375, 1, 401.97);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 269, 5, 124.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 304, 1, 355.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 49, 3, 456.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 47, 4, 325.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 294, 5, 193.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 260, 3, 205.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 52, 3, 318.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 186, 5, 240.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 157, 2, 123.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 438, 3, 318.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 47, 5, 488.70);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 67, 5, 434.67);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 256, 2, 441.08);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 362, 5, 249.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 40, 5, 225.94);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 401, 2, 137.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 305, 1, 113.23);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 492, 3, 496.66);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 365, 5, 387.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 185, 1, 124.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 224, 3, 454.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 26, 2, 424.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 340, 3, 179.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 245, 3, 139.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 408, 2, 390.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 54, 5, 474.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 465, 4, 233.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 105, 2, 322.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 34, 1, 68.87);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 361, 5, 210.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 3, 5, 252.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 89, 3, 116.80);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 147, 5, 180.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 462, 3, 105.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 118, 3, 102.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 436, 3, 465.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 11, 1, 50.55);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 499, 1, 58.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 289, 5, 330.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 5, 3, 467.33);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 339, 1, 80.23);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 66, 2, 73.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 74, 3, 223.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 282, 5, 355.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 258, 1, 296.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 389, 5, 240.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 188, 3, 396.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 68, 4, 406.65);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 83, 5, 157.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 162, 4, 123.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 22, 3, 52.66);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 388, 4, 294.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 18, 2, 226.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 240, 4, 60.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 340, 5, 371.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 225, 3, 356.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 489, 2, 463.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 215, 1, 191.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 301, 3, 404.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 342, 2, 334.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 402, 2, 146.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 358, 3, 228.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 172, 2, 159.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 301, 4, 332.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 337, 2, 257.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 367, 4, 301.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 456, 5, 69.89);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 1, 5, 438.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 84, 2, 141.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 317, 3, 182.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 38, 5, 332.24);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 265, 5, 94.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 85, 5, 265.97);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 407, 2, 145.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 450, 5, 410.31);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 363, 2, 242.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 249, 3, 73.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 31, 1, 215.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 467, 2, 369.88);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 133, 3, 282.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 60, 2, 208.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 123, 2, 158.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 326, 2, 65.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 178, 4, 175.31);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 27, 1, 361.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 441, 2, 203.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 160, 1, 220.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 377, 4, 463.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 316, 4, 264.47);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 383, 2, 54.67);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 466, 1, 486.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 52, 4, 133.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 107, 4, 308.57);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 429, 3, 132.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 154, 4, 267.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 34, 1, 100.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 166, 5, 185.56);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 147, 2, 186.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 14, 1, 106.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 267, 1, 440.37);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 116, 2, 396.29);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 6, 5, 351.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 5, 4, 166.89);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 143, 3, 170.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 452, 2, 375.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 9, 2, 103.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 364, 5, 340.32);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 365, 3, 58.76);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 409, 3, 287.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 23, 2, 166.24);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 24, 4, 259.96);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 143, 2, 131.15);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 193, 3, 116.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 106, 4, 248.07);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 90, 1, 123.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 94, 2, 176.24);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 476, 3, 493.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 38, 3, 378.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 79, 5, 286.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 319, 4, 360.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 249, 2, 452.44);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 340, 5, 241.55);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 309, 2, 198.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 418, 5, 444.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 304, 4, 303.51);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 123, 4, 340.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 446, 5, 351.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 44, 5, 404.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 392, 2, 312.61);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 258, 5, 182.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 14, 2, 437.08);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 114, 5, 265.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 38, 2, 53.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 355, 1, 281.50);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 467, 5, 480.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 37, 4, 66.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 135, 2, 388.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 173, 2, 304.88);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 254, 1, 59.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 452, 1, 338.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 233, 3, 426.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 440, 1, 330.55);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 431, 2, 417.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 214, 2, 217.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 35, 3, 480.97);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 293, 1, 87.29);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 303, 5, 314.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 136, 3, 193.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 489, 2, 180.28);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 143, 3, 64.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 375, 3, 453.65);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 186, 5, 73.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 483, 3, 90.15);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 366, 5, 322.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 472, 3, 134.24);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 401, 4, 278.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 86, 1, 417.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 382, 5, 309.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 206, 5, 191.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 331, 2, 106.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 141, 3, 173.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 199, 4, 257.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 378, 4, 318.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 307, 5, 293.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 241, 5, 53.50);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 486, 5, 226.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 151, 2, 147.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 365, 3, 53.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 124, 4, 67.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 288, 5, 114.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 245, 4, 261.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 434, 5, 154.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 23, 2, 86.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 463, 4, 255.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 173, 2, 491.36);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 281, 1, 401.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 315, 3, 309.82);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 217, 1, 66.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 310, 2, 481.89);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 184, 4, 146.51);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 226, 5, 211.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 337, 3, 96.22);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 89, 2, 356.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 251, 1, 98.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 236, 5, 224.47);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 438, 1, 181.32);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 56, 2, 100.36);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 369, 3, 422.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 466, 4, 426.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 416, 4, 246.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 294, 4, 161.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 482, 2, 188.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 357, 5, 354.82);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 119, 4, 112.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 125, 5, 197.20);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 447, 5, 77.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 454, 2, 311.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 106, 1, 193.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 49, 2, 170.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 295, 1, 421.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 308, 1, 171.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 472, 2, 207.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 130, 5, 300.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 436, 5, 331.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 394, 5, 65.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 60, 3, 397.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 466, 3, 283.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 383, 3, 175.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 449, 2, 367.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 343, 2, 227.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 318, 3, 184.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 150, 3, 373.26);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 221, 5, 78.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 237, 1, 329.77);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 58, 5, 293.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 179, 3, 252.31);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 316, 2, 172.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 4, 5, 409.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (7, 46, 4, 244.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 449, 5, 184.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 347, 2, 256.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 499, 4, 219.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 335, 2, 457.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 146, 1, 234.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 318, 5, 347.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 339, 1, 174.52);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 321, 4, 116.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 285, 4, 130.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 78, 5, 343.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 265, 2, 215.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 304, 3, 252.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 440, 5, 398.04);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 421, 2, 341.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 360, 2, 260.77);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 336, 2, 235.65);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 207, 4, 347.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 248, 2, 264.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 70, 2, 147.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 173, 5, 347.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 92, 5, 108.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 138, 2, 219.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 219, 3, 237.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 247, 3, 311.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 94, 1, 450.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 101, 1, 339.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 54, 1, 275.49);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 50, 3, 395.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 416, 5, 278.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 454, 4, 165.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 434, 2, 149.96);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 486, 1, 356.70);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 238, 2, 123.31);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 117, 4, 439.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 115, 2, 334.82);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 31, 3, 254.89);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 118, 2, 167.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 95, 4, 76.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 385, 1, 305.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 1, 2, 158.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (6, 450, 2, 430.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 294, 3, 217.40);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 86, 4, 147.96);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 234, 1, 51.21);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 123, 4, 161.36);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 25, 5, 257.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 290, 1, 416.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 76, 3, 410.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 282, 2, 260.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 306, 3, 267.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 128, 2, 74.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 266, 2, 144.35);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 74, 5, 332.06);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 202, 3, 282.36);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 329, 4, 149.64);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 72, 2, 212.45);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 427, 5, 228.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 34, 3, 303.41);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 89, 3, 69.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 170, 1, 99.50);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 253, 3, 404.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 50, 1, 443.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 249, 5, 477.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 37, 1, 167.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 233, 3, 332.02);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 126, 1, 253.55);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 147, 3, 355.57);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (1, 417, 2, 269.08);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 13, 2, 238.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 186, 4, 451.80);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 176, 1, 262.87);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 4, 3, 176.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 22, 2, 141.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 437, 3, 271.90);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 57, 4, 279.92);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 133, 1, 461.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 339, 4, 343.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 405, 3, 498.78);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 2, 4, 296.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 3, 1, 307.97);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 453, 4, 268.11);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 487, 2, 391.14);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 435, 4, 139.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 76, 3, 462.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 23, 5, 250.00);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 466, 5, 128.08);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 87, 3, 119.46);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 168, 5, 334.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 55, 2, 402.00);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 231, 4, 186.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 2, 3, 382.85);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 482, 2, 81.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 334, 5, 231.88);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 99, 3, 373.57);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 318, 4, 267.55);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 99, 4, 486.01);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 215, 5, 77.86);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 1, 3, 455.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 445, 5, 114.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (3, 80, 5, 486.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 47, 2, 134.25);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 213, 3, 95.12);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 93, 2, 358.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 323, 4, 245.13);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 500, 5, 223.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 9, 5, 224.99);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 346, 4, 335.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 492, 5, 167.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 11, 5, 358.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 22, 3, 234.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 301, 3, 194.95);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 10, 3, 150.03);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 386, 1, 145.32);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 239, 1, 182.69);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (27, 350, 4, 347.59);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 64, 3, 347.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 33, 1, 453.42);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (5, 433, 4, 249.81);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 321, 5, 212.57);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 298, 4, 121.79);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 425, 1, 102.74);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 228, 3, 140.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 419, 4, 276.19);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 340, 1, 492.63);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 168, 2, 75.22);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (11, 204, 4, 427.15);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 339, 2, 427.89);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 155, 4, 382.17);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 61, 1, 124.18);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 269, 5, 88.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (9, 401, 2, 463.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 24, 4, 370.61);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 31, 1, 97.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 160, 1, 441.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 32, 1, 252.75);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (4, 271, 1, 121.91);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 332, 1, 308.09);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (18, 237, 5, 427.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 208, 4, 349.73);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 483, 1, 383.34);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (10, 102, 3, 310.16);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 24, 2, 453.88);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (17, 37, 1, 57.27);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (14, 39, 2, 116.68);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 166, 3, 364.80);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (24, 263, 5, 219.83);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (29, 358, 2, 416.30);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (16, 238, 2, 151.82);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 390, 3, 51.70);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (28, 89, 4, 187.84);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 411, 3, 222.10);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 42, 2, 53.14);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (26, 404, 5, 227.53);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (20, 148, 2, 371.48);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (12, 86, 4, 152.71);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (13, 314, 5, 70.60);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (22, 2, 1, 281.05);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (19, 368, 3, 413.72);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (21, 350, 4, 487.54);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (8, 383, 4, 56.58);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (30, 325, 5, 392.62);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (15, 446, 4, 340.75);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (23, 374, 1, 172.38);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (2, 433, 5, 341.93);
insert into itemcompra (CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR) values (25, 129, 3, 215.98);

/*Parcelas*/
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (1, 400, 411.3, '23/08/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (2, 209, 132.1, '12/04/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (3, 377, 303.5, '24/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (4, 113, 89.93, '01/10/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (5, 231, 394.4, '11/08/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (6, 298, 283.2, '11/03/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (7, 325, 133.6, '13/06/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (8, 129, 392.7, '15/06/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (9, 122, 467.7, '29/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (10, 212, 453.9, '16/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (11, 315, 117.7, '12/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (12, 348, 375.0, '29/07/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (13, 127, 295.4, '28/01/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (14, 304, 364.4, '02/03/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (15, 347, 120.1, '05/07/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (16, 293, 409.1, '22/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (17, 215, 80.51, '15/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (18, 22, 130.8, '29/09/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (19, 77, 342.8, '24/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (20, 195, 395.1, '14/07/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (21, 369, 251.1, '03/05/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (22, 209, 252.1, '09/11/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (23, 361, 103.1, '11/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (24, 349, 196.3, '24/03/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (25, 281, 304.9, '11/08/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (26, 370, 56.05, '14/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (27, 266, 394.2, '07/04/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (28, 2, 378.2, '26/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (29, 203, 115.8, '10/08/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (30, 303, 87.97, '17/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (31, 359, 234.8, '17/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (32, 116, 333.7, '07/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (33, 376, 76.39, '18/02/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (34, 368, 251.9, '07/08/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (35, 340, 50.94, '14/02/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (36, 302, 124.1, '13/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (37, 257, 402.1, '30/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (38, 108, 431.8, '10/05/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (39, 345, 281.3, '17/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (40, 184, 263.2, '15/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (41, 91, 159.5, '29/05/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (42, 279, 166.8, '15/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (43, 247, 483.4, '15/01/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (44, 36, 237.0, '17/01/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (45, 35, 134.6, '03/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (46, 10, 56.17, '29/05/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (47, 5, 189.8, '09/01/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (48, 357, 54.51, '20/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (49, 121, 87.97, '16/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (50, 107, 71.77, '28/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (51, 248, 245.6, '16/05/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (52, 215, 127.3, '02/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (53, 384, 264.1, '19/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (54, 86, 58.16, '24/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (55, 81, 246.6, '08/08/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (56, 307, 139.2, '10/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (57, 16, 297.1, '24/01/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (58, 109, 397.3, '11/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (59, 40, 273.2, '17/03/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (60, 330, 109.1, '14/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (61, 304, 110.5, '09/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (62, 119, 290.7, '26/03/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (63, 181, 368.9, '06/05/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (64, 122, 313.0, '14/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (65, 340, 366.4, '16/02/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (66, 166, 288.7, '28/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (67, 363, 72.03, '13/07/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (68, 179, 424.7, '19/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (69, 322, 350.8, '03/09/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (70, 191, 245.0, '26/06/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (71, 347, 387.0, '07/03/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (72, 190, 499.6, '21/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (73, 268, 180.2, '04/11/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (74, 296, 91.39, '24/05/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (75, 285, 490.5, '25/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (76, 302, 304.6, '12/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (77, 186, 277.1, '30/03/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (78, 115, 245.5, '14/03/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (79, 140, 455.9, '18/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (80, 318, 204.9, '20/01/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (81, 221, 378.1, '22/03/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (82, 39, 105.6, '25/10/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (83, 278, 78.42, '29/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (84, 240, 158.9, '14/11/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (85, 3, 168.4, '24/02/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (86, 314, 63.13, '10/04/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (87, 262, 479.1, '09/01/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (88, 400, 359.4, '10/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (89, 231, 496.3, '26/09/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (90, 112, 434.4, '04/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (91, 265, 257.5, '23/08/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (92, 103, 218.7, '27/03/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (93, 206, 360.1, '11/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (94, 76, 83.50, '15/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (95, 89, 148.4, '17/05/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (96, 21, 393.2, '21/08/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (97, 167, 467.0, '12/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (98, 60, 441.7, '06/01/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (99, 380, 184.9, '10/05/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (100, 282, 200.8, '19/11/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (101, 22, 328.5, '21/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (102, 182, 256.1, '16/05/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (103, 331, 113.8, '28/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (104, 297, 418.4, '28/08/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (105, 11, 451.4, '30/03/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (106, 335, 418.7, '01/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (107, 291, 370.0, '05/09/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (108, 79, 121.8, '25/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (109, 306, 296.5, '24/09/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (110, 350, 328.6, '29/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (111, 51, 323.7, '18/11/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (112, 35, 126.4, '26/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (113, 288, 368.2, '22/06/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (114, 104, 113.9, '26/04/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (115, 270, 66.86, '14/05/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (116, 181, 442.6, '18/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (117, 30, 60.86, '12/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (118, 147, 453.8, '10/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (119, 318, 174.6, '27/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (120, 131, 175.3, '25/11/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (121, 201, 163.2, '30/09/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (122, 150, 266.0, '08/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (123, 282, 276.2, '21/09/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (124, 145, 132.9, '04/10/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (125, 94, 380.9, '22/06/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (126, 308, 361.6, '28/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (127, 237, 492.1, '28/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (128, 130, 72.41, '25/03/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (129, 143, 411.4, '05/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (130, 389, 461.5, '10/05/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (131, 399, 169.9, '19/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (132, 331, 395.0, '18/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (133, 293, 173.4, '11/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (134, 248, 141.4, '26/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (135, 11, 111.3, '16/08/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (136, 182, 330.4, '18/07/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (137, 120, 451.9, '14/02/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (138, 321, 67.22, '04/07/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (139, 388, 395.5, '07/04/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (140, 43, 390.7, '24/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (141, 129, 251.6, '22/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (142, 140, 162.0, '15/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (143, 226, 395.8, '16/09/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (144, 37, 166.3, '26/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (145, 169, 203.2, '13/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (146, 266, 144.4, '22/08/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (147, 217, 417.5, '26/02/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (148, 344, 56.51, '08/08/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (149, 394, 486.2, '15/02/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (150, 81, 405.7, '28/01/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (151, 94, 405.5, '02/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (152, 148, 239.0, '12/03/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (153, 248, 121.2, '29/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (154, 338, 367.3, '15/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (155, 243, 411.1, '20/06/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (156, 396, 478.3, '03/01/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (157, 46, 421.5, '04/05/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (158, 14, 133.0, '01/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (159, 323, 379.2, '02/11/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (160, 240, 413.0, '25/06/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (161, 307, 436.2, '24/02/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (162, 57, 295.2, '05/11/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (163, 19, 362.6, '17/08/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (164, 373, 151.8, '03/01/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (165, 349, 340.2, '20/06/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (166, 267, 417.5, '01/04/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (167, 39, 167.7, '03/11/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (168, 238, 236.5, '24/02/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (169, 232, 249.0, '15/12/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (170, 376, 171.3, '25/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (171, 74, 231.6, '16/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (172, 209, 416.5, '06/02/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (173, 274, 127.1, '20/08/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (174, 231, 441.0, '16/07/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (175, 169, 265.0, '07/01/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (176, 178, 327.7, '05/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (177, 116, 270.2, '28/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (178, 372, 469.7, '23/05/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (179, 92, 276.1, '31/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (180, 2, 213.2, '20/07/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (181, 315, 445.2, '27/01/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (182, 294, 142.4, '05/06/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (183, 345, 471.6, '25/05/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (184, 133, 394.4, '12/03/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (185, 46, 362.5, '21/04/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (186, 151, 492.2, '16/03/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (187, 210, 190.6, '22/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (188, 81, 407.7, '04/02/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (189, 132, 211.0, '02/04/2019', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (190, 167, 424.8, '18/11/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (191, 54, 307.6, '13/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (192, 209, 144.7, '11/12/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (193, 61, 284.1, '12/08/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (194, 255, 441.8, '06/03/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (195, 335, 405.9, '08/06/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (196, 202, 356.0, '16/10/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (197, 170, 110.5, '24/08/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (198, 168, 231.4, '03/07/2017', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (199, 114, 186.7, '09/03/2018', 'AG');
insert into parcelas (par_codigo, com_codigo, par_valor, par_data, par_status) values (200, 141, 286.3, '29/01/2019', 'AG');











/*CONSULTAS*/

/*
1) Listar, em ordem decrescente, o código, o nome, e a avaliação média dos 10 cursos mais bem avaliados da plataforma; 
*/
CREATE OR REPLACE VIEW vw_avaliacaocurso AS
SELECT cur_codigo, ROUND(AVG(itc_avaliacao),1) AS cur_avaliacao
FROM itemcompra
GROUP BY cur_codigo
ORDER BY cur_avaliacao DESC
WITH READ ONLY;

SELECT cur.cur_codigo, cur.cur_titulo, vw.cur_avaliacao
FROM curso cur 
INNER JOIN vw_avaliacaocurso vw
ON cur.cur_codigo = vw.cur_codigo
WHERE ROWNUM <= 10
ORDER BY vw.cur_avaliacao DESC;

/*
2) Listar, em ordem crescente, o código, o nome e a avaliação média de todos os cursos cuja avaliação está abaixo da média geral;
*/
CREATE OR REPLACE VIEW vw_avaliacaocurso AS
SELECT cur_codigo, ROUND(AVG(itc_avaliacao),1) AS cur_avaliacao
FROM itemcompra
GROUP BY cur_codigo
ORDER BY cur_avaliacao DESC
WITH READ ONLY;

SELECT cur.cur_codigo, cur.cur_titulo, vw.cur_avaliacao
FROM curso cur 
INNER JOIN vw_avaliacaocurso vw
ON cur.cur_codigo = vw.cur_codigo
WHERE vw.cur_avaliacao < (SELECT AVG(cur_avaliacao) FROM vw_avaliacaocurso)
ORDER BY vw.cur_avaliacao ASC;

/*
3) Listar, em ordem decrescente, o código, o nome e a quantidade de vendas dos 10 cursos mais vendidos;
*/
CREATE OR REPLACE VIEW vw_vendacurso AS
SELECT cur_codigo, COUNT(cur_codigo) AS cur_qtdvendas
FROM itemcompra
GROUP BY cur_codigo
ORDER BY cur_qtdvendas DESC
WITH READ ONLY;

SELECT cur.cur_codigo, cur.cur_titulo, vw.cur_qtdvendas
FROM curso cur
INNER JOIN vw_vendacurso vw
ON cur.cur_codigo = vw.cur_codigo
WHERE ROWNUM <= 10 
ORDER BY vw.cur_qtdvendas DESC;

/*
4) Listar o valor obtido com a venda de cursos, por trimestre, no ano de 2019;
*/
SELECT CASE WHEN EXTRACT(MONTH FROM com.com_data) in (1,2,3) THEN 'Primeiro'
            WHEN EXTRACT(MONTH FROM com.com_data) in (4,5,6) THEN 'Segundo'
            WHEN EXTRACT(MONTH FROM com.com_data) in (7,8,9) THEN 'Terceiro'
            WHEN EXTRACT(MONTH FROM com.com_data) in (10,11,12) THEN 'Quarto'
       END AS com_trimestre, 
       EXTRACT(YEAR FROM com.com_data) as com_ano, 
       SUM(CASE WHEN EXTRACT(MONTH FROM com.com_data) in (1,2,3) THEN itc.itc_valor 
                WHEN EXTRACT(MONTH FROM com.com_data) in (4,5,6) THEN itc.itc_valor 
                WHEN EXTRACT(MONTH FROM com.com_data) in (7,8,9) THEN itc.itc_valor 
                WHEN EXTRACT(MONTH FROM com.com_data) in (10,11,12) THEN itc.itc_valor 
           END) as com_total
FROM compra com 
INNER JOIN itemcompra itc
ON com.com_codigo = itc.com_codigo 
WHERE EXTRACT(YEAR FROM com.com_data) = 2019
GROUP BY CASE WHEN EXTRACT(MONTH FROM com.com_data) in (1,2,3) THEN 'Primeiro' 
                WHEN EXTRACT(MONTH FROM com.com_data) in (4,5,6) THEN 'Segundo' 
                WHEN EXTRACT(MONTH FROM com.com_data) in (7,8,9) THEN 'Terceiro' 
                WHEN EXTRACT(MONTH FROM com.com_data) in (10,11,12) THEN 'Quarto' END, 
                EXTRACT(YEAR FROM com.com_data);

/*
5) Listar o valor obtido com a venda de cursos, por semestre, nos ultimos 3 anos, cuja forma de pagamento utilizada foi cartão de crédito e a quantidade de parcelas foi maior que 1;
*/
SELECT CASE WHEN EXTRACT(MONTH FROM com.com_data) in (1,2,3,4,5,6) THEN 'Primeiro'
            WHEN EXTRACT(MONTH FROM com.com_data) in (7,8,9,10,11,12) THEN 'Segundo'           
       END AS com_semestre, 
       EXTRACT(YEAR FROM com.com_data) as com_ano, 
       SUM(CASE WHEN EXTRACT(MONTH FROM com.com_data) in (1,2,3,4,5,6) THEN itc.itc_valor 
                WHEN EXTRACT(MONTH FROM com.com_data) in (7,8,9,10,11,12) THEN itc.itc_valor
           END) as com_total
FROM compra com 
INNER JOIN itemcompra itc
ON com.com_codigo = itc.com_codigo 
WHERE EXTRACT(YEAR FROM com.com_data) in (2019,2018,2017) AND com.com_formapgto = 'CREDITO' AND com.com_parcelas > 1
GROUP BY CASE WHEN EXTRACT(MONTH FROM com.com_data) in (1,2,3,4,5,6) THEN 'Primeiro' 
                WHEN EXTRACT(MONTH FROM com.com_data) in (7,8,9,10,11,12) THEN 'Segundo' END, 
                EXTRACT(YEAR FROM com.com_data)
                ORDER BY EXTRACT(YEAR FROM com.com_data) DESC;

/*
6) Listar, em ordem decrescente, as formas de pagamento, a quantidade de compras que utilizaram elas para pagamento e a receita que cada uma gerou;
*/
SELECT com.com_formapgto, COUNT(com.com_formapgto), SUM(itc.itc_valor)
FROM itemcompra itc
INNER JOIN compra com
ON com.com_codigo = itc.com_codigo 
GROUP BY com.com_formapgto
ORDER BY SUM(itc.itc_valor);

/* 
7) Listar, em ordem decrescente, o código, o nome, a quantidade de cursos comprados e o valor gasto com a compra desses cursos, dos alunos no ano de 2019; 
*/ 
CREATE OR REPLACE VIEW vw_alunoqtdcurso AS
SELECT usu_codigo, COUNT(com_codigo) AS com_qtdcursos 
FROM compra 
GROUP BY usu_codigo 
ORDER BY COUNT(com_codigo) DESC 
WITH READ ONLY;

SELECT vw.usu_codigo, usu.usu_nome, vw.com_qtdcursos, SUM(itc.itc_valor)
FROM vw_alunoqtdcurso vw
INNER JOIN usuario usu
ON vw.usu_codigo = usu.usu_codigo
INNER JOIN compra com
ON usu.usu_codigo = com.usu_codigo
INNER JOIN itemcompra itc 
ON com.com_codigo = itc.com_codigo 
WHERE EXTRACT(YEAR FROM com.com_data) = 2019
GROUP BY vw.usu_codigo, usu.usu_nome, vw.com_qtdcursos
ORDER BY SUM(itc.itc_valor) DESC;

/*
8) Listar, em ordem decrescente, o código, o nome e a quantidade de cursos vendidos pelos instrutores;
*/
SELECT ins.usu_codigo, usu.usu_nome, vw.cur_qtdvendas
FROM vw_vendacurso vw
INNER JOIN curso cur
ON vw.cur_codigo = cur.cur_codigo
INNER JOIN instrutorcurso inc
ON cur.cur_codigo = inc.cur_codigo
INNER JOIN instrutor ins
ON inc.usu_codigo = ins.usu_codigo
INNER JOIN usuario usu
ON ins.usu_codigo = usu.usu_codigo
GROUP BY ins.usu_codigo, usu.usu_nome, vw.cur_qtdvendas
ORDER BY cur_qtdvendas DESC;

/*
9) Listar, em ordem decrescente, o código, o nome e a receita total obtida, por instrutor, com a venda de cursos;
*/
CREATE OR REPLACE VIEW vw_vendacurso AS
SELECT cur_codigo, COUNT(cur_codigo) AS cur_qtdvendas, SUM(itc_valor) AS cur_receita
FROM itemcompra
GROUP BY cur_codigo
ORDER BY cur_receita DESC
WITH READ ONLY;

SELECT ins.usu_codigo, usu.usu_nome, vw.cur_receita
FROM vw_vendacurso vw
INNER JOIN curso cur
ON vw.cur_codigo = cur.cur_codigo
INNER JOIN instrutorcurso inc
ON cur.cur_codigo = inc.cur_codigo
INNER JOIN instrutor ins
ON inc.usu_codigo = ins.usu_codigo
INNER JOIN usuario usu
ON ins.usu_codigo = usu.usu_codigo
GROUP BY ins.usu_codigo, usu.usu_nome, vw.cur_receita
ORDER BY cur_receita DESC;

/*
10) Listar, em ordem crescente, o código, o nome e a média de vendas de todos os instrutores que venderam menos do que a média geral;
*/
SELECT ins.usu_codigo, usu.usu_nome, ROUND(AVG(vw.cur_qtdvendas),0) 
FROM vw_vendacurso vw
INNER JOIN curso cur
ON vw.cur_codigo = cur.cur_codigo
INNER JOIN instrutorcurso inc
ON cur.cur_codigo = inc.cur_codigo
INNER JOIN instrutor ins
ON inc.usu_codigo = ins.usu_codigo
INNER JOIN usuario usu
ON ins.usu_codigo = usu.usu_codigo
GROUP BY ins.usu_codigo, usu.usu_nome
HAVING AVG(vw.cur_qtdvendas) < (SELECT AVG(cur_qtdvendas) FROM vw_vendacurso)
ORDER BY AVG(vw.cur_qtdvendas) ASC;

/*
11) Listar, em ordem crescente, o código, o nome e a média de avaliação de todos os instrutores cuja média de avaliação seja menor que a média geral;
*/
SELECT ins.usu_codigo, usu.usu_nome, ROUND(AVG(vw.cur_avaliacao),1) 
FROM vw_avaliacaocurso vw
INNER JOIN curso cur
ON vw.cur_codigo = cur.cur_codigo
INNER JOIN instrutorcurso inc
ON cur.cur_codigo = inc.cur_codigo
INNER JOIN instrutor ins
ON inc.usu_codigo = ins.usu_codigo
INNER JOIN usuario usu
ON ins.usu_codigo = usu.usu_codigo
GROUP BY ins.usu_codigo, usu.usu_nome
HAVING AVG(vw.cur_avaliacao) < (SELECT AVG(cur_avaliacao) FROM vw_avaliacaocurso)
ORDER BY AVG(vw.cur_avaliacao)  ASC;

/*
12) Listar, em ordem alfabética, o código e o nome de todos os instrutores, e a quantidade  de cursos que eles ministraram aulas nas categorias
*/
SELECT inc.usu_codigo, usu.usu_nome, cat.cat_nome, COUNT(cat.cat_codigo)
FROM usuario usu
INNER JOIN instrutorcurso inc
ON usu.usu_codigo = inc.usu_codigo
INNER JOIN curso cur
ON inc.cur_codigo = cur.cur_codigo
INNER JOIN categoria cat
ON cur.cat_codigo = cat.cat_codigo 
GROUP BY usu.usu_nome, cat.cat_nome, inc.usu_codigo
ORDER BY usu.usu_nome;

/*
13) Listar, em ordem decrescente, o código, o nome, e a quantidade de aulas dos cursos; 
*/
SELECT cur.cur_codigo, cur.cur_titulo, COUNT(aul.aul_codigo) AS cur_qtdaulas
FROM curso cur
LEFT JOIN modulo mod
ON cur.cur_codigo = mod.cur_codigo
LEFT JOIN aula aul
ON mod.mod_codigo = aul.mod_codigo
GROUP BY cur.cur_codigo, cur.cur_titulo
ORDER BY cur_qtdaulas DESC;

/*
14) Listar, em ordem decrescente, o código e o nome da categoria e a quantidade de cursos que ela possui;
*/
SELECT cat.cat_codigo, cat.cat_nome, COUNT(cur.cat_codigo)
FROM categoria cat
INNER JOIN curso cur
ON cat.cat_codigo = cur.cat_codigo
GROUP BY cat.cat_codigo, cat.cat_nome
ORDER BY COUNT(cur.cat_codigo) DESC;

/*
15) Listar, em ordem decrescente, o código, o nome e a quantidade de anexos disponibilizados pelos instrutores;
*/
SELECT ins.usu_codigo, usu.usu_nome, cur.cur_codigo, COUNT(ane.aul_codigo)
FROM usuario usu
INNER JOIN instrutor ins
ON ins.usu_codigo = usu.usu_codigo
INNER JOIN instrutorcurso inc
ON ins.usu_codigo = inc.usu_codigo
INNER JOIN curso cur
ON inc.cur_codigo = cur.cur_codigo
LEFT JOIN modulo mod
ON cur.cur_codigo = mod.cur_codigo
LEFT JOIN aula aul
ON mod.mod_codigo = aul.mod_codigo
LEFT JOIN anexo ane
ON aul.aul_codigo = ane.aul_codigo 
GROUP BY ins.usu_codigo, usu.usu_nome, cur.cur_codigo
ORDER BY COUNT(ane.aul_codigo) DESC;


/*TRIGGER*/

CREATE OR REPLACE TRIGGER valida_parcelas
BEFORE UPDATE ON Compra 
FOR EACH ROW
BEGIN
    IF UPDATING THEN
        IF :OLD.com_status != :NEW.com_status THEN
            IF :NEW.com_status = 'CN' THEN
                UPDATE parcelas
                SET par_status = 'CN'
                WHERE com_codigo = :OLD.com_codigo;
            END IF;           
        END IF;        
    END IF;    
END valida_parcelas;