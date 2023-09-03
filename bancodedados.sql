CREATE DATABASE aula_db_exemplos;
USE aula_db_exemplos;

CREATE TABLE vendas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto VARCHAR(255) NOT NULL,
    receita DECIMAL(10, 2) NOT NULL
);

CREATE TABLE autores (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    nascimento DATE
);

CREATE TABLE livros (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

CREATE TABLE alunos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE matriculas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    aluno_id INT,
    curso VARCHAR(255) NOT NULL,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id)
);

INSERT INTO autores (nome, nascimento) VALUES 
('J.K. Rowling', '1965-07-31'),
('George Orwell', '1903-06-25'),
('J.R.R. Tolkien', '1892-01-03'),
('Jane Austen', '1775-12-16'),
('Agatha Christie', '1890-09-15'),
('F. Scott Fitzgerald', '1896-09-24');


INSERT INTO livros (titulo, autor_id) VALUES
('Harry Potter e a Pedra Filosofal', 1),
('Harry Potter e a Câmara Secreta', 1),
('1984', 2),
('O Senhor dos Anéis', 3),
('Orgulho e Preconceito', 4),
('Morte no Nilo', 5),
('O Grande Gatsby', 6),
('O Misterioso Caso de Styles', 5),
('Razão e Sensibilidade', 4);


INSERT INTO alunos (nome) VALUES 
('João'),
('Maria'),
('Pedro'),
('Ana'),
('Beatriz'),
('Lucas'),
('Fernanda'),
('Eduardo'),
('Luisa'),
('Roberto');

INSERT INTO matriculas (aluno_id, curso) VALUES
(1, 'Engenharia de Software'),
(2, 'Medicina'),
(3, 'Engenharia de Software'),
(3, 'Arquitetura'),
(5, 'Física'),
(6, 'História'),
(7, 'Psicologia'),
(8, 'Engenharia Civil'),
(9, 'Artes'),
(10, 'Engenharia de Software'),
(10, 'Economia');

INSERT INTO vendas (produto, receita) VALUES 
('Produto A', 5000.00),
('Produto B', 15000.00),
('Produto C', 8000.00),
('Produto A', 6000.00),
('Produto B', 17000.00),
('Produto C', 3000.00),
('Produto D', 10000.00),
('Produto E', 6500.00),
('Produto F', 8500.00),
('Produto A', 7000.00),
('Produto B', 12000.00),
('Produto E', 4000.00),
('Produto C', 11000.00),
('Produto D', 5000.00);

--exercício 1
SELECT titulo FROM livros;

--exercicio 2
SELECT nome
FROM autores
WHERE nascimento < '1900-01-01';

--exercicio 3
SELECT livros.titulo
FROM livros
INNER JOIN autores ON livros.autor_id = autores.id
WHERE autores.nome = 'J.K. Rowling';

--exercicio 4
SELECT alunos.nome
FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id
WHERE matriculas.curso = 'Engenharia de Software';

--exercicio 5
SELECT produto, SUM(receita) AS receita_total
FROM vendas
GROUP BY produto;

--exercicio 6
SELECT autores.nome AS autor, COUNT(livros.id) AS total_de_livros
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome;

--exercicio 7
SELECT curso, COUNT(aluno_id) AS total_alunos
FROM matriculas
GROUP BY curso;

--exercicio 8
SELECT produto, AVG(receita) AS media_receita
FROM vendas
GROUP BY produto;

--exercicio 9
SELECT produto, SUM(receita) AS receita_total
FROM vendas
GROUP BY produto
HAVING SUM(receita) > 10000.00;

--exercicio 10
SELECT autores.nome AS autor, COUNT(livros.id) AS total_livros_publicados
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
HAVING COUNT(livros.id) > 2;

--exercicio 11
SELECT livros.titulo AS livro, autores.nome AS autor
FROM livros
INNER JOIN autores ON livros.autor_id = autores.id;

--exercicio 12
SELECT alunos.nome AS aluno, matriculas.curso
FROM alunos
LEFT JOIN matriculas ON alunos.id = matriculas.aluno_id;

--exercicio 13
SELECT autores.nome AS autor, IFNULL(livros.titulo, 'Nenhum livro publicado') AS livro
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id;

--exercicio 14
SELECT matriculas.curso, alunos.nome AS aluno
FROM matriculas
RIGHT JOIN alunos ON matriculas.aluno_id = alunos.id;

--exercicio 15
SELECT alunos.nome AS aluno, matriculas.curso
FROM matriculas
INNER JOIN alunos ON matriculas.aluno_id = alunos.id;

--exercicio 16
SELECT autores.nome AS autor, COUNT(livros.id) AS total_livros_publicados
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.nome
ORDER BY total_livros_publicados DESC
LIMIT 1;

--exercicio 17
SELECT produto, MIN(receita) AS menor_receita
FROM vendas;

--exercicio 18
SELECT autores.nome AS autor, SUM(20) AS receita_total
FROM autores
LEFT JOIN livros ON autores.id = livros.autor_id
LEFT JOIN vendas ON livros.titulo = vendas.produto
GROUP BY autores.nome;
