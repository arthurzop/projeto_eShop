-- LISTA DE EXERCICIOS 4
-- 1. Selecione todos os nomes e números de telefone dos usuários.
SELECT
	name as NOME,
    phoneNumber as TELEFONE
FROM users;

-- 2. Liste os nomes dos compradores.
SELECT 
	name AS NOME 
FROM users 
WHERE pk_userId IN (SELECT * FROM buyer); 

-- 3. Liste o nome dos vendedores 
SELECT 
	name, 
    phoneNumber
FROM users 
WHERE pk_userId IN (SELECT pk_userId FROM seller); 

-- 4 Encontre todas as informações de cartão de crédito dos usuários 
SELECT
-- colunas vindo da tabela bankcard
	bank.pk_cardNumber, 
    bank.expiryDate, 
    bank.bank,
    
-- essas são da tabela credito, pra fazer a junção

	credito.fk_userid, 
    credito.organization
FROM 
-- as informações dos cartões de crédito do cliente estão dentro da tabela creditcard, que faz referencia a tabela bankcard. Então 
-- para não ficar confuso, mudei o nome da bankcard para bank.

-- o join pega informações especificas das colunas de uma tabela e junta em outra. 
	bankcard AS bank
JOIN creditcard AS credito
ON bank.pk_cardNumberv= credito.pk_cardNumber; 


-- 4.2 Encontre todas as informações de cartão de débito dos usuários
SELECT 
    bank.pk_cardNumber,	
    bank.expiryDate,
    bank.bank,
    
    debito.fk_userId, 
    debito.organization
    
FROM 
	bankcard AS bank
JOIN debitcard AS debito
ON bank.pk_cardNumberv= debito.pk_cardNumber; 
    

