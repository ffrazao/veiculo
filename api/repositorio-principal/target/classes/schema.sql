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
USE `principal` ;

-- -----------------------------------------------------
-- Table `principal`.`item`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `produto`.`marca` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `produto`.`produto_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produto`.`produto_tipo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produto_tipo_1_idx` (`pai_id` ASC) VISIBLE,
  CONSTRAINT `fk_produto_tipo_1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `produto`.`produto_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `produto`.`modelo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produto`.`modelo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `produto_tipo_id` INT UNSIGNED NOT NULL,
  `marca_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_versao_1_idx` (`marca_id` ASC) VISIBLE,
  INDEX `fk_versao_3_idx` (`produto_tipo_id` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `principal`.`produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `principal`.`produto` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `modelo_id` INT UNSIGNED NOT NULL,
  `numero_serie` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_produto_2_idx` (`modelo_id` ASC) VISIBLE,
  CONSTRAINT `fk_produto_1`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_2`
    FOREIGN KEY (`modelo_id`)
    REFERENCES `produto`.`modelo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `principal`.`servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `principal`.`servico` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_servico`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `principal`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `principal`.`pessoa` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `tipo` ENUM('PF', 'PJ', 'GS') NOT NULL COMMENT 'Se PF - Pessoa Física\nSe PJ - Pessoa Jurídica\nSe GS - Grupo Social',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pessoa`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`item` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

USE `sistema` ;

-- -----------------------------------------------------
-- Table `sistema`.`modulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`modulo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `sistema`.`funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`funcionalidade` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_funcionalidade_funcionalidade1_idx` (`pai_id` ASC) VISIBLE,
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  CONSTRAINT `fk_funcionalidade_funcionalidade1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `sistema`.`funcionalidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema`.`acao`
-- -----------------------------------------------------
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
  INDEX `fk_acao_acao1_idx` (`pai_id` ASC) VISIBLE,
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  CONSTRAINT `fk_acao_acao1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `sistema`.`acao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema`.`funcionalidade_acao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`funcionalidade_acao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `funcionalidade_id` INT UNSIGNED NOT NULL,
  `acao_id` INT UNSIGNED NOT NULL,
  `concede_acesso_a` ENUM('ANONIMO', 'SEM_PERFIL', 'PERFIL', 'PERFIL_PESSOAL', 'PERFIL_FUNCIONAL') NOT NULL DEFAULT 'PERFIL' COMMENT 'ANONIMO - Disponível a todos os usuários que efetuaram login ou não\nSEM_PERFIL - Disponível a todos os usuários que efetuaram login\nPERFIL - Disponível a todos os usuários que efetuaram login e que tenha registro na tabela de privilégios com acesso a funcionalidade/acao\nPERFIL_PESSOAL - Disponível a todos os usuários que efetuaram login, que tenha registro na tabela de privilégios com acesso a funcionalidade/acao e que tenha registro de pessoa vinculada\nPERFIL_FUNCIONAL - Disponível a todos os usuários que efetuaram login, que tenha registro na tabela de privilégios com acesso a funcionalidade/acao, que tenha registro de pessoa vinculada e que a pessoa vinculada tenha registro de emprego vinculado',
  `descricao` TEXT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_funcionalidade_acao` (`funcionalidade_id` ASC, `acao_id` ASC) VISIBLE,
  INDEX `fk_funcionalidade_acao_2_idx` (`acao_id` ASC) VISIBLE,
  INDEX `fk_funcionalidade_acao_1_idx` (`funcionalidade_id` ASC) VISIBLE,
  INDEX `fk_funcionalidade_acao_3_idx` (`pai_id` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `sistema`.`modulo_funcionalidade_acao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`modulo_funcionalidade_acao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `modulo_id` INT UNSIGNED NOT NULL,
  `funcionalidade_acao_id` INT UNSIGNED NOT NULL,
  `grupo_menu` VARCHAR(255) NULL,
  `exibir_menu_principal` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `ordem` INT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_modulo_funcionalidade_acao` (`modulo_id` ASC, `funcionalidade_acao_id` ASC) VISIBLE,
  INDEX `fk_modulo_funcionalidade_acao_1` (`modulo_id` ASC) VISIBLE,
  INDEX `fk_modulo_funcionalidade_acao_2_idx` (`funcionalidade_acao_id` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `sistema`.`perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`perfil` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  `administrador` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Se igual a \'S\' informa que o conteúdo da tabela privilegio deve ser ignorado e todas as funcionalidades/ações ativos devem ser concedidas a quem acionar este perfil. Porém, para ativar este perfil, o usuario também deve ser do tipo ADMIN, caso contrário, disparar uma excessão. Só deve haver um registro de perfil com o valor \'S\', todos os demais deve ser igual a \'N\' (este atributo deve ser manipulado somente pelo BD)',
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `sistema`.`privilegio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`privilegio` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `perfil_id` INT UNSIGNED NOT NULL,
  `funcionalidade_acao_id` INT UNSIGNED NOT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_privilegio` (`perfil_id` ASC, `funcionalidade_acao_id` ASC) VISIBLE,
  INDEX `fk_privilegio_2_idx` (`funcionalidade_acao_id` ASC) VISIBLE,
  INDEX `fk_privilegio_1_idx` (`perfil_id` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `sistema`.`usuario_perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`usuario_perfil` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` INT UNSIGNED NOT NULL,
  `perfil_id` INT UNSIGNED NOT NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `padrao` ENUM('S', 'N') NOT NULL DEFAULT 'N' COMMENT 'Se igual a \'S\' indica que este será o perfil acionado, porém, somente se o campo ultimo_usuario_perfil_id do usuário for nulo. O usuário_perfil só pode ter um registro marcado como padrão. Cada usuário tem o seu perfil padrão.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_usuario_perfil` (`usuario_id` ASC, `perfil_id` ASC) VISIBLE,
  INDEX `fk_usuario_perfil_2_idx` (`perfil_id` ASC) INVISIBLE,
  INDEX `fk_usuario_perfil_1_idx` (`usuario_id` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `sistema`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`usuario` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `login` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `senha` VARCHAR(255) NULL,
  `foto` BLOB NULL,
  `pessoa_id` INT UNSIGNED NULL,
  `ultimo_usuario_perfil_id` INT UNSIGNED NULL COMMENT 'memoria do ultimo perfil utilizado no login. No proximo login este será o perfil utilizado. O usuário poderá trocar seu perfil ao executar o sistema',
  `tipo` ENUM('COMUM', 'ADMIN', 'SISTEMA') NOT NULL DEFAULT 'COMUM' COMMENT 'COMUM - usuário comum, somente acesso aos privilégios concedidos\nSISTEMA - usuário de sistema, somente acesso aos privilégios concedidos\nADMIN - usuário administrador, tem acesso a todas as funcionalidades independente de ter privilégio ou não. Este perfil só é acionado se o usuário for do tipo ADMIN e se tiver um perfil com o atributo administrador igual a S.\n',
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  `criado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `criado_usuario_id` INT UNSIGNED NULL,
  `atualizado_em` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `atualizado_usuario_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_1_idx` (`criado_usuario_id` ASC) VISIBLE,
  INDEX `fk_usuario_2_idx` (`atualizado_usuario_id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE,
  INDEX `fk_usuario_3_idx` (`ultimo_usuario_perfil_id` ASC) VISIBLE,
  INDEX `fk_usuario_4_idx` (`pessoa_id` ASC) VISIBLE,
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
    FOREIGN KEY (`ultimo_usuario_perfil_id`)
    REFERENCES `sistema`.`usuario_perfil` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_4`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `sistema`.`forma_autenticacao`
-- -----------------------------------------------------
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
  PRIMARY KEY (`id`),
  UNIQUE INDEX `ordem_UNIQUE` (`ordem` ASC) VISIBLE,
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema`.`usuario_forma_autenticacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistema`.`usuario_forma_autenticacao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario_id` INT UNSIGNED NOT NULL,
  `forma_autenticacao_id` INT UNSIGNED NOT NULL,
  `valor` JSON NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_forma_autenticacao_1_idx` (`usuario_id` ASC) VISIBLE,
  INDEX `fk_usuario_forma_autenticacao_2_idx` (`forma_autenticacao_id` ASC) VISIBLE,
  UNIQUE INDEX `uq_usuario_forma_autenticacao_1` (`usuario_id` ASC, `forma_autenticacao_id` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `sistema`.`token`
-- -----------------------------------------------------
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
  INDEX `fk_token_1_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_token_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sistema`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema`.`historico_atividade`
-- -----------------------------------------------------
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
  INDEX `fk_historico_atividade_idx` (`token_id` ASC) VISIBLE,
  CONSTRAINT `fk_historico_atividade_1`
    FOREIGN KEY (`token_id`)
    REFERENCES `sistema`.`token` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sistema`.`configuracao`
-- -----------------------------------------------------
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
  INDEX `fk_configuracao_1_idx` (`criado_usuario_id` ASC) VISIBLE,
  INDEX `fk_configuracao_2_idx` (`atualizado_usuario_id` ASC) VISIBLE,
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE,
  INDEX `fk_configuracao_3_idx` (`usuario_id` ASC) VISIBLE,
  INDEX `fk_configuracao_4_idx` (`modulo_id` ASC) VISIBLE,
  INDEX `fk_configuracao_5_idx` (`pai_id` ASC) VISIBLE,
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

USE `pessoa` ;

-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_fisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_fisica` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cpf` CHAR(14) NULL,
  `nascimento` DATE NULL,
  `falecimento` DATE NULL,
  `sexo` ENUM('M', 'F') NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_fisica_1`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_juridica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pessoa`.`pessoa_juridica` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cnpj` CHAR(18) NULL,
  `fundacao` DATE NULL,
  `encerramento` DATE NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_juridica_1`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`grupo_social`
-- -----------------------------------------------------
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento_tipo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `codigo` VARCHAR(255) NOT NULL,
  `temporal` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `relacionamento_tipo_id` INT UNSIGNED NOT NULL,
  `inicio` DATETIME NULL,
  `termino` DATETIME NULL,
  `ativo` ENUM('S', 'N') NOT NULL DEFAULT 'S',
  PRIMARY KEY (`id`),
  INDEX `fk_relacionamento_1_idx` (`relacionamento_tipo_id` ASC) VISIBLE,
  CONSTRAINT `fk_relacionamento_1`
    FOREIGN KEY (`relacionamento_tipo_id`)
    REFERENCES `pessoa`.`relacionamento_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento_funcao`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento_pessoa` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `relacionamento_id` INT UNSIGNED NOT NULL,
  `pessoa_id` INT UNSIGNED NOT NULL,
  `relacionamento_funcao_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_relacionamento_pessoa_1_idx` (`relacionamento_id` ASC) VISIBLE,
  INDEX `fk_relacionamento_pessoa_2_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_relacionamento_pessoa_3_idx` (`relacionamento_funcao_id` ASC) VISIBLE,
  UNIQUE INDEX `uq_relacionamento_pessoa_1` (`relacionamento_id` ASC, `pessoa_id` ASC, `relacionamento_funcao_id` ASC) VISIBLE,
  CONSTRAINT `fk_relacionamento_pessoa_1`
    FOREIGN KEY (`relacionamento_id`)
    REFERENCES `pessoa`.`relacionamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relacionamento_pessoa_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_relacionamento_pessoa_3`
    FOREIGN KEY (`relacionamento_funcao_id`)
    REFERENCES `pessoa`.`relacionamento_funcao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`relacionamento_configuracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pessoa`.`relacionamento_configuracao` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `relacionamento_tipo_id` INT UNSIGNED NOT NULL,
  `relacionador_funcao_id` INT UNSIGNED NOT NULL,
  `relacionado_funcao_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_relacionamento_configuracao_1_idx` (`relacionamento_tipo_id` ASC) VISIBLE,
  INDEX `fk_relacionamento_configuracao_2_idx` (`relacionador_funcao_id` ASC) VISIBLE,
  INDEX `fk_relacionamento_configuracao_3_idx` (`relacionado_funcao_id` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `comum`.`arquivo`
-- -----------------------------------------------------
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
  PRIMARY KEY (`id`),
  UNIQUE INDEX `md5_UNIQUE` (`md5` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_arquivo`
-- -----------------------------------------------------
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
  INDEX `fk_pessoa_endereco_2_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_3_idx` (`criado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_4_idx` (`atualizado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_arquivo_1_idx` (`arquivo_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_arquivo_1`
    FOREIGN KEY (`arquivo_id`)
    REFERENCES `comum`.`arquivo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_arquivo_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
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


-- -----------------------------------------------------
-- Table `comum`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comum`.`email` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(64) NOT NULL,
  `dominio` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_email_1` (`usuario` ASC, `dominio` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_email`
-- -----------------------------------------------------
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
  INDEX `fk_pessoa_endereco_2_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_3_idx` (`criado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_4_idx` (`atualizado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_email_1_idx` (`email_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_email_1`
    FOREIGN KEY (`email_id`)
    REFERENCES `comum`.`email` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_email_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
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


-- -----------------------------------------------------
-- Table `comum`.`localizacao_tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comum`.`localizacao_tipo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_localizacao_tipo_1_idx` (`pai_id` ASC) VISIBLE,
  CONSTRAINT `fk_localizacao_tipo_1`
    FOREIGN KEY (`pai_id`)
    REFERENCES `comum`.`localizacao_tipo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comum`.`referencia_espacial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comum`.`referencia_espacial` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `area` POLYGON NULL,
  `tipo` ENUM('ENDERECO', 'LOCALIZACAO') NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comum`.`localizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comum`.`localizacao` (
  `id` INT UNSIGNED NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `localizacao_tipo_id` INT UNSIGNED NOT NULL,
  `pai_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_localizacao_1_idx` (`localizacao_tipo_id` ASC) VISIBLE,
  UNIQUE INDEX `uq_localizacao_1` (`nome` ASC, `localizacao_tipo_id` ASC, `pai_id` ASC) INVISIBLE,
  INDEX `fk_localizacao_2_idx` (`pai_id` ASC) VISIBLE,
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
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comum`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comum`.`endereco` (
  `id` INT UNSIGNED NOT NULL,
  `logradouro` VARCHAR(255) NOT NULL,
  `complemento` VARCHAR(255) NULL,
  `numero` VARCHAR(255) NULL,
  `cep` VARCHAR(10) NULL,
  `localizacao_id` INT UNSIGNED NULL,
  `ponto_referencia` TEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereco_1_idx` (`localizacao_id` ASC) VISIBLE,
  UNIQUE INDEX `uq_endereco_1` (`logradouro` ASC, `complemento` ASC, `numero` ASC, `localizacao_id` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_1`
    FOREIGN KEY (`localizacao_id`)
    REFERENCES `comum`.`localizacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_endereco_2`
    FOREIGN KEY (`id`)
    REFERENCES `comum`.`referencia_espacial` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_endereco`
-- -----------------------------------------------------
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
  INDEX `fk_pessoa_endereco_1_idx` (`endereco_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_2_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_3_idx` (`criado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_4_idx` (`atualizado_usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_endereco_1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `comum`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_endereco_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
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


-- -----------------------------------------------------
-- Table `comum`.`foto`
-- -----------------------------------------------------
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
  PRIMARY KEY (`id`),
  UNIQUE INDEX `md5_UNIQUE` (`md5` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_foto`
-- -----------------------------------------------------
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
  INDEX `fk_pessoa_endereco_2_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_3_idx` (`criado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_4_idx` (`atualizado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_foto_1_idx` (`foto_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_foto_1`
    FOREIGN KEY (`foto_id`)
    REFERENCES `comum`.`foto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_foto_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
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


-- -----------------------------------------------------
-- Table `comum`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `comum`.`telefone` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `numero` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pessoa`.`pessoa_telefone`
-- -----------------------------------------------------
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
  INDEX `fk_pessoa_endereco_2_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_3_idx` (`criado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_endereco_4_idx` (`atualizado_usuario_id` ASC) VISIBLE,
  INDEX `fk_pessoa_telefone_1_idx` (`telefone_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_telefone_1`
    FOREIGN KEY (`telefone_id`)
    REFERENCES `comum`.`telefone` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoa_telefone_2`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `principal`.`pessoa` (`id`)
    ON DELETE NO ACTION
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

USE `comum` ;
USE `produto` ;

-- -----------------------------------------------------
-- Table `produto`.`bem_patrimonial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `produto`.`bem_patrimonial` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `identificacao_patrimonial` VARCHAR(255) NOT NULL,
  `descricao` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `identificacao_patrimonial_UNIQUE` (`identificacao_patrimonial` ASC) VISIBLE,
  CONSTRAINT `fk_bem_patrimonial_1`
    FOREIGN KEY (`id`)
    REFERENCES `principal`.`produto` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `produto`.`composicao`
-- -----------------------------------------------------
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
  INDEX `fk_composicao_1_idx` (`pai_id` ASC) VISIBLE,
  INDEX `fk_composicao_2_idx` (`produto_id` ASC) VISIBLE,
  INDEX `fk_composicao_3_idx` (`criado_usuario_id` ASC) VISIBLE,
  INDEX `fk_composicao_4_idx` (`atualizado_usuario_id` ASC) VISIBLE,
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

CREATE USER IF NOT EXISTS 'evbem'@'%' IDENTIFIED BY 'evbem';

GRANT ALL ON comum.* TO 'evbem'@'%';
GRANT ALL ON pessoa.* TO 'evbem'@'%';
GRANT ALL ON principal.* TO 'evbem'@'%';
GRANT ALL ON produto.* TO 'evbem'@'%';
GRANT ALL ON sistema.* TO 'evbem'@'%';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
