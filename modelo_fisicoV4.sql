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

CREATE TABLE instrutor(
    usu_codigo NUMBER(5),
    ins_documento VARCHAR2(30) NOT NULL,    
    
    CONSTRAINT pk_ins_usu_codigo PRIMARY KEY(usu_codigo),
    CONSTRAINT fk_ins_usu_codigo FOREIGN KEY(usu_codigo) REFERENCES usuario(usu_codigo),    
    CONSTRAINT uq_ins_documento UNIQUE(ins_documento)
);

insert into instrutor (usu_codigo, ins_documento) values (51, '55312-020');
insert into instrutor (usu_codigo, ins_documento) values (52, '44237-016');
insert into instrutor (usu_codigo, ins_documento) values (53, '55154-9391');
insert into instrutor (usu_codigo, ins_documento) values (54, '0069-3120');
insert into instrutor (usu_codigo, ins_documento) values (55, '52125-226');
insert into instrutor (usu_codigo, ins_documento) values (56, '42043-142');
insert into instrutor (usu_codigo, ins_documento) values (57, '59726-025');
insert into instrutor (usu_codigo, ins_documento) values (58, '37000-845');
insert into instrutor (usu_codigo, ins_documento) values (59, '36987-3139');
insert into instrutor (usu_codigo, ins_documento) values (60, '63148-215');

CREATE TABLE aluno(
    usu_codigo NUMBER(5),
    alu_matricula VARCHAR2(30) NOT NULL,
    
    CONSTRAINT pk_alu_usu_codigo PRIMARY KEY(usu_codigo),
    CONSTRAINT fk_alu_usu_codigo FOREIGN KEY(usu_codigo) REFERENCES usuario(usu_codigo),
    CONSTRAINT uq_alu_matricula UNIQUE(alu_matricula)
);

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
insert into aluno (usu_codigo, alu_matricula) values (48, '59779-590');
insert into aluno (usu_codigo, alu_matricula) values (49, '63777-204');
insert into aluno (usu_codigo, alu_matricula) values (50, '49999-797');

CREATE TABLE categoria(
    cat_codigo NUMBER(5),
    cat_nome VARCHAR2(50) NOT NULL,
    cat_descricao VARCHAR2(255),
    cat_status CHAR(1) NOT NULL,
    
    CONSTRAINT pk_cat_codigo PRIMARY KEY(cat_codigo),
    CONSTRAINT ck_cat_status CHECK(cat_status in('A','I'))
);

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

CREATE TABLE instrutorcurso(
    usu_codigo NUMBER(5),
    cur_codigo NUMBER(5),
    
    CONSTRAINT pk_inc_codigo PRIMARY KEY(usu_codigo, cur_codigo),
    CONSTRAINT fk_inc_cur_codigo FOREIGN KEY(cur_codigo) REFERENCES curso(cur_codigo),
    CONSTRAINT fk_inc_uso_codigo FOREIGN KEY(usu_codigo) REFERENCES usuario(usu_codigo)
);

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

insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (1, 1, 'Apostila 1', 'Bacteremia', '/vel/ipsum/praesent/blandit/lacinia/erat.html', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (2, 2, 'Apostila 1', 'Gambling and betting', '/risus/auctor.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (3, 3, 'Apostila 1', 'Exfl d/t eryth 80-89 bdy', '/cras/non/velit/nec/nisi.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (4, 4, 'Apostila 1', 'Taeniasis NOS', '/eget/orci/vehicula/condimentum/curabitur/in/libero.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (5, 5, 'Apostila 1', 'Tubal ligation status', '/nisl/aenean/lectus/pellentesque/eget/nunc.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (6, 6, 'Apostila 1', 'Ob trauma NEC-del w p/p', '/sit/amet/eleifend/pede/libero/quis/orci.png', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (7, 7, 'Apostila 1', 'Cicatricial entropion', '/maecenas/ut/massa/quis/augue.jpg', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (8, 8, 'Apostila 1', 'Food pois: v. parahaem', '/a/libero/nam/dui/proin/leo.json', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (9, 9, 'Apostila 1', 'Venomous bite/sting NOS', '/ipsum/ac.png', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (10, 10, 'Apostila 1', 'Submers NEC-crew', '/vestibulum/proin/eu/mi/nulla/ac/enim.aspx', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (11, 11, 'Apostila 1', 'Ascending colon inj-open', '/quisque.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (13, 2, 'Apostila 2', 'Inf mcrg rstn sulfnmides', '/consequat/dui.xml', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (14, 5, 'Apostila 2', 'Ca in situ fem gen NEC', '/in/magna/bibendum/imperdiet.js', 'A');
insert into anexo (ANE_CODIGO, AUL_CODIGO, ANE_TITULO, ANE_COMENTARIO, ANE_LINK, ANE_STATUS) values (15, 13, 'Apostila 1', 'Cl skull fx NEC-brf coma', '/eu.html', 'A');

CREATE TABLE compra(
    com_codigo NUMBER(5),
    usu_codigo NUMBER(5),
    com_data DATE NOT NULL,
    com_formapgto VARCHAR2(30) NOT NULL,
    com_parcelas NUMBER(2) NOT NULL,
    com_status CHAR(2) NOT NULL,
    
    CONSTRAINT pk_com_codigo PRIMARY KEY(com_codigo),
    CONSTRAINT fk_com_usu_codigo FOREIGN KEY(usu_codigo) REFERENCES aluno(usu_codigo),
    CONSTRAINT ck_com_status CHECK(com_status in('AG','PG'))
);

CREATE TABLE itemcompra(    
    cur_codigo NUMBER(5),
    com_codigo NUMBER(5),
    itc_avaliacao NUMBER(1),
    itc_valor NUMBER(10,2),
    
    CONSTRAINT pk_itc_codigo PRIMARY KEY(cur_codigo, com_codigo),
    CONSTRAINT fk_itc_cur_codigo FOREIGN KEY(cur_codigo) REFERENCES curso(cur_codigo),
    CONSTRAINT fk_itc_com_codigo FOREIGN KEY(com_codigo) REFERENCES compra(com_codigo)  
);

/*Compra 1*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(1,1,'25/05/2019','Crédito',1,'AG');
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(1,1,4,150);
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(2,1,4,130);    

/*Compra 2*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(2,2,'11/04/2019','Débito',1,'AG');
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(2,2,4,130);
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(3,2,4,90);    

/*Compra 3*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(3,3,'08/03/2019','Boleto',1,'AG');
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(5,3,5,200);

/*Compra 4*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(4,4,'01/03/2019','Débito',1,'AG');
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(5,4,5,200);
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(3,4,5,90);

/*Compra 5*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(5,5,'02/02/2019','Crédito',2,'AG');
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(1,5,5,150);
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(2,5,3,130);
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(3,5,4,90);
    insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
    values(4,5,5,70);    

CREATE TABLE parcelas(
    par_codigo NUMBER(5),
    com_codigo NUMBER(5),
    par_valor NUMBER(10,2) NOT NULL,
    par_status CHAR(2) NOT NULL,
    
    CONSTRAINT pk_par_codigo PRIMARY KEY(par_codigo, com_codigo),/*Coloquei parcelas com chave composta*/
    CONSTRAINT fk_par_com_codigo FOREIGN KEY(com_codigo) REFERENCES compra(com_codigo),
    CONSTRAINT ck_par_status CHECK(par_status in('AG','PG'))
);

insert into parcelas(par_codigo, com_codigo, par_valor, par_status) 
values(1,1,280,'AG');
insert into parcelas(par_codigo, com_codigo, par_valor, par_status) 
values(1,2,220,'AG');
insert into parcelas(par_codigo, com_codigo, par_valor, par_status) 
values(1,3,200,'AG');
insert into parcelas(par_codigo, com_codigo, par_valor, par_status) 
values(1,4,290,'AG');
insert into parcelas(par_codigo, com_codigo, par_valor, par_status) 
values(1,5,220,'AG');
insert into parcelas(par_codigo, com_codigo, par_valor, par_status) 
values(2,5,220,'AG');

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
SELECT cur.cur_codigo, cur.cur_titulo, vw.cur_avaliacao
FROM curso cur 
INNER JOIN vw_avaliacaocurso vw
ON cur.cur_codigo = vw.cur_codigo
WHERE vw.cur_avaliacao < (SELECT AVG(cur_avaliacao) FROM vw_avaliacaocurso)
ORDER BY vw.cur_avaliacao;

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
5) Listar as formas de pagamento, a quantidade de compras que utilizaram elas para pagamento e a receita que cada forma de pagamento gerou;
*/

/*
6) Listar o código, o nome e a quantidade de cursos comprados, em ordem decrescente, dos 10 alunos que mais compraram cursos no ano de 2019;
*/

/*
7) Listar o código e o nome de todos os alunos, as 3 categorias de cursos mais comprados e a quantidade de cursos de cada categoria que eles compraram;
*/

/*
8) Listar, em ordem decrescente, o código, o nome e a quantidade de cursos vendidos dos 10 instrutores que mais venderam cursos no ano de 2019;
*/

/*
9) Listar a receita total obtida, por instrutor, com a venda de cursos no ano de 2019;
*/

/*
10) Listar o código e o nome de todos os instrutores que venderam menos do que a média geral no ano de 2019;
*/

/*
11) Listar de todos os instrutores;
*/

/*
12) Listar o código, o nome e a média de avaliação de todos os instrutores cuja média de avaliação seja menor que a média geral;
*/

/*
13) Listar o código e o nome de todos os instrutores, a categoria de cursos que eles mais ministraram aulas e a quantidade de cursos ministrados dessa categoria;
*/

/*
14) Listar o código e o nome dos 10 instrutores que mais disponibilizaram anexos em suas aulas;
*/

/*
15) Listar o código e o nome do instrutor e a quantidade de cursos vendidos cuja forma de pagamento utilizada foi cartão de crédito.
*/


