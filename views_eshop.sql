-- a. Consultar todos os produtos existentes na loja;

select name from product;

-- b. Consultar os nomes de todos os usuários;

select name from users;

-- c. Consultar as lojas que vendem produtos;

select name from store;

-- d. Consultar os endereços relacionando com os clientes;

show columns from address;

select name, streetaddr from address;

-- e. Consultar todos os produtos do tipo laptop;

select * from product where type = "laptop";

-- f. Consultar o endereço, hora de inicio (start time) e hora final 
-- (end time) dos pontos de serviço damesma cidade que o usuário cujo ID é 5.

select
	s.startTime,
    s.endTime,
    s.streetAddr
from service_point s
join users on pk_userid = 5;

-- g. Consultar a quantidade total de produtos que foram colocados no carrinho (shopping cart),
-- considerando a loja com ID (sid) igual a 8.

select
	st.name,
    sum(s.quantity) as quantidade
from save_to_shopping_cart s
join product as p on s.pk_pid = p.pk_pid
join store st on p.fk_sid = st.sid
where st.sid = 8
group by st.name;

-- h.Consultar os comentários do produto 123456789. 
select * from comments;

select 
	p.pk_pid,
    c.content
from product p
join comments c
where pk_pid = 123456789;