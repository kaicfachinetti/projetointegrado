-- MySQL Script generated by MySQL Workbench
-- Mon May 27 13:38:16 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DataModelTrabalhoIntegrado
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DataModelTrabalhoIntegrado
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DataModelTrabalhoIntegrado` DEFAULT CHARACTER SET utf8 ;
USE `DataModelTrabalhoIntegrado` ;

-- -----------------------------------------------------
-- Table `DataModelTrabalhoIntegrado`.`banco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataModelTrabalhoIntegrado`.`banco` (
  `idbanco` INT NOT NULL,
  `nome_banco` VARCHAR(250) NOT NULL,
  `ativo` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`idbanco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataModelTrabalhoIntegrado`.`agencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataModelTrabalhoIntegrado`.`agencia` (
  `idagencia` INT NOT NULL,
  `digito_agencia` INT(1) NULL,
  `banco_idbanco` INT NOT NULL,
  `nome_agencia` VARCHAR(150) NOT NULL,
  `logradouro` VARCHAR(250) NULL,
  `numero` INT NULL,
  `complemento` VARCHAR(150) NULL,
  `bairro` VARCHAR(150) NULL,
  `cidade` VARCHAR(150) NULL,
  `estado` VARCHAR(150) NULL,
  `pais` VARCHAR(150) NULL,
  `ativo` INT(1) NOT NULL,
  PRIMARY KEY (`idagencia`, `banco_idbanco`),
  INDEX `fk_agencia_banco_idx` (`banco_idbanco` ASC) VISIBLE,
  CONSTRAINT `fk_agencia_banco`
    FOREIGN KEY (`banco_idbanco`)
    REFERENCES `DataModelTrabalhoIntegrado`.`banco` (`idbanco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataModelTrabalhoIntegrado`.`conta_corrente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataModelTrabalhoIntegrado`.`conta_corrente` (
  `id_conta` INT NOT NULL,
  `agencia_idagencia` INT NOT NULL,
  `digito` INT(1) NULL,
  `ativo` INT(1) NULL,
  PRIMARY KEY (`id_conta`, `agencia_idagencia`),
  INDEX `fk_conta_corrente_agencia1_idx` (`agencia_idagencia` ASC) VISIBLE,
  CONSTRAINT `fk_conta_corrente_agencia1`
    FOREIGN KEY (`agencia_idagencia`)
    REFERENCES `DataModelTrabalhoIntegrado`.`agencia` (`idagencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataModelTrabalhoIntegrado`.`correntista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataModelTrabalhoIntegrado`.`correntista` (
  `cpf` INT NOT NULL,
  `conta_corrente_id_conta` INT NOT NULL,
  `nome` VARCHAR(250) NULL,
  `telefone` INT(11) NULL,
  PRIMARY KEY (`cpf`, `conta_corrente_id_conta`),
  INDEX `fk_correntista_conta_corrente1_idx` (`conta_corrente_id_conta` ASC) VISIBLE,
  CONSTRAINT `fk_correntista_conta_corrente1`
    FOREIGN KEY (`conta_corrente_id_conta`)
    REFERENCES `DataModelTrabalhoIntegrado`.`conta_corrente` (`id_conta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataModelTrabalhoIntegrado`.`tipo_transacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataModelTrabalhoIntegrado`.`tipo_transacao` (
  `id_tipo_transacao` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(150) NOT NULL,
  `observacao` VARCHAR(255) NULL,
  `ativo` INT(1) NOT NULL,
  PRIMARY KEY (`id_tipo_transacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataModelTrabalhoIntegrado`.`chave_pix`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataModelTrabalhoIntegrado`.`chave_pix` (
  `idchave_pix` VARCHAR(55) NOT NULL,
  `conta_corrente_id_conta` INT NOT NULL,
  `tipo` ENUM('email', 'cpf_cnpj', 'telefone', 'aleatoria') NULL,
  PRIMARY KEY (`idchave_pix`, `conta_corrente_id_conta`),
  INDEX `fk_chave_pix_conta_corrente1_idx` (`conta_corrente_id_conta` ASC) VISIBLE,
  CONSTRAINT `fk_chave_pix_conta_corrente1`
    FOREIGN KEY (`conta_corrente_id_conta`)
    REFERENCES `DataModelTrabalhoIntegrado`.`conta_corrente` (`id_conta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DataModelTrabalhoIntegrado`.`transacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DataModelTrabalhoIntegrado`.`transacao` (
  `id_transacao` INT NOT NULL AUTO_INCREMENT,
  `tipo_transacao_id_tipo_transacao` INT NOT NULL,
  `conta_corrente_id_conta` INT NOT NULL,
  `data_transacao` DATETIME NOT NULL,
  `data_efetivacao` DATETIME NOT NULL,
  `valor` FLOAT NOT NULL,
  `chave_pix_idchave_pix` VARCHAR(55) NULL,
  PRIMARY KEY (`id_transacao`, `tipo_transacao_id_tipo_transacao`, `conta_corrente_id_conta`),
  INDEX `fk_tipo_transacao_has_conta_corrente_conta_corrente1_idx` (`conta_corrente_id_conta` ASC) VISIBLE,
  INDEX `fk_tipo_transacao_has_conta_corrente_tipo_transacao1_idx` (`tipo_transacao_id_tipo_transacao` ASC) VISIBLE,
  INDEX `fk_transacao_chave_pix1_idx` (`chave_pix_idchave_pix` ASC) VISIBLE,
  CONSTRAINT `fk_tipo_transacao_has_conta_corrente_tipo_transacao1`
    FOREIGN KEY (`tipo_transacao_id_tipo_transacao`)
    REFERENCES `DataModelTrabalhoIntegrado`.`tipo_transacao` (`id_tipo_transacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_transacao_has_conta_corrente_conta_corrente1`
    FOREIGN KEY (`conta_corrente_id_conta`)
    REFERENCES `DataModelTrabalhoIntegrado`.`conta_corrente` (`id_conta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transacao_chave_pix1`
    FOREIGN KEY (`chave_pix_idchave_pix`)
    REFERENCES `DataModelTrabalhoIntegrado`.`chave_pix` (`idchave_pix`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
