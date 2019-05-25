
/*Compra 1*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA,COM_SUBTOTAL, COM_DESCONTO, COM_TOTAL, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(1,1,'25/05/2019',0,0,0, 'Crédito', 1,'AG');

	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(1,1,4,150);


	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(2,1,4,130);


	update compra set COM_SUBTOTAL = 
		(select SUM(ITC_VALOR) 
			from itemcompra where COM_CODIGO = 1) where COM_CODIGO = 1;






/*Compra 2*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA,COM_SUBTOTAL, COM_DESCONTO, COM_TOTAL, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(2,2,'11/04/2019',0,0,0, 'Débito', 1,'AG');


	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(2,2,4,130);


	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(3,2,4,90);

	update compra set COM_SUBTOTAL = 
		(select SUM(ITC_VALOR) 
			from itemcompra where COM_CODIGO = 2)  where COM_CODIGO = 2;



/*Compra 3*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA,COM_SUBTOTAL, COM_DESCONTO, COM_TOTAL, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(3,3,'08/03/2019',0,0,0, 'Boleto', 1,'AG');

	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(5,3,5,200);

	update compra set COM_SUBTOTAL = 
		(select SUM(ITC_VALOR) 
			from itemcompra where COM_CODIGO = 3) where COM_CODIGO = 3;



/*Compra 4*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA,COM_SUBTOTAL, COM_DESCONTO, COM_TOTAL, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(4,4,'01/03/2019',0,0,0, 'Débito', 1,'AG');

	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(5,4,5,200);

	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(3,4,5,90);

	update compra set COM_SUBTOTAL = 
		(select SUM(ITC_VALOR) 
			from itemcompra where COM_CODIGO = 4) where COM_CODIGO = 4;


/*Compra 5*/
insert into compra (COM_CODIGO, USU_CODIGO, COM_DATA,COM_SUBTOTAL, COM_DESCONTO, COM_TOTAL, COM_FORMAPGTO, COM_PARCELAS, COM_STATUS)
values(5,5,'02/02/2019',0,0,0, 'Crédito', 2,'AG');

	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(1,5,5,150);

	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(2,5,3,130);


	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(3,5,4,90);

	insert into itemcompra(CUR_CODIGO, COM_CODIGO, ITC_AVALIACAO, ITC_VALOR)
	values(4,5,5,70);

	update compra set COM_SUBTOTAL = 
		(select SUM(ITC_VALOR) 
			from itemcompra where COM_CODIGO = 5) where COM_CODIGO = 5;