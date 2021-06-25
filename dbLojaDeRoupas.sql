drop database if exists dbLojaDeRoupas;
Create database dbLojaDeRoupas;
Use dbLojaDeRoupas;



CREATE TABLE tbGerente (
    Codigo INT AUTO_INCREMENT,
    Nome VARCHAR(70) NOT NULL,
    Ano_nasc DATE NOT NULL,
    Endereco VARCHAR(50) NOT NULL,
    CPF VARCHAR(11) NOT NULL,
    RG VARCHAR(12) NOT NULL,
    PRIMARY KEY (Codigo)
);

INSERT INTO tbGerente (Codigo, Nome, Ano_nasc, Endereco, CPF, RG)
Values (01, "Ana", '1984-02-26', "Rua Antoneli N° 34", 46642189501, 555123321456),
	   (02 , "Carlos", '2000-06-04', "Rua Catapimbas N° 35", 32569845871, 205691021354),
	   (03, "Rodrigo", '1960-10-10', "Rua Terra do Nunca N° 64", 17259200855,965874123652),
       (04, "Fernanda", '2002-01-14', "Rua Por do Sol N° 123", 78956432014, 055211498603),
       (05, "João", '1997-05-30', "Rua Potter N° 934", 41258701236, 147852369852);
       
create table TelGerente( /*Tabela Telefone é uma entidade fraca*/
Telefone varchar(14) not null,
Cod_Gerente int references tbGerente(Codigo) on update cascade on delete cascade
);

INSERT INTO TelGerente(Telefone, Cod_Gerente)
Value (11993645123, 01),
	  (11935168465, 02),
      (11935665216, 03),
      (11931631555, 04),
      (11996898795, 05);




create table tbFuncionario(
Codigo int auto_increment primary key,
Nome varchar (70) NOT NULL,
Endereco varchar(50)NOT NULL,
CPF varchar(11) NOT NULL,
RG varchar (12) NOT NULL,
Ano_nasc date Not Null,
Codigo_Gerente int references tbGerente (Codigo) on update cascade on delete cascade
);

create table TelFuncionario( /*Tabela Telefone é uma entidade fraca*/
Telefone varchar(14) not null,
Cod_Funcionario int references tbFuncionario(Codigo) on update cascade on delete cascade
);
INSERT INTO tbFuncionario (Codigo, Nome, Endereco, CPF, RG, Ano_nasc, Codigo_Gerente)
Value (01, "Kleber", "Rua saco cheio N° 24",12345678912, 0123654852012,'1977-05-24', 01),
	  (02,"Andre" ,"Rua muito trabalho N° 45" ,36519753260 ,035987654301 , '1998-05-15',02),
      (03,"Joana" ,"Rua socorro N° 90" ,03512478451 ,014785202014 , '1980-08-24', 03),
      (04,"Amanda" ,"Rua pandemia N° 49" , 47956354210, 012457854870, '1990-11-24', 04),
      (05,"Pedro" ,"Rua Covide N° 19" ,23698765280 ,036985698745, '1970-05-24', 05);


INSERT INTO TelFuncionario(Telefone, Cod_Funcionario)
Value (11993645444, 01),
	  (11935168555, 02),
      (11935665777, 03),
      (11931631999, 04),
      (11996898000, 05);




Create table tbFornecedores(
Codigo int auto_increment primary key,
Empresa varchar(20) NOT NULL,
Contato varchar(13) NOT NULL,
CEP varchar (8) NOT NULL,
Gerente_contrato int references tbGerente(Codigo) on update cascade on delete cascade
);
 
 create table TelForn( /*Tabela Telefone é uma entidade fraca*/
Telefone varchar(14) not null,
Cod_Forn int references tbFornecedores(Codigo) on update cascade on delete cascade
);

INSERT INTO TelForn(Telefone, Cod_Forn)
Value (11988845444, 01),
	  (11900068555, 02),
      (11955565777, 03),
      (11022231999, 04),
      (11988898000, 05);

 
INSERT INTO tbFornecedores (Codigo, Empresa, Contato, CEP, Gerente_contrato)
Values(01, "CalçasBrasil", "Diego", 02169832, 1),
	  (02, "CamisasBrasil", "Diogo", 02147832, 2),
	  (03, "BlusasBrasil", "Marcelo", 36514832, 3),
      (04, "TenisBrasil", "Carol", 47801432, 4),
      (05, "BermudasBrasil", "Amanda", 36019832, 5);




create table tbEstoque(
Codigo int auto_increment primary key,
Nome_produto varchar(20) NOT NULL,
Quantidade_produto varchar(7) NOT NULL,
Tipo_produto varchar(20) NOT NULL,
Entrada Date NOT NULL,
Saida Date NOT NULL,
Forn_Abastece int references tbFornecedor(Codigo) on update cascade on delete cascade
);


INSERT INTO tbEstoque (Codigo, Nome_produto, Quantidade_produto, Tipo_produto, Entrada, Saida, Forn_Abastece)
Values (01, "Calças", 400, "Durável", '2020-04-12', '2020-05-10', 01),
	   (02, "Camisetas", 1000, "Durável", '2020-03-12', '2020-05-10', 02),
       (03, "Blusas", 200, "Durável", '2020-02-12', '2020-05-01', 03),
       (04, "Tenis", 16000, "Durável", '2020-05-12', '2020-05-25', 04),
       (05, "Bermudas", 790, "Durável", '2020-02-09', '2020-05-20', 05);







create table tbProduto(
Codigo int auto_increment primary key,
Nome varchar (20) Not Null,
Marca varchar (20) Not Null,
Descricao varchar (500),
Preco double Not Null,
Fornecedor int references tbFornecedor(Codigo) on update cascade on delete cascade
);

INSERT INTO tbProduto (Codigo, Nome, Marca, Descricao, Preco, Fornecedor)
Value (01, "Calça", "Kings", "Sem descrição", 100.0, 2),
	  (02, "Camiseta", "Nike", "Camiseta Feminina", 70.0, 5),
      (03, "Blusas", "Overcome", "Blusa Canguru Unisex", 200.0, 4),
      (04, "Tenis", "Mizuno", "Tenis Unisex",200.0, 3),
      (05, "Bermudas", "Adidas", "Bermuda Masculina",250.00, 1);

update tbProduto SET Descricao = "Calça Camuflada Unisex" where Codigo = 01;
Select Descricao from tbProduto;



create table tbGasto(
Codigo int auto_increment primary key,
Tipo varchar (20) NOT NULL,
Valor double NOT NULL,
Comeco date NOT NULL,
Vencimento date NOT NULL,
Codigo_Gerente int references tbGerente (Codigo) on update cascade on delete cascade
);

INSERT INTO tbGasto (Codigo, Tipo, Valor, Comeco, Vencimento, Codigo_Gerente)
Value(01,"Luz",100.0,'2020-01-01', '2020-02-01', 01),
	 (02,"Água", 80.0, '2020-01-01', '2020-02-01', 02),
     (03,"Água", 90.50, '2020-01-01', '2020-02-01', 03),
     (04,"Aluguél", 1000.0, '2020-01-01', '2020-02-01', 04),
     (05,"Internet", 80.0, '2020-01-01', '2020-02-01', 05);
 




create table tbCadastroCliente(
CPF varchar(11) NOT NULL primary key,  
Nome varchar (70) NOT NULL,
Endereco varchar(50)NOT NULL,                 
RG varchar (12) NOT NULL,
Telefone varchar (13) NOT NULL,
Ano_nasc date Not Null,
Email varchar (70) Not Null,
Func_Cad int references tbFuncionario (Codigo) on update cascade on delete cascade
);

INSERT INTO tbCadastroCliente(Nome, Endereco, CPF, RG, Telefone, Ano_nasc, Email, Func_Cad)
Value ("papi", "Rua saco cheio N° 24",12345698912, 0123654892012, 11998692145,'1979-05-29',"papi@email.com", 01 ),
	  ("Jose" ,"Rua muito trabalho N° 45" ,36519759260 ,035989654301 ,11956912358 , '1999-05-19'," jose@email.com", 02),
      ("Vagner" ,"Rua socorro N° 90" ,03512478491 ,014785202914 ,11301249789 ,'1989-08-29 ',"Vagner@email.com", 03),
      ("Andrews" ,"Rua pandemia N° 01" , 47959354210, 012459854870,119589698930 , '1999-11-29',"Andrews@email.com", 04 ),
      ("Pimposo" ,"Rua Covide N° 20" ,23698769280 ,036995698745 ,11999994712 ,'1979-05-24',"pimposo@email.com", 05);


      
create table  tbNotaFiscal(
Codigo int auto_increment primary key,
ValorTotal double NOT NULL,
CPF_Cli varchar(11) references tbCadastroCliente(CPF) on update cascade on delete cascade
);

INSERT INTO tbNotaFiscal(Codigo, ValorTotal, CPF_Cli) value
(01 ,100.0,12345698912 ),
(02 ,70.0, 36519759260 ),
(03 ,200.0, 03512478491 ),
(04 ,200.0, 47959354210),
(05 ,250.0, 23698769280);


create table tbPedido(
produto varchar (50) not null,
ValorProd double NOT NULL,
Codigo_NotaFiscal int references tbNotaFiscal(Codigo) on update cascade on delete cascade
);


INSERT INTO tbPedido (produto, ValorProd, Codigo_NotaFiscal) value
("Camiseta" ,100.0 ,01 ),
( "Blusa",70.0  ,02 ),	
("Calça" ,200.0 ,03 ),
("Meia" ,200.0 ,04 ),
("Bermuda" ,250.0 ,05 ); 



/*.............................................................SELECTS INNER JOIN 1 ....................................................................*/
select Telefone, Nome from TelGerente inner join tbGerente on Codigo = Cod_Gerente; -- Saber qual telefone pertence a tal gerente
select Telefone, Empresa from TelForn inner join tbFornecedores on Codigo = Cod_Forn; -- Saber qual telefone pertence a tal empresa
select Telefone, Nome from TelFuncionario inner join tbFuncionario on Codigo = Cod_Funcionario; -- Saber qual telefone pertence a tal Funcionárioj
select tbFuncionario.Nome, tbGerente.Nome from tbFuncionario inner join tbGerente on tbFuncionario.Codigo_Gerente = tbGerente.Codigo; -- Saber qual funcionário trabalho p tal gerente
select Empresa, Nome_Produto from tbFornecedores inner join tbEstoque on Forn_Abastece = tbFornecedores.Codigo; -- Saber quais empresas forneceu tal produto
/*......................................................................................................................................................*/

/*..............................................................SELECTS INNER JOIN 2 ...................................................................*/

select ft.Telefone, f.Nome, g.Nome from TelFuncionario ft inner join tbFuncionario f on f.Codigo = ft.Cod_Funcionario inner join tbGerente g on g.Codigo = f.Codigo_Gerente; -- Saber o número do funcionário e para qual gerente ele trabalha
select E.Quantidade_produto, F.Empresa, G.Nome from tbEstoque E inner join tbFornecedores F on E.Forn_Abastece = F.Codigo inner join tbGerente G on F.Gerente_contrato = G.Codigo; -- Saber a quantidade de um produto X, qual o fornecedor e qual o gerente que contratou
select  C.Nome, P.produto, N.ValorTotal from tbPedido P inner join tbNotaFiscal N on P.Codigo_NotaFiscal = N.Codigo inner join tbCadastroCliente C on C.CPF = CPF_Cli; -- Saber os produtos x que tal cliente comprou e o valor total
select C.Nome, F.Nome, G.Nome from tbCadastroCliente C inner join tbFuncionario F on C.Func_Cad = F.Codigo inner join tbGerente G on F.Codigo = G.Codigo; -- Saber o Funcionário que atendeu cliente x e qual seu gerente
select N.Codigo, C.Nome, F.Nome from tbNotaFiscal N inner join tbCadastroCliente C on N.CPF_Cli = C.CPF inner join tbFuncionario F on C.Func_Cad = F.Codigo; -- Saber o funcionário que atendeu tal cliente e o número da sua nota fiscal
/*......................................................................................................................................................*/

/*..............................................................SELECTS INNER JOIN 3 ...................................................................*/
select Telefone, Nome from TelGerente left join tbGerente on Codigo = Cod_Gerente; -- Saber qual telefone pertence a tal gerente
select Telefone, Empresa from TelForn left join tbFornecedores on Codigo = Cod_Forn; -- Saber qual telefone pertence a tal empresa
select Telefone, Nome from TelFuncionario left join tbFuncionario on Codigo = Cod_Funcionario; -- Saber qual telefone pertence a tal Funcionárioj
select tbFuncionario.Nome, tbGerente.Nome from tbFuncionario left join tbGerente on tbFuncionario.Codigo_Gerente = tbGerente.Codigo; -- Saber qual funcionário trabalho p tal gerente
select Empresa, Nome_Produto from tbFornecedores left join tbEstoque on Forn_Abastece = tbFornecedores.Codigo; -- Saber quais empresas forneceu tal produto
/*......................................................................................................................................................*/

/*..............................................................SELECTS INNER JOIN 4 ...................................................................*/
select space (ft.Telefone), f.Nome, g.Nome from TelFuncionario ft inner join tbFuncionario f on f.Codigo = ft.Cod_Funcionario left join tbGerente g on g.Codigo = f.Codigo_Gerente;  -- Saber o número do funcionário e para qual gerente ele trabalha
select E.Quantidade_produto, reverse (F.Empresa), G.Nome from tbEstoque E inner join tbFornecedores F on E.Forn_Abastece = F.Codigo left join tbGerente G on F.Gerente_contrato = G.Codigo; -- Saber a quantidade de um produto X, qual o fornecedor e qual o gerente que contratou
select  repeat (C.Nome, 7), P.produto, N.ValorTotal from tbPedido P inner join tbNotaFiscal N on P.Codigo_NotaFiscal = N.Codigo left join tbCadastroCliente C on C.CPF = CPF_Cli; -- Saber os produtos x que tal cliente comprou e o valor total
select WEIGHT_STRING (C.Nome), F.Nome, G.Nome from tbCadastroCliente C inner join tbFuncionario F on C.Func_Cad = F.Codigo left join tbGerente G on F.Codigo = G.Codigo; -- Saber o Funcionário que atendeu cliente x e qual seu gerente
select ascii (N.Codigo), C.Nome, F.Nome from tbNotaFiscal N inner join tbCadastroCliente C on N.CPF_Cli = C.CPF left join tbFuncionario F on C.Func_Cad = F.Codigo; -- Saber o funcionário que atendeu tal cliente e o número da sua nota fiscal
/*......................................................................................................................................................*/


select concat(Telefone, " - ", Nome )from TelGerente inner join tbGerente on Codigo = Cod_Gerente group by Nome; -- Busca o telefone e o nome do gerente e agrupa por nome
select Telefone, UPPER (Empresa) from TelForn inner join tbFornecedores on Codigo = Cod_Forn group by Codigo; -- Busca telefone e empresa e agrupa por código (No caso, o código não se repete)
select  Telefone,CHAR_LENGTH (Nome) from TelFuncionario inner join tbFuncionario on Codigo = Cod_Funcionario group by RG; -- Busca telefone e nome do funcionário e agrupa por RG (mesmo caso de cima, RG não se repete)
select lcase (tbFuncionario.Nome), tbGerente.Nome from tbFuncionario inner join tbGerente on tbFuncionario.Codigo_Gerente = tbGerente.Codigo group by tbFuncionario.CPF; -- Busca o nome dos funcionarios, seus respectivos gerentes e agrupa por CPF do funcionário (Como é 1:n, o CPF não se repete. Mas caso fosse o CPF do gerente, poderia acontecer de se repetir, tendo o agrupamento )
select LENGTH (Empresa), Nome_Produto from tbFornecedores inner join tbEstoque on Forn_Abastece = tbFornecedores.Codigo group by tbFornecedores.Empresa; -- Saber quais empresas forneceu tal produto, e agrupa pelo nome da empresa







Select * From tbPedido;
SELECT * FROM tbGerente;
SELECT ascii(Nome) FROM tbGerente;
SELECT CHAR_LENGTH(Nome) FROM tbGerente;
Show tables;


/* By: Gabriel Cerruti */ 