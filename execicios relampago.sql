-- 1. Selecione todos os nomes e números de telefone dos usuários:
SHOW COLUMNS FROM users;

SELECT name, phoneNum FROM users;

-- 2. Liste os nomes dos compradores:
SELECT name FROM users WHERE pk_userid IN (SELECT pk_userid FROM buyer);

-- 3. Liste os nomes dos vendedores:
SHOW COLUMNS FROM seller;

SELECT name FROM users WHERE pk_userid IN (SELECT pk_userid FROM seller);

-- 4. Encontre todas as informações de cartão de crédito dos usuários:
SHOW COLUMNS FROM credit_card;

SELECT 
	b.pk_cardNumber,
    b.expiryDate,
    b.bank,
    c.fk_userid,
    c.organization
FROM bank_card AS b
JOIN credit_card AS c 
ON b.pk_cardNumber = c.pk_cardNumber;

-- 5. Selecione os nomes dos produtos e seus preços.
SHOW COLUMNS FROM product;

SELECT name, price FROM product;

-- 6. Liste todos os produtos de uma determinada marca (por exemplo,"Samsung").
SELECT * FROM product;

SELECT name, type, color FROM product WHERE fk_brand = "Microsoft";

-- 7. Encontre o número de itens em cada pedido.

SELECT 
	pk_orderNumber AS pedidos,
    SUM(quantity) AS quantidade
FROM
	contain
GROUP BY pk_orderNumber;

-- 8. Calcule o total de vendas por loja.

SELECT  
	s.name AS loja,
    SUM(o.price) AS valor_total
FROM store 	 AS s
JOIN product AS p ON s.sid = p.pk_pid
JOIN orderitem AS o ON p.pk_pid = o.fk_pid
GROUP BY s.name;

-- 9. Liste as avaliações dos produtos (grade) com seus nomes e conteúdo de usuário:
SHOW COLUMNS FROM comments;

SELECT grade, content FROM comments;

SELECT
	p.name,
    c.grade,
    c.content
FROM
	product AS p
JOIN
	comments AS c
ON
	p.pk_pid = c.fk_pid;

-- 10. Selecione os nomes dos compradores que fizeram pedidos.

show columns from buyer;
show columns from users;
show columns from bank_card;

SELECT name 
FROM users
WHERE pk_userid IN(
	SELECT 
		fk_userid 
	FROM 
		credit_card 
	WHERE 
		pk_cardNumber IN(
			SELECT 
				fk_cardNumber 
			FROM 
				payment 
			WHERE 
				fk_orderNumber IN(SELECT pk_orderNumber FROM orders)
	)
);

-- 11.Encontre os vendedores que gerenciam várias lojas.
show columns from manage;
show columns from seller;
show columns from users;

SELECT 
	u.name,
    COUNT(m.fk_sid) AS total
FROM users u
JOIN seller s ON u.pk_userid = s.pk_userid
JOIN manage m ON s.pk_userid = m.fk_userid
GROUP BY u.name 
HAVING total > 1;

-- 12.Liste os nomes das lojas que oferecem produtos de uma determinada marca (por exemplo, "Apple").
SELECT * FROM store;
SELECT * FROM product;

SELECT distinct s.sid, s.name
FROM store s
JOIN product p ON s.sid - p.fk_sid
WHERE p.fk_brand = "Microsoft";

-- 13.Encontre  as  informações  de  entrega  de  um  pedido  específico  (por exemplo, orderNumber = 12992012).
show columns from address;
show columns from deliver_to;
show columns from orders;

SELECT
	d.fk_orderNumber as ordem,
    a.name as nome,
    a.streetAddr as rua,
    a.contactPhoneNumber as numContato,
    a.city as cidade,
    a.postCode as codigoPostal
FROM deliver_to d
JOIN address a ON d.fk_addrid = a.pk_addrid
WHERE fk_orderNumber = 12992012;




