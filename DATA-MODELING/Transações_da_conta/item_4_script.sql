CREATE DATABASE ATV_2;

USE ATV_2;

CREATE TABLE dimTipo(
	id_tipo INT PRIMARY KEY AUTO_INCREMENT,
    tipo VARCHAR(45) 
);

CREATE TABLE dimData(
	id_data INT PRIMARY KEY AUTO_INCREMENT,
    _data DATE,
    dia_semana ENUM('segunda', 'Terça', 'quarta', 'quinta', 'sexta', 'sabado', 'domingo'),
    mes INT (2),
    ano INT(2),
    feriado TINYINT(1)
);

CREATE TABLE dimCliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    cpf CHAR(11),
    nome_completo VARCHAR(150),
    data_nascimento DATE,
    endereco VARCHAR(150),
    email VARCHAR(45),
    profissao VARCHAR(45),
    celular VARCHAR(45),
    _status ENUM('ativado', 'desativado'),
    produtos VARCHAR (100),
    score SMALLINT(3)
);

CREATE TABLE fatoTransacoes(
	id_transacoes INT PRIMARY KEY AUTO_INCREMENT,
    dim_Data INT,
    dim_Cliente INT,
    dim_Tipo INT,    
	CONSTRAINT fk_idData FOREIGN KEY (dim_Data) REFERENCES dimData (id_data),
    CONSTRAINT fk_idCliente FOREIGN KEY (dim_Cliente) REFERENCES dimCliente (id_cliente),
    CONSTRAINT fk_idTipo FOREIGN KEY (dim_Tipo) REFERENCES dimTipo (id_tipo)
)