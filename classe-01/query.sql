CREATE DATABASE ecommerce;

CREATE TABLE produtos(
  id serial PRIMARY KEY,
  nome varchar(100) NOT NULL,
  descricao text,
  preco int NOT NULL,
  quantidade_em_estoque int NOT NULL,
  categoria_id int references categorias(id)
);

CREATE TABLE itens_do_pedido(
  id serial PRIMARY KEY,
  pedido_id int references pedidos(id),
  quantidade int NOT NULL,
  produto_id int references produtos(id)
);

CREATE TABLE categorias(
  id serial PRIMARY KEY,
  nome varchar(50) NOT NULL
);

CREATE TABLE pedidos(
  id serial PRIMARY KEY,
  valor int NOT NULL,
  cliente_cpf char(11) references clientes(cpf),
  vendedor_cpf char(11) references vendedores(cpf)
);

CREATE TABLE clientes(
  cpf char(11) NOT NULL UNIQUE PRIMARY KEY,
  nome varchar(150) NOT NULL
);

CREATE TABLE vendedores(
  cpf char(11) NOT NULL UNIQUE PRIMARY KEY,
  nome varchar(150) NOT NULL
);

INSERT INTO categorias(nome)
VALUES
('frutas'),
('verduras'),
('massas'),
('bebidas'),
('utilidades');

INSERT INTO produtos(nome, descricao, preco, quantidade_em_estoque, categoria_id)
VALUES
('Mamão', 'Rico em vitamina A, potássio e vitamina C', 300, 123, 1),
('Maça', 'Fonte de potássio e fibras', 90, 34, 1),
('Cebola', 'Rico em quercetina, antocianinas, vitaminas do complexo B, C.', 50, 76, 2),
('Abacate', 'NÃO CONTÉM GLÚTEN.', 150, 64, 1),
('Tomate', 'Rico em vitaminas A, B e C.', 125, 88, 2),
('Acelga', 'NÃO CONTÉM GLÚTEN.', 235, 13, 2),
('Macarrão parafuso', 'Sêmola de trigo enriquecida com ferro e ácido fólico, ovos e corantes naturais', 690, 5, 3),
('Massa para lasanha', 'Uma reunião de família precisa ter comida boa e muita alegria.', 875, 19, 3),
('Refrigerante coca cola lata', 'Sabor original', 350, 189, 4),
('Refrigerante Pepsi 2l', '	NÃO CONTÉM GLÚTEN. NÃO ALCOÓLICO.', 700, 12, 4),
('Cerveja Heineken 600ml', 'Heineken é uma cerveja lager Puro Malte, refrescante e de cor amarelo-dourado', 1200, 500, 4),
('Agua mineral sem gás', 'Smartwater é água adicionado de sais mineirais (cálcio, potássio e magnésio) livre de sódio e com pH neutro.', 130, 478, 4),
('Vassoura', 'Pigmento, matéria sintética e metal.', 2350, 30, 5),
('Saco para lixo', 'Reforçado para garantir mais segurança', 1340, 90, 5),
('Escova dental', 'Faça uma limpeza profunda com a tecnologia inovadora', 1000, 44, 5),
('Balde para lixo 50l', 'Possui tampa e fabricado com material reciclado', 2290, 55, 5),
('Manga', 'Rico em Vitamina A, potássio e vitamina C', 198, 176, 1),
('Uva', 'NÃO CONTÉM GLÚTEN.', 420, 90, 1);

INSERT INTO clientes(cpf, nome)
VALUES
('80371350042', 'José Augusto Silva'),
('67642869061', 'Antonio Oliveira'),
('63193310034', 'Ana Rodrigues'),
('75670505018', 'Maria da Conceição');

INSERT INTO vendedores(cpf, nome)
VALUES
('82539841031', 'Rodrigo Sampaio'),
('23262546003', 'Beatriz Souza Santos'),
('28007155023', 'Carlos Eduardo');

INSERT INTO pedidos(valor, cliente_cpf, vendedor_cpf)
VALUES
(9650, '80371350042', '28007155023'),
(6460, '63193310034', '23262546003'),
(4120, '75670505018', '23262546003'),
(9370, '75670505018', '82539841031'),
(8229, '67642869061', '82539841031');

INSERT INTO itens_do_pedido(pedido_id, quantidade, produto_id)
VALUES
(1, 1, 1),
(1, 1, 10),
(1, 6, 11),
(1, 1, 15),
(1, 5, 2),
(2, 10, 17),
(2, 3, 18),
(2, 5, 1),
(2, 10, 5),
(2, 2, 6),
(3, 1, 13),
(3, 6, 12),
(3, 5, 17),
(4, 1, 16),
(4, 6, 18),
(4, 1, 7),
(4, 3, 1),
(4, 20, 5),
(4, 2, 6),
(5, 8, 18),
(5, 1, 8),
(5, 3, 17),
(5, 8, 5),
(5, 2, 11);

SELECT produto_id, sum(quantidade) as total FROM itens_do_pedido
GROUP BY produto_id
ORDER BY produto_id ASC;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 9
WHERE id = 1;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 5
WHERE id = 2;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 38
WHERE id = 5;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 4
WHERE id = 6;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE id = 7;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE id = 8;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE id = 10;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 8
WHERE id = 11;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 6
WHERE id = 12;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE id = 13;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE id = 15;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 1
WHERE id = 16;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 18
WHERE id = 17;

UPDATE produtos
SET quantidade_em_estoque = quantidade_em_estoque - 17
WHERE id = 18;

SELECT produtos.nome as produto, categorias.nome as categoria FROM produtos
JOIN categorias ON produtos.categoria_id = categorias.id;

SELECT clientes.nome as cliente, vendedores.nome as vendedor FROM pedidos
JOIN clientes ON clientes.cpf = pedidos.cliente_cpf
JOIN vendedores ON vendedores.cpf = pedidos.vendedor_cpf;

SELECT categorias.nome as categorias, sum(produtos.quantidade_em_estoque) as estoque FROM produtos
JOIN categorias ON categorias.id = produtos.categoria_id
GROUP BY categorias.nome;

SELECT produtos.nome as produto, sum(itens_do_pedido.quantidade) as vendidos FROM itens_do_pedido
JOIN produtos ON produtos.id = itens_do_pedido.produto_id
GROUP BY produtos.nome
ORDER BY vendidos DESC;