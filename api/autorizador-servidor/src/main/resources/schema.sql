-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema dfrural
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema oauth2
-- -----------------------------------------------------
-- controle do oauth
DROP SCHEMA IF EXISTS `oauth2` ;

-- -----------------------------------------------------
-- Schema oauth2
--
-- controle do oauth
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oauth2` ;
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
ENGINE = InnoDB;


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
ENGINE = InnoDB;


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
ENGINE = InnoDB;


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
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oauth2`.`oauth_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oauth2`.`oauth_code` ;

CREATE TABLE IF NOT EXISTS `oauth2`.`oauth_code` (
  `code` VARCHAR(255) NULL DEFAULT NULL,
  `authentication` VARBINARY(255) NULL DEFAULT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oauth2`.`oauth_refresh_token`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `oauth2`.`oauth_refresh_token` ;

CREATE TABLE IF NOT EXISTS `oauth2`.`oauth_refresh_token` (
  `token_id` VARCHAR(255) NULL DEFAULT NULL,
  `token` LONGBLOB NULL DEFAULT NULL,
  `authentication` LONGBLOB NULL DEFAULT NULL)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
