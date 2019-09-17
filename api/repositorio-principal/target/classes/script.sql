-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema principal
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `principal` ;

-- -----------------------------------------------------
-- Schema principal
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `principal` ;
-- -----------------------------------------------------
-- Schema sistema
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sistema` ;

-- -----------------------------------------------------
-- Schema sistema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistema` ;
-- -----------------------------------------------------
-- Schema pessoa
-- -----------------------------------------------------
-- Cadastro de pessoas físicas, jurídicas e grupos sociais
DROP SCHEMA IF EXISTS `pessoa` ;

-- -----------------------------------------------------
-- Schema pessoa
--
-- Cadastro de pessoas físicas, jurídicas e grupos sociais
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pessoa` ;
-- -----------------------------------------------------
-- Schema comum
-- -----------------------------------------------------
-- Tabelas comuns a todos os outros esquemas
DROP SCHEMA IF EXISTS `comum` ;

-- -----------------------------------------------------
-- Schema comum
--
-- Tabelas comuns a todos os outros esquemas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `comum` ;
-- -----------------------------------------------------
-- Schema produto
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `produto` ;

-- -----------------------------------------------------
-- Schema produto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `produto` ;
-- -----------------------------------------------------
-- Schema oauth2
-- -----------------------------------------------------
-- Tabelas de controle do framework de segurança Oauth2
DROP SCHEMA IF EXISTS `oauth2` ;

-- -----------------------------------------------------
-- Schema oauth2
--
-- Tabelas de controle do framework de segurança Oauth2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oauth2` ;
-- -----------------------------------------------------
-- Schema evento
-- -----------------------------------------------------
-- schema dos eventos dos bens
DROP SCHEMA IF EXISTS `evento` ;

-- -----------------------------------------------------
-- Schema evento
--
-- schema dos eventos dos bens
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `evento` ;
-- -----------------------------------------------------
-- Schema veiculo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `veiculo` ;

-- -----------------------------------------------------
-- Schema veiculo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `veiculo` ;
-- -----------------------------------------------------
-- Schema funcional
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `funcional` ;

-- -----------------------------------------------------
-- Schema funcional
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `funcional` ;
USE `principal` ;

-- -----------------------------------------------------
-- Table `principal`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `principal`.`item` ;

CREATE TABLE IF NOT EXISTS `principal`.`item` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('PESSOA', 'PRODUTO', 'SERVICO') NOT NULL,
  `observacao` TEXT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NOT NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `produto`.`marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto`.`marca` ;

CREATE TABLE IF NOT EXISTS `produto`.`marca` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `fabricante` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Quando a marca identifica o fabricante e não o modelo',
  `logotipo` LONGBLOB NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_marca_marca1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `produto`.`marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nome_UNIQUE` ON `produto`.`marca` (`nome` ASC) VISIBLE;

CREATE INDEX `fk_marca_marca1_idx` ON `produto`.`marca` (`pai_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `produto`.`produto_tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto`.`produto_tipo` ;

CREATE TABLE IF NOT EXISTS `produto`.`produto_tipo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_produto_tipo_1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `produto`.`produto_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_produto_tipo_1_idx` ON `produto`.`produto_tipo` (`pai_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `produto`.`modelo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto`.`modelo` ;

CREATE TABLE IF NOT EXISTS `produto`.`modelo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `produto_tipo_id` INT UNSIGNED NOT NULL,
  `marca_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_versao_1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `produto`.`marca` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_versao_3`
    FOREIGN KEY (`produto_tipo_id`)
    REFERENCES `produto`.`produto_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_versao_1_idx` ON `produto`.`modelo` (`marca_id` ASC) VISIBLE;

CREATE INDEX `fk_versao_3_idx` ON `produto`.`modelo` (`produto_tipo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `principal`.`produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `principal`.`produto` ;

CREATE TABLE IF NOT EXISTS `principal`.`produto` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `modelo_id` INT UNSIGNED NOT NULL,
  `numero_serie` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_produto_1`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`item` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_2`
    FOREIGN KEY (`modelo_id`)
    REFERENCES `produto`.`modelo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_produto_2_idx` ON `principal`.`produto` (`modelo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `principal`.`servico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `principal`.`servico` ;

CREATE TABLE IF NOT EXISTS `principal`.`servico` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_servico`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`item` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `principal`.`pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `principal`.`pessoa` ;

CREATE TABLE IF NOT EXISTS `principal`.`pessoa` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `tipo` ENUM('PF', 'PJ', 'GS') NOT NULL COMMENT 'Se PF - Pessoa Física\nSe PJ - Pessoa Jurídica\nSe GS - Grupo Social',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`item` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

USE `sistema` ;

-- -----------------------------------------------------
-- Table `sistema`.`modulo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`modulo` ;

CREATE TABLE IF NOT EXISTS `sistema`.`modulo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`));

CREATE UNIQUE INDEX `codigo_UNIQUE` ON `sistema`.`modulo` (`codigo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`funcionalidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`funcionalidade` ;

CREATE TABLE IF NOT EXISTS `sistema`.`funcionalidade` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_funcionalidade_funcionalidade1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `sistema`.`funcionalidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_funcionalidade_funcionalidade1_idx` ON `sistema`.`funcionalidade` (`pai_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `codigo_UNIQUE` ON `sistema`.`funcionalidade` (`codigo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`acao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`acao` ;

CREATE TABLE IF NOT EXISTS `sistema`.`acao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `tipo` ENUM('A', 'C', 'R', 'U', 'D', 'E') NOT NULL DEFAULT 'E' COMMENT 'A - ACESSAR\nC - CRIAR\nR - RESTAURAR\nU - ATUALIZAR\nD - DELETAR\nE - EXECUTAR',
  `ordem` INT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_acao_acao1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `sistema`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_acao_acao1_idx` ON `sistema`.`acao` (`pai_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `codigo_UNIQUE` ON `sistema`.`acao` (`codigo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`funcionalidade_acao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`funcionalidade_acao` ;

CREATE TABLE IF NOT EXISTS `sistema`.`funcionalidade_acao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `funcionalidade_id` INT UNSIGNED NOT NULL,
  `acao_id` INT UNSIGNED NOT NULL,
  `concede_acesso_a` ENUM('ANONIMO', 'SEM_PERFIL', 'PERFIL', 'PERFIL_PESSOAL', 'PERFIL_FUNCIONAL') NOT NULL DEFAULT 'PERFIL' COMMENT 'ANONIMO - Disponível a todos os usuários que efetuaram login ou não\nSEM_PERFIL - Disponível a todos os usuários que efetuaram login\nPERFIL - Disponível a todos os usuários que efetuaram login e que tenha registro na tabela de privilégios com acesso a funcionalidade/acao\nPERFIL_PESSOAL - Disponível a todos os usuários que efetuaram login, que tenha registro na tabela de privilégios com acesso a funcionalidade/acao e que tenha registro de pessoa vinculada\nPERFIL_FUNCIONAL - Disponível a todos os usuários que efetuaram login, que tenha registro na tabela de privilégios com acesso a funcionalidade/acao, que tenha registro de pessoa vinculada e que a pessoa vinculada tenha registro de emprego vinculado',
  `descricao` TEXT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_funcionalidade_acao_1`
    FOREIGN KEY (`funcionalidade_id`)
    REFERENCES `sistema`.`funcionalidade` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionalidade_acao_2`
    FOREIGN KEY (`acao_id`)
    REFERENCES `sistema`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_funcionalidade_acao_3`
    FOREIGN KEY (`pai_id`)
    REFERENCES `sistema`.`funcionalidade_acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE UNIQUE INDEX `uq_funcionalidade_acao` ON `sistema`.`funcionalidade_acao` (`funcionalidade_id` ASC, `acao_id` ASC) VISIBLE;

CREATE INDEX `fk_funcionalidade_acao_2_idx` ON `sistema`.`funcionalidade_acao` (`acao_id` ASC) VISIBLE;

CREATE INDEX `fk_funcionalidade_acao_1_idx` ON `sistema`.`funcionalidade_acao` (`funcionalidade_id` ASC) VISIBLE;

CREATE INDEX `fk_funcionalidade_acao_3_idx` ON `sistema`.`funcionalidade_acao` (`pai_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`modulo_funcionalidade_acao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`modulo_funcionalidade_acao` ;

CREATE TABLE IF NOT EXISTS `sistema`.`modulo_funcionalidade_acao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `modulo_id` INT UNSIGNED NOT NULL,
  `funcionalidade_acao_id` INT UNSIGNED NOT NULL,
  `grupo_menu` VARCHAR(255) NULL,
  `exibir_menu_principal` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `ordem` INT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_modulo_funcionalidade_acao_1`
    FOREIGN KEY (`modulo_id`)
    REFERENCES `sistema`.`modulo` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_modulo_funcionalidade_acao_2`
    FOREIGN KEY (`funcionalidade_acao_id`)
    REFERENCES `sistema`.`funcionalidade_acao` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

CREATE UNIQUE INDEX `uq_modulo_funcionalidade_acao` ON `sistema`.`modulo_funcionalidade_acao` (`modulo_id` ASC, `funcionalidade_acao_id` ASC) VISIBLE;

CREATE INDEX `fk_modulo_funcionalidade_acao_1` ON `sistema`.`modulo_funcionalidade_acao` (`modulo_id` ASC) VISIBLE;

CREATE INDEX `fk_modulo_funcionalidade_acao_2_idx` ON `sistema`.`modulo_funcionalidade_acao` (`funcionalidade_acao_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`perfil` ;

CREATE TABLE IF NOT EXISTS `sistema`.`perfil` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `administrador` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Se igual a \'S\' informa que o conteúdo da tabela privilegio deve ser ignorado e todas as funcionalidades/ações ativos devem ser concedidas a quem acionar este perfil. Porém, para ativar este perfil, o usuario também deve ser do tipo ADMIN, caso contrário, disparar uma excessão. Só deve haver um registro de perfil com o valor \'S\', todos os demais deve ser igual a \'N\' (este atributo deve ser manipulado somente pelo BD)',
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`));

CREATE UNIQUE INDEX `codigo_UNIQUE` ON `sistema`.`perfil` (`codigo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`privilegio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`privilegio` ;

CREATE TABLE IF NOT EXISTS `sistema`.`privilegio` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `perfil_id` INT UNSIGNED NOT NULL,
  `funcionalidade_acao_id` INT UNSIGNED NOT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_privilegio_1`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `sistema`.`perfil` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_privilegio_2`
    FOREIGN KEY (`funcionalidade_acao_id`)
    REFERENCES `sistema`.`funcionalidade_acao` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
COMMENT = 'Conteúdo utilizado para checar funcionalidades/acões vinculadas à algum perfil';

CREATE UNIQUE INDEX `uq_privilegio` ON `sistema`.`privilegio` (`perfil_id` ASC, `funcionalidade_acao_id` ASC) VISIBLE;

CREATE INDEX `fk_privilegio_2_idx` ON `sistema`.`privilegio` (`funcionalidade_acao_id` ASC) VISIBLE;

CREATE INDEX `fk_privilegio_1_idx` ON `sistema`.`privilegio` (`perfil_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`usuario` ;

CREATE TABLE IF NOT EXISTS `sistema`.`usuario` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('COMUM', 'ADMIN', 'SISTEMA') NOT NULL DEFAULT 'COMUM' COMMENT 'COMUM - usuário comum, somente acesso aos privilégios atribuídos ao perfil selecionado;\nSISTEMA - usuário de sistema, somente acesso aos privilégios atribuidos ao perfil selecionado;\nADMIN - usuário administrador, acesso a todos os privilégios. Porém, o modo administrador só será acionado se um perfil do tipo administrador também for selecionado. Caso contrário, somente acesso aos privilégios atribuidos ao perfil selecionado;\n',
  `nome` VARCHAR(255) NOT NULL,
  `login` VARCHAR(255) NULL,
  `senha` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `foto` BLOB NULL,
  `pessoa_id` INT UNSIGNED NULL,
  `permitir_heranca_perfis` ENUM('S', 'N') NOT NULL DEFAULT 'S' COMMENT 'S - pode selecionar os próprios ou os perfis atribuídos à pessoa vinculada a este usuário. Exemplo selecionar os perfis atribuidos a uma lotação do registro de funcionario vinculado a pessoa\nN - pode selecionar somente os perfis atribuídos ao usuário',
  `ultimo_perfil_id` INT UNSIGNED NULL COMMENT 'memoria do ultimo perfil utilizado no login. No proximo login este será o perfil utilizado. O usuário poderá trocar seu perfil ao executar o sistema',
  `observacao` TEXT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_usuario_1`
    FOREIGN KEY (`criado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_2`
    FOREIGN KEY (`atualizado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_3`
    FOREIGN KEY (`ultimo_perfil_id`)
    REFERENCES `sistema`.`perfil` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_4`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE INDEX `fk_usuario_1_idx` ON `sistema`.`usuario` (`criado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_usuario_2_idx` ON `sistema`.`usuario` (`atualizado_usuario_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `sistema`.`usuario` (`email` ASC) VISIBLE;

CREATE UNIQUE INDEX `login_UNIQUE` ON `sistema`.`usuario` (`login` ASC) VISIBLE;

CREATE INDEX `fk_usuario_4_idx` ON `sistema`.`usuario` (`pessoa_id` ASC) VISIBLE;

CREATE INDEX `fk_usuario_3_idx` ON `sistema`.`usuario` (`ultimo_perfil_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`usuario_perfil`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`usuario_perfil` ;

CREATE TABLE IF NOT EXISTS `sistema`.`usuario_perfil` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` INT UNSIGNED NOT NULL,
  `perfil_id` INT UNSIGNED NOT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `padrao` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Se igual a \'S\' indica que este será o perfil acionado, porém, somente se o campo ultimo_usuario_perfil_id do usuário for nulo. O usuário_perfil só pode ter um registro marcado como padrão. Cada usuário tem o seu perfil padrão.',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_usuario_perfil_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_perfil_2`
    FOREIGN KEY (`perfil_id`)
    REFERENCES `sistema`.`perfil` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

CREATE UNIQUE INDEX `uq_usuario_perfil` ON `sistema`.`usuario_perfil` (`usuario_id` ASC, `perfil_id` ASC) VISIBLE;

CREATE INDEX `fk_usuario_perfil_2_idx` ON `sistema`.`usuario_perfil` (`perfil_id` ASC) INVISIBLE;

CREATE INDEX `fk_usuario_perfil_1_idx` ON `sistema`.`usuario_perfil` (`usuario_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`forma_autenticacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`forma_autenticacao` ;

CREATE TABLE IF NOT EXISTS `sistema`.`forma_autenticacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `tipo` ENUM('MEMORIA', 'BD', 'LDAP', 'EXTERNO') NOT NULL,
  `config` JSON NULL,
  `padrao` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Se igual a \'S\' indica que todo novo usuário poderá se habilitar por esta forma de autenticação',
  `ordem` INT NOT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `ordem_UNIQUE` ON `sistema`.`forma_autenticacao` (`ordem` ASC) VISIBLE;

CREATE UNIQUE INDEX `codigo_UNIQUE` ON `sistema`.`forma_autenticacao` (`codigo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`usuario_forma_autenticacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`usuario_forma_autenticacao` ;

CREATE TABLE IF NOT EXISTS `sistema`.`usuario_forma_autenticacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` INT UNSIGNED NOT NULL,
  `forma_autenticacao_id` INT UNSIGNED NOT NULL,
  `valor` JSON NULL COMMENT 'Configurações complementares da forma de autenticação do usuário',
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_usuario_forma_autenticacao_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_forma_autenticacao_2`
    FOREIGN KEY (`forma_autenticacao_id`)
    REFERENCES `sistema`.`forma_autenticacao` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_usuario_forma_autenticacao_1_idx` ON `sistema`.`usuario_forma_autenticacao` (`usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_usuario_forma_autenticacao_2_idx` ON `sistema`.`usuario_forma_autenticacao` (`forma_autenticacao_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `uq_usuario_forma_autenticacao_1` ON `sistema`.`usuario_forma_autenticacao` (`usuario_id` ASC, `forma_autenticacao_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`token` ;

CREATE TABLE IF NOT EXISTS `sistema`.`token` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` INT UNSIGNED NOT NULL,
  `token` TEXT NOT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expira_em` INT UNSIGNED NULL,
  `tipo` ENUM('ACESSO', 'TROCAR_SENHA') NULL,
  `detalhe` JSON NULL,
  `invalidado_em` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_token_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_token_1_idx` ON `sistema`.`token` (`usuario_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`historico_atividade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`historico_atividade` ;

CREATE TABLE IF NOT EXISTS `sistema`.`historico_atividade` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `token_id` INT UNSIGNED NOT NULL,
  `requisicao` JSON NULL,
  `inicio` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modulo_id` INT UNSIGNED NULL,
  `funcionalidade_id` INT UNSIGNED NULL,
  `acao_id` INT UNSIGNED NULL,
  `resposta` JSON NULL,
  `termino` TIMESTAMP NULL,
  `duracao` INT UNSIGNED NULL,
  `status` INT UNSIGNED NULL,
  `mensagem` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_historico_atividade_1`
    FOREIGN KEY (`token_id`)
    REFERENCES `sistema`.`token` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_historico_atividade_idx` ON `sistema`.`historico_atividade` (`token_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `sistema`.`configuracao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sistema`.`configuracao` ;

CREATE TABLE IF NOT EXISTS `sistema`.`configuracao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `valor` JSON NULL,
  `usuario_id` INT UNSIGNED NULL COMMENT 'Quando a configuração é exclusiva de um usuário. Se não preenchido, é do sistema ou do módulo.',
  `modulo_id` INT UNSIGNED NULL COMMENT 'Quando a configuração é exclusiva de um módulo. Se não preenchido, é do sistema ou do usuário.',
  `pai_id` INT UNSIGNED NULL COMMENT 'indica a configuracao principal desta configuracao',
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NOT NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_configuracao_1`
    FOREIGN KEY (`criado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_configuracao_2`
    FOREIGN KEY (`atualizado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_configuracao_3`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_configuracao_4`
    FOREIGN KEY (`modulo_id`)
    REFERENCES `sistema`.`modulo` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_configuracao_5`
    FOREIGN KEY (`pai_id`)
    REFERENCES `sistema`.`configuracao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_configuracao_1_idx` ON `sistema`.`configuracao` (`criado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_configuracao_2_idx` ON `sistema`.`configuracao` (`atualizado_usuario_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `codigo_UNIQUE` ON `sistema`.`configuracao` (`codigo` ASC) VISIBLE;

CREATE INDEX `fk_configuracao_3_idx` ON `sistema`.`configuracao` (`usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_configuracao_4_idx` ON `sistema`.`configuracao` (`modulo_id` ASC) VISIBLE;

CREATE INDEX `fk_configuracao_5_idx` ON `sistema`.`configuracao` (`pai_id` ASC) VISIBLE;

USE `pessoa` ;

-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_fisica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`pessoa_fisica` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_fisica` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(14) NULL,
  `nascimento` DATE NULL,
  `falecimento` DATE NULL,
  `sexo` ENUM('M', 'F') NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa_fisica_1`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `cpf_UNIQUE` ON `pessoa`.`pessoa_fisica` (`cpf` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_juridica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`pessoa_juridica` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_juridica` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cnpj` CHAR(18) NULL,
  `fundacao` DATE NULL,
  `encerramento` DATE NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa_juridica_1`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `cnpj_UNIQUE` ON `pessoa`.`pessoa_juridica` (`cnpj` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`grupo_social`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`grupo_social` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`grupo_social` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `administrado` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Se N - Indica que não possui administrador\nSe S - Indica que é administrado por um usuario',
  `dinamico` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Se S - Indica que os membros são encontrados atraves do sql de consulta\nSe N - Indica que os membros são encontrados no relacionamento entre pessoas',
  `sql` TEXT NULL COMMENT 'sql para encontrar pessoa_id que são membros deste grupo',
  `inicio` DATETIME NULL,
  `termino` DATETIME NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_grupo_social_i`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento_tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`relacionamento_tipo` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento_tipo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `codigo` VARCHAR(255) NOT NULL,
  `temporal` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `codigo_UNIQUE` ON `pessoa`.`relacionamento_tipo` (`codigo` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`relacionamento` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `relacionamento_tipo_id` INT UNSIGNED NOT NULL,
  `inicio` DATETIME NULL,
  `termino` DATETIME NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_relacionamento_1`
    FOREIGN KEY (`relacionamento_tipo_id`)
    REFERENCES `pessoa`.`relacionamento_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_relacionamento_1_idx` ON `pessoa`.`relacionamento` (`relacionamento_tipo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento_funcao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`relacionamento_funcao` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento_funcao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `nome_se_feminino` VARCHAR(255) NULL,
  `codigo` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento_pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`relacionamento_pessoa` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento_pessoa` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `relacionamento_id` INT UNSIGNED NOT NULL,
  `pessoa_id` INT UNSIGNED NOT NULL,
  `relacionamento_funcao_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_relacionamento_pessoa_1`
    FOREIGN KEY (`relacionamento_id`)
    REFERENCES `pessoa`.`relacionamento` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relacionamento_pessoa_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relacionamento_pessoa_3`
    FOREIGN KEY (`relacionamento_funcao_id`)
    REFERENCES `pessoa`.`relacionamento_funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_relacionamento_pessoa_1_idx` ON `pessoa`.`relacionamento_pessoa` (`relacionamento_id` ASC) VISIBLE;

CREATE INDEX `fk_relacionamento_pessoa_2_idx` ON `pessoa`.`relacionamento_pessoa` (`pessoa_id` ASC) VISIBLE;

CREATE INDEX `fk_relacionamento_pessoa_3_idx` ON `pessoa`.`relacionamento_pessoa` (`relacionamento_funcao_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `uq_relacionamento_pessoa_1` ON `pessoa`.`relacionamento_pessoa` (`relacionamento_id` ASC, `pessoa_id` ASC, `relacionamento_funcao_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento_configuracao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`relacionamento_configuracao` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento_configuracao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `relacionamento_tipo_id` INT UNSIGNED NOT NULL,
  `relacionador_funcao_id` INT UNSIGNED NOT NULL,
  `relacionado_funcao_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_relacionamento_configuracao_1`
    FOREIGN KEY (`relacionamento_tipo_id`)
    REFERENCES `pessoa`.`relacionamento_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relacionamento_configuracao_2`
    FOREIGN KEY (`relacionador_funcao_id`)
    REFERENCES `pessoa`.`relacionamento_funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relacionamento_configuracao_3`
    FOREIGN KEY (`relacionado_funcao_id`)
    REFERENCES `pessoa`.`relacionamento_funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_relacionamento_configuracao_1_idx` ON `pessoa`.`relacionamento_configuracao` (`relacionamento_tipo_id` ASC) VISIBLE;

CREATE INDEX `fk_relacionamento_configuracao_2_idx` ON `pessoa`.`relacionamento_configuracao` (`relacionador_funcao_id` ASC) VISIBLE;

CREATE INDEX `fk_relacionamento_configuracao_3_idx` ON `pessoa`.`relacionamento_configuracao` (`relacionado_funcao_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `comum`.`arquivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comum`.`arquivo` ;

CREATE TABLE IF NOT EXISTS `comum`.`arquivo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(300) NOT NULL,
  `extensao` VARCHAR(255) NOT NULL,
  `conteudo` LONGBLOB NOT NULL,
  `tamanho_bytes` INT NOT NULL,
  `md5` VARCHAR(255) NOT NULL,
  `data` DATETIME NULL,
  `local` POINT NULL,
  `autores` VARCHAR(255) NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `md5_UNIQUE` ON `comum`.`arquivo` (`md5` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_arquivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`pessoa_arquivo` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_arquivo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT UNSIGNED NOT NULL,
  `arquivo_id` INT UNSIGNED NOT NULL,
  `principal` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `ordem` INT NOT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NOT NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NOT NULL,
  `tipo` ENUM('PARTICULAR', 'PROFISSIONAL') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa_arquivo_1`
    FOREIGN KEY (`arquivo_id`)
    REFERENCES `comum`.`arquivo` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_arquivo_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_arquivo_3`
    FOREIGN KEY (`criado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_arquivo_4`
    FOREIGN KEY (`atualizado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pessoa_endereco_2_idx` ON `pessoa`.`pessoa_arquivo` (`pessoa_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_3_idx` ON `pessoa`.`pessoa_arquivo` (`criado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_4_idx` ON `pessoa`.`pessoa_arquivo` (`atualizado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_arquivo_1_idx` ON `pessoa`.`pessoa_arquivo` (`arquivo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `comum`.`email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comum`.`email` ;

CREATE TABLE IF NOT EXISTS `comum`.`email` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(64) NOT NULL,
  `dominio` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `uq_email_1` ON `comum`.`email` (`usuario` ASC, `dominio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_email`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`pessoa_email` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_email` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT UNSIGNED NOT NULL,
  `email_id` INT UNSIGNED NOT NULL,
  `principal` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `ordem` INT NOT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NOT NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NOT NULL,
  `tipo` ENUM('PARTICULAR', 'PROFISSIONAL') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa_email_1`
    FOREIGN KEY (`email_id`)
    REFERENCES `comum`.`email` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_email_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_email_3`
    FOREIGN KEY (`criado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_email_4`
    FOREIGN KEY (`atualizado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pessoa_endereco_2_idx` ON `pessoa`.`pessoa_email` (`pessoa_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_3_idx` ON `pessoa`.`pessoa_email` (`criado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_4_idx` ON `pessoa`.`pessoa_email` (`atualizado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_email_1_idx` ON `pessoa`.`pessoa_email` (`email_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `comum`.`localizacao_tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comum`.`localizacao_tipo` ;

CREATE TABLE IF NOT EXISTS `comum`.`localizacao_tipo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_localizacao_tipo_1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `comum`.`localizacao_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nome_UNIQUE` ON `comum`.`localizacao_tipo` (`nome` ASC) VISIBLE;

CREATE INDEX `fk_localizacao_tipo_1_idx` ON `comum`.`localizacao_tipo` (`pai_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `comum`.`referencia_espacial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comum`.`referencia_espacial` ;

CREATE TABLE IF NOT EXISTS `comum`.`referencia_espacial` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `area` POLYGON NULL,
  `tipo` ENUM('ENDERECO', 'LOCALIZACAO') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comum`.`localizacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comum`.`localizacao` ;

CREATE TABLE IF NOT EXISTS `comum`.`localizacao` (
  `id` INT UNSIGNED NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `localizacao_tipo_id` INT UNSIGNED NOT NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_localizacao_1`
    FOREIGN KEY (`localizacao_tipo_id`)
    REFERENCES `comum`.`localizacao_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_localizacao_2`
    FOREIGN KEY (`pai_id`)
    REFERENCES `comum`.`localizacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_localizacao_3`
    FOREIGN KEY (`id`)
    REFERENCES `comum`.`referencia_espacial` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_localizacao_1_idx` ON `comum`.`localizacao` (`localizacao_tipo_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `uq_localizacao_1` ON `comum`.`localizacao` (`nome` ASC, `localizacao_tipo_id` ASC, `pai_id` ASC) INVISIBLE;

CREATE INDEX `fk_localizacao_2_idx` ON `comum`.`localizacao` (`pai_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `comum`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comum`.`endereco` ;

CREATE TABLE IF NOT EXISTS `comum`.`endereco` (
  `id` INT UNSIGNED NOT NULL,
  `logradouro` VARCHAR(255) NOT NULL,
  `complemento` VARCHAR(255) NULL,
  `numero` VARCHAR(255) NULL,
  `cep` VARCHAR(10) NULL,
  `localizacao_id` INT UNSIGNED NULL,
  `ponto_referencia` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_endereco_1`
    FOREIGN KEY (`localizacao_id`)
    REFERENCES `comum`.`localizacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_2`
    FOREIGN KEY (`id`)
    REFERENCES `comum`.`referencia_espacial` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_endereco_1_idx` ON `comum`.`endereco` (`localizacao_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `uq_endereco_1` ON `comum`.`endereco` (`logradouro` ASC, `complemento` ASC, `numero` ASC, `localizacao_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`pessoa_endereco` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_endereco` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT UNSIGNED NOT NULL,
  `endereco_id` INT UNSIGNED NOT NULL,
  `principal` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `ordem` INT NOT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NOT NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NOT NULL,
  `tipo` ENUM('PARTICULAR', 'PROFISSIONAL') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa_endereco_1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `comum`.`endereco` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_endereco_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_endereco_3`
    FOREIGN KEY (`criado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_endereco_4`
    FOREIGN KEY (`atualizado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pessoa_endereco_1_idx` ON `pessoa`.`pessoa_endereco` (`endereco_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_2_idx` ON `pessoa`.`pessoa_endereco` (`pessoa_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_3_idx` ON `pessoa`.`pessoa_endereco` (`criado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_4_idx` ON `pessoa`.`pessoa_endereco` (`atualizado_usuario_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `comum`.`foto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comum`.`foto` ;

CREATE TABLE IF NOT EXISTS `comum`.`foto` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(300) NOT NULL,
  `extensao` VARCHAR(255) NOT NULL,
  `conteudo` LONGBLOB NOT NULL,
  `tamanho_bytes` INT NOT NULL,
  `md5` VARCHAR(255) NOT NULL,
  `data` DATETIME NULL,
  `local` POINT NULL,
  `autores` VARCHAR(255) NULL,
  `descricao` TEXT NULL,
  `largura_pixel` INT NULL,
  `altura_pixel` INT NULL,
  `resolucao_horizontal_dpi` INT NULL,
  `resolucao_vertical_dpi` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `md5_UNIQUE` ON `comum`.`foto` (`md5` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_foto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`pessoa_foto` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_foto` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT UNSIGNED NOT NULL,
  `foto_id` INT UNSIGNED NOT NULL,
  `principal` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `ordem` INT NOT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NOT NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NOT NULL,
  `tipo` ENUM('PARTICULAR', 'PROFISSIONAL') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa_foto_1`
    FOREIGN KEY (`foto_id`)
    REFERENCES `comum`.`foto` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_foto_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_foto_3`
    FOREIGN KEY (`criado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_foto_4`
    FOREIGN KEY (`atualizado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pessoa_endereco_2_idx` ON `pessoa`.`pessoa_foto` (`pessoa_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_3_idx` ON `pessoa`.`pessoa_foto` (`criado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_4_idx` ON `pessoa`.`pessoa_foto` (`atualizado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_foto_1_idx` ON `pessoa`.`pessoa_foto` (`foto_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `comum`.`telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comum`.`telefone` ;

CREATE TABLE IF NOT EXISTS `comum`.`telefone` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `numero_UNIQUE` ON `comum`.`telefone` (`numero` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_telefone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pessoa`.`pessoa_telefone` ;

CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_telefone` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT UNSIGNED NOT NULL,
  `telefone_id` INT UNSIGNED NOT NULL,
  `principal` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `ordem` INT NOT NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NOT NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NOT NULL,
  `tipo` ENUM('PARTICULAR', 'PROFISSIONAL') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa_telefone_1`
    FOREIGN KEY (`telefone_id`)
    REFERENCES `comum`.`telefone` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_telefone_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_telefone_3`
    FOREIGN KEY (`criado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_telefone_4`
    FOREIGN KEY (`atualizado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_pessoa_endereco_2_idx` ON `pessoa`.`pessoa_telefone` (`pessoa_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_3_idx` ON `pessoa`.`pessoa_telefone` (`criado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_endereco_4_idx` ON `pessoa`.`pessoa_telefone` (`atualizado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_pessoa_telefone_1_idx` ON `pessoa`.`pessoa_telefone` (`telefone_id` ASC) VISIBLE;

USE `comum` ;
USE `produto` ;

-- -----------------------------------------------------
-- Table `produto`.`bem_patrimonial`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto`.`bem_patrimonial` ;

CREATE TABLE IF NOT EXISTS `produto`.`bem_patrimonial` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pessoa_responsavel_id` INT UNSIGNED NOT NULL,
  `identificacao_patrimonial` VARCHAR(255) NOT NULL,
  `observacao` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_bem_patrimonial_1`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`produto` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bem_patrimonial_pessoa1`
    FOREIGN KEY (`pessoa_responsavel_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `identificacao_patrimonial_UNIQUE` ON `produto`.`bem_patrimonial` (`identificacao_patrimonial` ASC) VISIBLE;

CREATE INDEX `fk_bem_patrimonial_pessoa1_idx` ON `produto`.`bem_patrimonial` (`pessoa_responsavel_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `produto`.`composicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto`.`composicao` ;

CREATE TABLE IF NOT EXISTS `produto`.`composicao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pai_id` INT UNSIGNED NOT NULL,
  `produto_id` INT UNSIGNED NOT NULL,
  `inicio` DATETIME NOT NULL,
  `termino` DATETIME NULL,
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NOT NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_composicao_1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `principal`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_composicao_2`
    FOREIGN KEY (`produto_id`)
    REFERENCES `principal`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_composicao_3`
    FOREIGN KEY (`criado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_composicao_4`
    FOREIGN KEY (`atualizado_usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_composicao_1_idx` ON `produto`.`composicao` (`pai_id` ASC) VISIBLE;

CREATE INDEX `fk_composicao_2_idx` ON `produto`.`composicao` (`produto_id` ASC) VISIBLE;

CREATE INDEX `fk_composicao_3_idx` ON `produto`.`composicao` (`criado_usuario_id` ASC) VISIBLE;

CREATE INDEX `fk_composicao_4_idx` ON `produto`.`composicao` (`atualizado_usuario_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `produto`.`marca_produto_tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produto`.`marca_produto_tipo` ;

CREATE TABLE IF NOT EXISTS `produto`.`marca_produto_tipo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca_id` INT UNSIGNED NOT NULL,
  `produto_tipo_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_marca_produto_tipo_marca1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `produto`.`marca` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_marca_produto_tipo_produto_tipo1`
    FOREIGN KEY (`produto_tipo_id`)
    REFERENCES `produto`.`produto_tipo` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_marca_produto_tipo_produto_tipo1_idx` ON `produto`.`marca_produto_tipo` (`produto_tipo_id` ASC) VISIBLE;

CREATE INDEX `fk_marca_produto_tipo_marca1_idx` ON `produto`.`marca_produto_tipo` (`marca_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `uq_marca_produto_tipo_1` ON `produto`.`marca_produto_tipo` (`marca_id` ASC, `produto_tipo_id` ASC) VISIBLE;

USE `oauth2` ;

-- -----------------------------------------------------
-- Table `oauth2`.`oauth_access_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oauth2`.`oauth_access_token` ;

CREATE TABLE IF NOT EXISTS `oauth2`.`oauth_access_token` (
  `token_id` VARCHAR(255) NULL DEFAULT NULL,
  `token` LONGBLOB NULL DEFAULT NULL,
  `authentication_id` VARCHAR(255) NULL DEFAULT NULL,
  `user_name` VARCHAR(255) NULL DEFAULT NULL,
  `client_id` VARCHAR(255) NULL DEFAULT NULL,
  `authentication` LONGBLOB NULL DEFAULT NULL,
  `refresh_token` VARCHAR(255) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oauth2`.`oauth_approvals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oauth2`.`oauth_approvals` ;

CREATE TABLE IF NOT EXISTS `oauth2`.`oauth_approvals` (
  `userid` VARCHAR(255) NULL DEFAULT NULL,
  `clientid` VARCHAR(255) NULL DEFAULT NULL,
  `scope` VARCHAR(255) NULL DEFAULT NULL,
  `status` VARCHAR(10) NULL DEFAULT NULL,
  `expiresat` DATETIME NULL DEFAULT NULL,
  `lastmodifiedat` DATETIME NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oauth2`.`oauth_client_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oauth2`.`oauth_client_details` ;

CREATE TABLE IF NOT EXISTS `oauth2`.`oauth_client_details` (
  `client_id` VARCHAR(255) NOT NULL,
  `resource_ids` VARCHAR(255) NULL DEFAULT NULL,
  `client_secret` VARCHAR(255) NULL DEFAULT NULL,
  `scope` VARCHAR(255) NULL DEFAULT NULL,
  `authorized_grant_types` VARCHAR(255) NULL DEFAULT NULL,
  `web_server_redirect_uri` VARCHAR(255) NULL DEFAULT NULL,
  `authorities` VARCHAR(255) NULL DEFAULT NULL,
  `access_token_validity` INT(11) NULL DEFAULT NULL,
  `refresh_token_validity` INT(11) NULL DEFAULT NULL,
  `additional_information` VARCHAR(255) NULL DEFAULT NULL,
  `autoapprove` VARCHAR(255) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oauth2`.`oauth_client_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oauth2`.`oauth_client_token` ;

CREATE TABLE IF NOT EXISTS `oauth2`.`oauth_client_token` (
  `token_id` VARCHAR(255) NULL DEFAULT NULL,
  `token` LONGBLOB NULL DEFAULT NULL,
  `authentication_id` VARCHAR(255) NULL DEFAULT NULL,
  `user_name` VARCHAR(255) NULL DEFAULT NULL,
  `client_id` VARCHAR(255) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oauth2`.`oauth_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oauth2`.`oauth_code` ;

CREATE TABLE IF NOT EXISTS `oauth2`.`oauth_code` (
  `code` VARCHAR(255) NULL DEFAULT NULL,
  `authentication` VARBINARY(255) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `oauth2`.`oauth_refresh_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oauth2`.`oauth_refresh_token` ;

CREATE TABLE IF NOT EXISTS `oauth2`.`oauth_refresh_token` (
  `token_id` VARCHAR(255) NULL DEFAULT NULL,
  `token` LONGBLOB NULL DEFAULT NULL,
  `authentication` LONGBLOB NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

USE `evento` ;

-- -----------------------------------------------------
-- Table `evento`.`tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `evento`.`tipo` ;

CREATE TABLE IF NOT EXISTS `evento`.`tipo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NULL,
  `nome` VARCHAR(255) NOT NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_evento_tipo_evento_tipo1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `evento`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_evento_tipo_evento_tipo1_idx` ON `evento`.`tipo` (`pai_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `evento`.`evento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `evento`.`evento` ;

CREATE TABLE IF NOT EXISTS `evento`.`evento` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` INT UNSIGNED NOT NULL,
  `local` POINT NULL,
  `data` DATETIME NULL,
  `tipo_id` INT UNSIGNED NOT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_padrao_item`
    FOREIGN KEY (`item_id`)
    REFERENCES `principal`.`item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_evento_tipo1`
    FOREIGN KEY (`tipo_id`)
    REFERENCES `evento`.`tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_padrao_item_idx` ON `evento`.`evento` (`item_id` ASC) VISIBLE;

CREATE INDEX `fk_evento_evento_tipo1_idx` ON `evento`.`evento` (`tipo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `evento`.`participacao_funcao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `evento`.`participacao_funcao` ;

CREATE TABLE IF NOT EXISTS `evento`.`participacao_funcao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NULL,
  `nome` VARCHAR(255) NOT NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_evento_participacao_funcao_evento_participacao_funcao1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `evento`.`participacao_funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_evento_participacao_funcao_evento_participacao_funcao1_idx` ON `evento`.`participacao_funcao` (`pai_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `evento`.`participacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `evento`.`participacao` ;

CREATE TABLE IF NOT EXISTS `evento`.`participacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `evento_id` INT UNSIGNED NOT NULL,
  `item_id` INT UNSIGNED NOT NULL,
  `participacao_funcao_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_evento_participacao_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `evento`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_participacao_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `principal`.`item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evento_participacao_evento_participacao_funcao1`
    FOREIGN KEY (`participacao_funcao_id`)
    REFERENCES `evento`.`participacao_funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_evento_participacao_evento1_idx` ON `evento`.`participacao` (`evento_id` ASC) VISIBLE;

CREATE INDEX `fk_evento_participacao_item1_idx` ON `evento`.`participacao` (`item_id` ASC) VISIBLE;

CREATE INDEX `fk_evento_participacao_evento_participacao_funcao1_idx` ON `evento`.`participacao` (`participacao_funcao_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `evento`.`evidencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `evento`.`evidencia` ;

CREATE TABLE IF NOT EXISTS `evento`.`evidencia` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `evento_id` INT UNSIGNED NOT NULL,
  `descricao` TEXT NULL,
  `evidencia` LONGBLOB NULL,
  `tipo` ENUM('IMAGEM', 'VIDEO', 'AUDIO', 'DOCUMENTO') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_evento_evidencia_evento1`
    FOREIGN KEY (`evento_id`)
    REFERENCES `evento`.`evento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_evento_evidencia_evento1_idx` ON `evento`.`evidencia` (`evento_id` ASC) VISIBLE;

USE `veiculo` ;

-- -----------------------------------------------------
-- Table `veiculo`.`veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `veiculo`.`veiculo` ;

CREATE TABLE IF NOT EXISTS `veiculo`.`veiculo` (
  `id` INT UNSIGNED NOT NULL,
  `placa` VARCHAR(10) NOT NULL,
  `ano_fabricacao` INT NULL,
  `ano_modelo` INT NULL,
  `renavan` VARCHAR(255) NULL,
  `combustivel` SET('GASOLINA', 'ETANOL', 'DIESEL') NULL,
  `cor` VARCHAR(255) NULL,
  `cor_rgb` VARCHAR(6) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_veiculo_produto`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`produto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `funcional` ;

-- -----------------------------------------------------
-- Table `funcional`.`empregador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`empregador` ;

CREATE TABLE IF NOT EXISTS `funcional`.`empregador` (
  `id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_empregador_pessoa_juridica`
    FOREIGN KEY (`id`)
    REFERENCES `pessoa`.`pessoa_juridica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcional`.`empregado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`empregado` ;

CREATE TABLE IF NOT EXISTS `funcional`.`empregado` (
  `id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_empregado_pessoa_fisica1`
    FOREIGN KEY (`id`)
    REFERENCES `pessoa`.`pessoa_fisica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcional`.`cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`cargo` ;

CREATE TABLE IF NOT EXISTS `funcional`.`cargo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcional`.`empregador_cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`empregador_cargo` ;

CREATE TABLE IF NOT EXISTS `funcional`.`empregador_cargo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `empregador_id` INT UNSIGNED NOT NULL,
  `cargo_id` INT UNSIGNED NOT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_empregador_cargo_empregador1`
    FOREIGN KEY (`empregador_id`)
    REFERENCES `funcional`.`empregador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empregador_cargo_cargo1`
    FOREIGN KEY (`cargo_id`)
    REFERENCES `funcional`.`cargo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_empregador_cargo_cargo1_idx` ON `funcional`.`empregador_cargo` (`cargo_id` ASC) VISIBLE;

CREATE INDEX `fk_empregador_cargo_empregador1_idx` ON `funcional`.`empregador_cargo` (`empregador_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `uq_empregador_cargo` ON `funcional`.`empregador_cargo` (`empregador_id` ASC, `cargo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `funcional`.`emprego`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`emprego` ;

CREATE TABLE IF NOT EXISTS `funcional`.`emprego` (
  `id` INT UNSIGNED NOT NULL,
  `matricula` VARCHAR(255) NOT NULL,
  `empregador_cargo_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_padrao_relacionamento1`
    FOREIGN KEY (`id`)
    REFERENCES `pessoa`.`relacionamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emprego_empregador_cargo1`
    FOREIGN KEY (`empregador_cargo_id`)
    REFERENCES `funcional`.`empregador_cargo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_emprego_empregador_cargo1_idx` ON `funcional`.`emprego` (`empregador_cargo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `funcional`.`unidade_organizacional_tipo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`unidade_organizacional_tipo` ;

CREATE TABLE IF NOT EXISTS `funcional`.`unidade_organizacional_tipo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `funcional`.`unidade_organizacional`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`unidade_organizacional` ;

CREATE TABLE IF NOT EXISTS `funcional`.`unidade_organizacional` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `empregador_id` INT UNSIGNED NOT NULL,
  `unidade_organizacional_tipo_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_unidade_organizacional_grupo_social1`
    FOREIGN KEY (`id`)
    REFERENCES `pessoa`.`grupo_social` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_unidade_organizacional_empregador1`
    FOREIGN KEY (`empregador_id`)
    REFERENCES `funcional`.`empregador` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_unidade_organizacional_unidade_organizacional_tipo1`
    FOREIGN KEY (`unidade_organizacional_tipo_id`)
    REFERENCES `funcional`.`unidade_organizacional_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_unidade_organizacional_empregador1_idx` ON `funcional`.`unidade_organizacional` (`empregador_id` ASC) VISIBLE;

CREATE INDEX `fk_unidade_organizacional_unidade_organizacional_tipo1_idx` ON `funcional`.`unidade_organizacional` (`unidade_organizacional_tipo_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `funcional`.`unidade_organizacional_gestor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`unidade_organizacional_gestor` ;

CREATE TABLE IF NOT EXISTS `funcional`.`unidade_organizacional_gestor` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `unidade_organizacional_id` INT UNSIGNED NOT NULL,
  `empregado_id` INT UNSIGNED NOT NULL,
  `inicio` DATETIME NOT NULL,
  `termino` DATETIME NULL,
  `substituto` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_unidade_organizacional_empregado_unidade_organizacional1`
    FOREIGN KEY (`unidade_organizacional_id`)
    REFERENCES `funcional`.`unidade_organizacional` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_unidade_organizacional_empregado_empregado1`
    FOREIGN KEY (`empregado_id`)
    REFERENCES `funcional`.`empregado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_unidade_organizacional_empregado_empregado1_idx` ON `funcional`.`unidade_organizacional_gestor` (`empregado_id` ASC) VISIBLE;

CREATE INDEX `fk_unidade_organizacional_empregado_unidade_organizacional1_idx` ON `funcional`.`unidade_organizacional_gestor` (`unidade_organizacional_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `uq_unidade_organizacional_gestor` ON `funcional`.`unidade_organizacional_gestor` (`unidade_organizacional_id` ASC, `empregado_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `funcional`.`unidade_organizacional_hierarquia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `funcional`.`unidade_organizacional_hierarquia` ;

CREATE TABLE IF NOT EXISTS `funcional`.`unidade_organizacional_hierarquia` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `unidade_organizacional_principal_id` INT UNSIGNED NOT NULL,
  `unidade_organizacional_id` INT UNSIGNED NOT NULL,
  `tipo` ENUM('GESTAO', 'ASSESSORAMENTO') NOT NULL DEFAULT 'GESTAO',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_padrao_unidade_organizacional1`
    FOREIGN KEY (`unidade_organizacional_principal_id`)
    REFERENCES `funcional`.`unidade_organizacional` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_padrao_unidade_organizacional2`
    FOREIGN KEY (`unidade_organizacional_id`)
    REFERENCES `funcional`.`unidade_organizacional` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_padrao_unidade_organizacional1_idx` ON `funcional`.`unidade_organizacional_hierarquia` (`unidade_organizacional_principal_id` ASC) VISIBLE;

CREATE INDEX `fk_padrao_unidade_organizacional2_idx` ON `funcional`.`unidade_organizacional_hierarquia` (`unidade_organizacional_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Data for table `sistema`.`modulo`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`modulo` (`id`, `codigo`, `nome`, `descricao`, `ativo`) VALUES (1, 'EVEBEM', 'Gestão de Eventos Patrimoniais', 'Gestão de Eventos Patrimoniais', 'S');

COMMIT;


-- -----------------------------------------------------
-- Data for table `sistema`.`funcionalidade`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`funcionalidade` (`id`, `codigo`, `nome`, `descricao`, `ativo`, `pai_id`) VALUES (1, 'USUARIO_SISTEMA', 'Cadastro de Usuários', 'Cadastro de Usuários do sistema', 'S', NULL);
INSERT INTO `sistema`.`funcionalidade` (`id`, `codigo`, `nome`, `descricao`, `ativo`, `pai_id`) VALUES (2, 'PERFIL_SISTEMA', 'Cadastro de Perfis', 'Cadastro de Perfis de Usuários do sistema', 'S', NULL);
INSERT INTO `sistema`.`funcionalidade` (`id`, `codigo`, `nome`, `descricao`, `ativo`, `pai_id`) VALUES (3, 'CONFIGURACAO_SISTEMA', 'Configurações do Sistema', 'Configurações do Sistema', 'S', NULL);
INSERT INTO `sistema`.`funcionalidade` (`id`, `codigo`, `nome`, `descricao`, `ativo`, `pai_id`) VALUES (4, 'HISTORICO_ATIVIDADE_SISTEMA', 'Histórico das atividades do sistema', 'Histórico das atividades dos usuários do sistema', 'S', NULL);
INSERT INTO `sistema`.`funcionalidade` (`id`, `codigo`, `nome`, `descricao`, `ativo`, `pai_id`) VALUES (5, 'FORMA_AUTENTICACAO', 'Forma de Autenticação no sistema', 'Forma de Autenticação de usuários no sistema', 'S', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sistema`.`acao`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`acao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `ordem`, `ativo`, `pai_id`) VALUES (1, 'ACESSAR', 'Acessar', 'Acessar a funcionalidade', 'A', NULL, 'S', NULL);
INSERT INTO `sistema`.`acao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `ordem`, `ativo`, `pai_id`) VALUES (2, 'CONSULTAR', 'Consultar', 'Consultar dados da base de dados', 'R', NULL, 'S', 1);
INSERT INTO `sistema`.`acao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `ordem`, `ativo`, `pai_id`) VALUES (3, 'INCLUIR', 'Incluir', 'Incluir dados na base de dados', 'C', NULL, 'S', 1);
INSERT INTO `sistema`.`acao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `ordem`, `ativo`, `pai_id`) VALUES (4, 'ALTERAR', 'Alterar', 'Alterar dados na base de dados', 'U', NULL, 'S', 2);
INSERT INTO `sistema`.`acao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `ordem`, `ativo`, `pai_id`) VALUES (5, 'EXCLUIR', 'Excluir', 'Excluir dados na base de dados', 'D', NULL, 'S', 2);
INSERT INTO `sistema`.`acao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `ordem`, `ativo`, `pai_id`) VALUES (6, 'EXECUTAR', 'Executar', 'Executar ação na funcionalidade', 'E', NULL, 'S', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sistema`.`funcionalidade_acao`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (1, 1, 1, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (2, 1, 2, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (3, 1, 3, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (4, 1, 4, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (5, 1, 5, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (6, 2, 1, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (7, 2, 2, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (8, 2, 3, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (9, 2, 4, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (10, 2, 5, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (11, 3, 1, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (12, 3, 2, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (13, 3, 4, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (14, 4, 1, 'PERFIL', NULL, 'S', NULL);
INSERT INTO `sistema`.`funcionalidade_acao` (`id`, `funcionalidade_id`, `acao_id`, `concede_acesso_a`, `descricao`, `ativo`, `pai_id`) VALUES (15, 4, 2, 'PERFIL', NULL, 'S', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sistema`.`modulo_funcionalidade_acao`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (1, 1, 1, NULL, 'S', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (2, 1, 2, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (3, 1, 3, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (4, 1, 4, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (5, 1, 5, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (6, 1, 6, NULL, 'S', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (7, 1, 7, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (8, 1, 8, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (9, 1, 9, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (10, 1, 10, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (11, 1, 11, NULL, 'S', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (12, 1, 12, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (13, 1, 13, NULL, 'N', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (14, 1, 14, NULL, 'S', NULL, 'S');
INSERT INTO `sistema`.`modulo_funcionalidade_acao` (`id`, `modulo_id`, `funcionalidade_acao_id`, `grupo_menu`, `exibir_menu_principal`, `ordem`, `ativo`) VALUES (15, 1, 15, NULL, 'N', NULL, 'S');

COMMIT;


-- -----------------------------------------------------
-- Data for table `sistema`.`perfil`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`perfil` (`id`, `codigo`, `nome`, `descricao`, `administrador`, `ativo`) VALUES (1, 'ADMINISTRADOR', 'Administrador do Sistema', 'Todas as funcionalidades estão habilitadas para este perfil', 'S', 'S');
INSERT INTO `sistema`.`perfil` (`id`, `codigo`, `nome`, `descricao`, `administrador`, `ativo`) VALUES (2, 'OPERADOR', 'Operador do Sistema', 'Perfil de operação do sistema, exceto configurações', 'N', 'S');

COMMIT;


-- -----------------------------------------------------
-- Data for table `sistema`.`usuario`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`usuario` (`id`, `tipo`, `nome`, `login`, `senha`, `email`, `foto`, `pessoa_id`, `permitir_heranca_perfis`, `ultimo_perfil_id`, `observacao`, `ativo`, `criado_em`, `criado_usuario_id`, `atualizado_em`, `atualizado_usuario_id`) VALUES (1, 'ADMIN', 'Administrador do Sistema', 'admin', NULL, NULL, NULL, NULL, DEFAULT, NULL, NULL, DEFAULT, DEFAULT, NULL, DEFAULT, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `sistema`.`forma_autenticacao`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`forma_autenticacao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `config`, `padrao`, `ordem`, `ativo`) VALUES (1, 'MEMORIA', 'Memória Interna do Sistema', 'Senha fixa armazenada na memória interna do sistema, não há possibilidade de troca da senha, logo esta forma deve ser utilizada somente para a configuração inicial do sistema e posteriormente ser desabilitada', 'MEMORIA', '{\"senha\": \"Aa1111\"}', 'N', 6, 'S');
INSERT INTO `sistema`.`forma_autenticacao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `config`, `padrao`, `ordem`, `ativo`) VALUES (2, 'LOGIN_USUARIO', 'Busca pelo campo LOGIN da tabela de usuários', 'Busca pelo campo login da tabela de usuários', 'BD', '{\"usuario_id\": \"select id from sistema.usuario where login = :chave\"}', 'S', 4, 'S');
INSERT INTO `sistema`.`forma_autenticacao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `config`, `padrao`, `ordem`, `ativo`) VALUES (3, 'EMAIL_USUARIO', 'Busca pelo campo EMAIL da tabela de usuários', 'Busca pelo campo email da tabela de usuários', 'BD', '{\"usuario_id\": \"select id from sistema.usuario where email = :chave\"}', 'S', 5, 'S');
INSERT INTO `sistema`.`forma_autenticacao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `config`, `padrao`, `ordem`, `ativo`) VALUES (4, 'LDAP_PRINCIPAL', 'Busca pelo diretorio LDAP', 'Busca o usuário por algum diretório LDAP', 'LDAP', NULL, 'N', 3, 'N');
INSERT INTO `sistema`.`forma_autenticacao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `config`, `padrao`, `ordem`, `ativo`) VALUES (5, 'GOOGLE', 'Busca pela identificação Google', 'Busca o usuário pela identificação Externa Google', 'EXTERNO', NULL, 'S', 2, 'N');
INSERT INTO `sistema`.`forma_autenticacao` (`id`, `codigo`, `nome`, `descricao`, `tipo`, `config`, `padrao`, `ordem`, `ativo`) VALUES (6, 'FACEBOOK', 'Busca pela identificação Facebook', 'Busca o usuário pela identificação Externa Facebook', 'EXTERNO', NULL, 'S', 1, 'N');

COMMIT;


-- -----------------------------------------------------
-- Data for table `sistema`.`configuracao`
-- -----------------------------------------------------
START TRANSACTION;
USE `sistema`;
INSERT INTO `sistema`.`configuracao` (`id`, `codigo`, `nome`, `descricao`, `valor`, `usuario_id`, `modulo_id`, `pai_id`, `ativo`, `criado_em`, `criado_usuario_id`, `atualizado_em`, `atualizado_usuario_id`) VALUES (DEFAULT, 'HISTORICO_ATIVIDADE_TEMPO', 'Tempo de guarda do histórico de Atividades', 'Tempo em dias para manter a guarda do histórico de atividades', '{\"tempo\": 30}', NULL, NULL, NULL, DEFAULT, DEFAULT, 1, DEFAULT, 1);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
