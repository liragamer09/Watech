CREATE DATABASE user_watech;
USE user_watech;

-- Tabela de Identidade/Autenticação
CREATE TABLE users (
    id_user INT AUTO_INCREMENT PRIMARY KEY,
    
    nome_user VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_criacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    email VARCHAR(100) UNIQUE NOT NULL,
    CONSTRAINT formato_email CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9._%+-]+\\.[A-Za-z]{2,}(\\.[A-Za-z]{2,})?$')
);

-- Tabela de Histórico de Medidas (Permite registrar a evolução do peso)
CREATE TABLE user_medidas (
    id_medida INT AUTO_INCREMENT PRIMARY KEY,
    
    peso DECIMAL(5, 2) NOT NULL,
    altura DECIMAL(3, 2) NOT NULL,
    data_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    id_user INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);

-- Tabela de Garrafas
CREATE TABLE garrafas (
    id_garrafa INT AUTO_INCREMENT PRIMARY KEY,
    
    nome_garrafa VARCHAR(255) DEFAULT 'Minha garrafa',
    endereco_MAC VARCHAR(17) UNIQUE NOT NULL,
    capacidade INT NOT NULL,
    bateria TINYINT CHECK (bateria BETWEEN 0 AND 100),
    ultima_sincronizacao DATETIME,
    
    id_user INT NOT NULL,
    FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
);

SELECT * FROM users;

SELECT * FROM user_medidas;

SELECT * FROM garrafas;