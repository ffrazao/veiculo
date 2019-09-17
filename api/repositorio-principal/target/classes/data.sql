-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

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
INSERT INTO `sistema`.`usuario` (`id`, `nome`, `login`, `email`, `senha`, `foto`, `pessoa_id`, `ultimo_usuario_perfil_id`, `tipo`, `ativo`, `criado_em`, `criado_usuario_id`, `atualizado_em`, `atualizado_usuario_id`) VALUES (1, 'Administrador do Sistema', 'admin', NULL, NULL, NULL, NULL, NULL, 'ADMIN', DEFAULT, DEFAULT, NULL, DEFAULT, NULL);

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
