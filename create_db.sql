-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
 SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'Employees_dir'
-- Таблица-справочник сотрудников
-- ---

DROP TABLE IF EXISTS `Employees_dir`;
		
CREATE TABLE `Employees_dir` (
  `employee_key` INTEGER NOT NULL AUTO_INCREMENT,
  `employee_firstname` VARCHAR(50) NULL DEFAULT NULL,
  `employee_lastname` VARCHAR(50) NULL DEFAULT NULL,
  `team_key` INTEGER NOT NULL,
  `employee_enabled` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`employee_key`)
) COMMENT 'Таблица-справочник сотрудников';

-- ---
-- Table 'Intervals_dir'
-- Таблица для хранения периодов голосования
-- ---

DROP TABLE IF EXISTS `Intervals_dir`;
		
CREATE TABLE `Intervals_dir` (
  `interval_key` INTEGER NOT NULL AUTO_INCREMENT,
  `interval_start` DATETIME NULL DEFAULT NULL,
  `interval_end` DATETIME NULL DEFAULT NULL,
  `interval_name` VARCHAR(50) NULL DEFAULT NULL,
  `interval_enabled` BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (`interval_key`)
) COMMENT 'Таблица для хранения периодов голосования';

-- ---
-- Table 'Teams_dir'
-- Таблица-справочник команд тестирования
-- ---

DROP TABLE IF EXISTS `Teams_dir`;
		
CREATE TABLE `Teams_dir` (
  `team_key` INTEGER NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(50) NULL DEFAULT NULL,
  `team_rate` DOUBLE NOT NULL DEFAULT 1, -- коэффициент команды = MIN(колво сотрудников одной команды)/(колво сотрудников текущей команды)
  PRIMARY KEY (`team_key`)
) COMMENT 'Таблица-справочник команд тестирования';

-- ---
-- Table 'Requests'
-- Таблица для учета голосов
-- ---

DROP TABLE IF EXISTS `Requests`;
		
CREATE TABLE `Requests` (
  `request_key` INTEGER NOT NULL AUTO_INCREMENT,
  `voter_key` INTEGER NOT NULL,
  `employee_key` INTEGER NOT NULL,
  `reason_key` INTEGER NOT NULL,
  `interval_key` INTEGER NOT NULL,
  `request_version` INTEGER NULL DEFAULT 0,
  `request_timestamp` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`request_key`)
) COMMENT 'Таблица для учета голосов';

-- ---
-- Table 'Voters'
-- Таблица сотрудников подавших голос
-- ---

DROP TABLE IF EXISTS `Voters`;
		
CREATE TABLE `Voters` (
  `voter_key` INTEGER NOT NULL AUTO_INCREMENT,
  `employee_key` INTEGER NOT NULL,
  PRIMARY KEY (`voter_key`)
) COMMENT 'Таблица сотрудников подавших голос';

-- ---
-- Table 'Reasons'
-- Причина выбора сотрудника, его успехи и достижения за период
-- ---

DROP TABLE IF EXISTS `Reasons`;
		
CREATE TABLE `Reasons` (
  `reason_key` INTEGER NOT NULL AUTO_INCREMENT,
  `reason_text` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`reason_key`)
) COMMENT 'Причина выбора сотрудника, его успехи и достижения за период';

-- ---
-- Foreign Keys 
-- ---

ALTER TABLE `Employees_dir` ADD FOREIGN KEY (team_key) REFERENCES `Teams_dir` (`team_key`);
ALTER TABLE `Requests` ADD FOREIGN KEY (voter_key) REFERENCES `Voters` (`voter_key`);
ALTER TABLE `Requests` ADD FOREIGN KEY (employee_key) REFERENCES `Employees_dir` (`employee_key`);
ALTER TABLE `Requests` ADD FOREIGN KEY (reason_key) REFERENCES `Reasons` (`reason_key`);
ALTER TABLE `Requests` ADD FOREIGN KEY (interval_key) REFERENCES `Intervals_dir` (`interval_key`);
ALTER TABLE `Voters` ADD FOREIGN KEY (employee_key) REFERENCES `Employees_dir` (`employee_key`);

-- ---
-- Table Properties
-- ---

-- ALTER TABLE `Employees_dir` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Intervals_dir` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Teams_dir` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Requests` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Applicants` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
-- ALTER TABLE `Reasons` ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ---
-- Test Data
-- ---

-- INSERT INTO `Employees_dir` (`employee_key`,`employee_firstname`,`employee_lastname`,`team_key`,`employee_enabled`) VALUES
-- ('','','','','');
-- INSERT INTO `Intervals_dir` (`interval_key`,`interval_start`,`interval_end`,`interval_name`,`interval_enabled`) VALUES
-- ('','','','','');
-- INSERT INTO `Teams_dir` (`team_key`,`team_name`) VALUES
-- ('','');
-- INSERT INTO `Requests` (`request_key`,`applicant_key`,`employee_key`,`reason_key`,`interval_key`,`request_version`,`request_timestamp`) VALUES
-- ('','','','','','','');
-- INSERT INTO `Applicants` (`applicant_key`,`employee_key`) VALUES
-- ('','');
-- INSERT INTO `Reasons` (`reason_key`,`reason_text`) VALUES
-- ('','');

