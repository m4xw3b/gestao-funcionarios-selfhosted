-- schema.sql: Definição da estrutura da base de dados
-- Criar tabelas principais
CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT
);

CREATE TABLE permissoes (
    id SERIAL PRIMARY KEY,
    nivel VARCHAR(50) NOT NULL UNIQUE,
    pode_editar BOOLEAN DEFAULT FALSE,
    pode_visualizar_todos BOOLEAN DEFAULT FALSE
);

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    morada VARCHAR(255),
    telemovel VARCHAR(20),
    email VARCHAR(100) UNIQUE NOT NULL,
    foto_path VARCHAR(255),
    data_contratacao DATE DEFAULT CURRENT_DATE,
    departamento_id INTEGER REFERENCES departamentos(id) ON DELETE SET NULL,
    permissao_id INTEGER REFERENCES permissoes(id) ON DELETE RESTRICT
);

-- Dados Iniciais (Seed Data)
INSERT INTO departamentos (nome) VALUES ('RH'), ('TI'), ('Logística'), ('Vendas');
INSERT INTO permissoes (nivel, pode_editar, pode_visualizar_todos) VALUES 
('Admin', TRUE, TRUE),
('Gestor', TRUE, TRUE),
('Funcionário', FALSE, FALSE);
