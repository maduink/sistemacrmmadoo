CREATE TABLE CLIENTE(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR (20) NOT NULL UNIQUE, 
    telefone VARCHAR (20),
    endereco VARCHAR (150) NOT NULL,
    segmento VARCHAR(50)
);

CREATE TABLE VENDEDOR(
	 id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
     nome VARCHAR (100) NOT NULL, 
     cargo VARCHAR (50), 
     telefone VARCHAR (20),
     email VARCHAR (100),
     comissao DECIMAL (5,2),
     carteira_ativa BOOLEAN DEFAULT TRUE,
     id_carteira INT,
     FOREIGN KEY (id_carteira) REFERENCES CARTEIRA_VENDEDOR(id_carteira)
);

CREATE TABLE FORNECEDOR(
	id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL, 
    cnpj VARCHAR(20) UNIQUE NOT NULL, 
    telefone VARCHAR(20),
    email VARCHAR(100)
);

SHOW TABLES;

CREATE TABLE ORCAMENTO(
	id_orcamento INT PRIMARY KEY AUTO_INCREMENT,
	data_criacao DATE NOT NULL,
    validade DATE,
    status VARCHAR(30),
    valor_total DECIMAL(12,2),
    
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    
    FOREIGN KEY(id_cliente) REFERENCES CLIENTE (id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES VENDEDOR(id_vendedor)
);

CREATE TABLE PRODUTO(
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco_unitario DECIMAL (12,2),
    descricao TEXT, 
    id_fornecedor INT NOT NULL, 
    
    FOREIGN KEY(id_fornecedor) REFERENCES FORNECEDOR(id_fornecedor)
    );
    
CREATE TABLE ITEM_ORCAMENTO(
	id_orcamento INT NOT NULL,
	seq_item INT NOT NULL,
	quantidade INT NOT NULL,
	preco_unitario DECIMAL (12,2),
	id_produto INT NOT NULL,

	PRIMARY KEY (id_orcamento, seq_item),

	FOREIGN KEY (id_orcamento) REFERENCES ORCAMENTO (id_orcamento),
	FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto)
);

CREATE TABLE FOLLOW_UP(
	id_folow INT PRIMARY KEY AUTO_INCREMENT,
    data_contato DATE NOT NULL,
    tipo_contato VARCHAR(50),
    observacao TEXT,
    proxima_acao VARCHAR(150),
    
    id_orcamento INT NOT NULL, 
    id_vendedor INT NOT NULL,
    
    FOREIGN KEY (id_orcamento) REFERENCES ORCAMENTO(id_orcamento),
    FOREIGN KEY (id_vendedor) REFERENCES VENDEDOR(id_vendedor)
);

CREATE TABLE CARTEIRA_VENDEDOR(
	id_carteira INT PRIMARY KEY AUTO_INCREMENT,
    id_analista INT NOT NULL,
    nome_carteira VARCHAR(100),
    status_relacionamento VARCHAR(50),
    data_inicio DATE,
    FOREIGN KEY (id_analista) REFERENCES ANALISTA (id_analista)
);

CREATE TABLE ANALISTA(
	id_analista INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL, 
    validacao BOOLEAN DEFAULT TRUE
);

INSERT INTO CLIENTE (id_cliente, nome, cpf_cnpj, telefone, email, endereco, segmento)
VALUES
(1, 'Maria Silva', 12345678900, 11999990000, 'maria@email.com', 'Rua A, 100', 'Varejo'),
(2, 'João Almeida', 98765432100, 11988880000, 'joao@email.com', 'Rua B, 200', 'Atacado');

ALTER TABLE CLIENTE
ADD COLUMN email VARCHAR(100);

INSERT INTO ANALISTA (id_analista,  nome, validacao)
VALUES
(1, 'Ana Costa', TRUE),
(5, 'Bruno Farias', FALSE);

INSERT INTO CARTEIRA_VENDEDOR (id_carteira, id_analista, nome_carteira, status_relacionamento, data_inicio)
VALUES
(1, 1, 'Carteira Norte', 'Ativa', '2024-01-10'),
(2, 2, 'Carteira Sul', 'Ativa', '2024-02-15');

INSERT INTO VENDEDOR (id_vendedor, nome, cargo, telefone, email, comissao, carteira_ativa, id_carteira)
VALUES
(1, 'Carlos Pereira', 'Representante', 11977770000, 'carlos@email.com', 5.5, TRUE, 1),
(2, 'Fernanda Dias', 'Representante', 11966660000, 'fernanda@email.com', 7.0, TRUE, 2);

INSERT INTO FORNECEDOR (id_fornecedor, nome, cnpj, telefone, email)
VALUES
(1, 'ABC Produtos', '11223344556677', 1133330000, 'contato@abc.com'),
(2, 'Max Supply', '99887766554433', 1144440000, 'vendas@max.com');

INSERT INTO PRODUTO (id_produto, nome, categoria, preco_unitario, descricao, id_fornecedor)
VALUES
(1, 'Caixa Plástica', 'Organização', 30.00, 'Caixa resistente', 1),
(2, 'Fita Adesiva', 'Escritório', 10.00, 'Fita transparente', 2);

INSERT INTO ORCAMENTO (id_orcamento, data_criacao, validade, status, valor_total, id_cliente, id_vendedor)
VALUES
(1, '2024-03-01', '2024-03-15', 'Em Análise', 300.00, 1, 1),
(2, '2024-03-05', '2024-03-20', 'Aprovado', 150.00, 2, 2);

INSERT INTO ITEM_ORCAMENTO (id_orcamento, seq_item, quantidade, preco_unitario, id_produto)
VALUES
(1, 1, 5, 30.00, 1),
(1, 2, 3, 10.00, 2),
(2, 1, 10, 10.00, 2);

INSERT INTO FOLLOW_UP (id_folow, data_contato, tipo_contato, observacao, proxima_acao, id_orcamento, id_vendedor)
VALUES
(1, '2024-03-02', 'Telefone', 'Cliente solicitou revisão', 'Enviar novo orçamento', 1, 1),
(2, '2024-03-06', 'Email', 'Cliente aprovou', 'Agendar entrega', 2, 2);


UPDATE ORCAMENTO
SET status = 'Aprovado'
WHERE id_orcamento = 1;

UPDATE CLIENTE 
SET telefone = 11955550000
WHERE id_cliente = 2;

UPDATE CARTEIRA_VENDEDOR
SET id_analista = 2
WHERE id_carteira = 1;

DELETE FROM ANALISTA
WHERE id_analista = 5;

DELETE FROM ITEM_ORCAMENTO
WHERE id_orcamento = 1 AND seq_item = 2;

DELETE FROM CLIENTE
WHERE id_cliente = 2;

SELECT * FROM CLIENTE;
SELECT * FROM ITEM_ORCAMENTO;

SELECT c.nome AS cliente, v.nome AS vendedor, o.status
FROM ORCAMENTO o 
JOIN CLIENTE c ON o.id_cliente = c.id_cliente
JOIN VENDEDOR v ON o.id_vendedor = v.id_vendedor;

SELECT nome, categoria, preco_unitario
FROM PRODUTO
ORDER BY preco_unitario DESC;

SELECT * FROM ORCAMENTO
WHERE status = 'Aprovado';

SELECT io.seq_item, p.nome, io.quantidade, io.preco_unitario
FROM ITEM_ORCAMENTO io
JOIN PRODUTO p ON io.id_produto = p.id_produto
WHERE io.id_orcamento = 1;

SELECT * FROM FOLLOW_UP
ORDER BY data_contato DESC
LIMIT 1;