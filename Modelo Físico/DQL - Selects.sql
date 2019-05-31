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
4) Listar o valor obtido com a venda de cursos, por semestre, nos ultimos 3 anos, cuja forma de pagamento utilizada foi cartão de crédito e a quantidade de parcelas foi maior que 1;
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
                EXTRACT(YEAR FROM com.com_data);

/*
6) Listar, em ordem decrescente, as formas de pagamento, a quantidade de compras que utilizaram elas para pagamento e a receita que cada uma gerou;
*/
SELECT com.com_formapgto, COUNT(com.com_formapgto), SUM(itc.itc_valor)
FROM itemcompra itc
INNER JOIN compra com
ON com.com_codigo = itc.com_codigo 
GROUP BY com.com_formapgto, com.com_formapgto, itc.itc_valor
ORDER BY itc.itc_valor DESC;

/* 
7) Listar, em ordem decrescente, o código, o nome, a quantidade de cursos comprados e o valor gasto com a compra desses cursos, dos alunos que mais
compraram cursos no ano de 2019; 
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
SELECT ins.usu_codigo, usu.usu_nome, AVG(vw.cur_qtdvendas) 
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
SELECT ins.usu_codigo, usu.usu_nome, AVG(vw.cur_avaliacao) 
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
12) Listar, em ordem decrescente, o código e o nome de todos os instrutores, e a quantidade de categorias de cursos que eles mais ministraram aulas
*/
SELECT inc.usu_codigo, usu.usu_nome, COUNT(cat.cat_codigo)
FROM usuario usu
INNER JOIN instrutorcurso inc
ON usu.usu_codigo = inc.usu_codigo
INNER JOIN curso cur
ON inc.cur_codigo = cur.cur_codigo
INNER JOIN categoria cat
ON cur.cat_codigo = cat.cat_codigo 
GROUP BY inc.usu_codigo, usu.usu_nome
ORDER BY COUNT(cat.cat_codigo) DESC;

/*
13) Listar, em ordem decrescente, o código, o nome, e a quantidade de aulas dos cursos; 
*/
SELECT cur.cur_codigo, cur.cur_titulo, COUNT(aul.aul_codigo) AS cur_qtdaulas
FROM curso cur
INNER JOIN modulo mod
ON cur.cur_codigo = mod.cur_codigo
INNER JOIN aula aul
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
INNER JOIN modulo mod
ON cur.cur_codigo = mod.cur_codigo
INNER JOIN aula aul
ON mod.mod_codigo = aul.mod_codigo
INNER JOIN anexo ane
ON aul.aul_codigo = ane.aul_codigo 
GROUP BY ins.usu_codigo, usu.usu_nome, cur.cur_codigo
ORDER BY COUNT(ane.aul_codigo);