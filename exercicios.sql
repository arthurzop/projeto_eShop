-- 1. Selecionar todos os produtos:
SELECT name FROM product;
-- aparece todos os produtos.


-- 2. Selecionar o nome de todos os usuários:
SELECT name FROM users;
-- aparece todos os nomes dos usuarios.


-- 3. Retornar todos os conteudos dos comentarios dos produtos:
SELECT content FROM comments;
-- aparece todos os comentarios. 


-- 4. Qual o endereço do usuário cujo ID é 21:
show columns from address;
show columns from users;

SELECT * FROM address WHERE fk_userid = 21;
-- '88', '21', 'Kitra N. Cabrera', '265-914-8426', 'New Brunswick', 'Campbellton', 'P.O. Box 268, 4081 Suspendisse Street', 'E2J 3G6'
-- '2', '21', 'Rae R. Lara', '495-472-7273', 'Ontario', 'St. Catharines', '5836 Iaculis Avenue', 'L7M 2V6'


-- 5. Qual o endereço da loja com o ID 39.
show columns from store;

SELECT province, city, streetAddr FROM store WHERE sid = 39;
-- 'Quebec', 'Montreal', 'No.1023 St-Catherine'


-- 6. Os pedidos com ID 74892932 e ID 84821231 foram pagos?
show columns from orders;

SELECT paymentState FROM orders WHERE pk_orderNumber = 74892932; 
-- UnPaid

SELECT paymentState FROM orders WHERE pk_orderNumber = 84821231; 
-- Paid

-- -----------------------------------------------------------
