-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema medelliin
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema medelliin
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `medelliin` DEFAULT CHARACTER SET utf8mb3 ;
USE `medelliin` ;

-- -----------------------------------------------------
-- Table `medelliin`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medelliin`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `medelliin`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medelliin`.`events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event` VARCHAR(45) NULL DEFAULT NULL,
  `location` VARCHAR(45) NULL DEFAULT NULL,
  `attendees` INT NULL DEFAULT NULL,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_events_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_events_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `medelliin`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `medelliin`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `medelliin`.`messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sender_id1` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_messages_users_idx` (`receiver_id` ASC) VISIBLE,
  INDEX `fk_messages_users1_idx` (`sender_id1` ASC) VISIBLE,
  CONSTRAINT `fk_messages_users`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `medelliin`.`users` (`id`),
  CONSTRAINT `fk_messages_users1`
    FOREIGN KEY (`sender_id1`)
    REFERENCES `medelliin`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
