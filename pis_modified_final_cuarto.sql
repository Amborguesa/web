/*
SQLyog Ultimate v11.11 (32 bit)
MySQL - 8.0.30 : Database - pis
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pis` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `pis`;

/*Table structure for table `cuentas` */

DROP TABLE IF EXISTS `cuentas`;

CREATE TABLE `cuentas` (
  `ID_cuenta` int NOT NULL AUTO_INCREMENT,
  `codigocuenta` varchar(20) NOT NULL,
  `nombrecuenta` varchar(100) NOT NULL,
  `tipocuenta` varchar(50) NOT NULL,
  `descripcion` text,
  `id_cuentaPadre` int DEFAULT NULL,
  `nivel` int NOT NULL,
  PRIMARY KEY (`ID_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `cuentas` */

/*Table structure for table `cuentas_mayorizacion` */

DROP TABLE IF EXISTS `cuentas_mayorizacion`;

CREATE TABLE `cuentas_mayorizacion` (
  `id_mayorizacion` int NOT NULL,
  `id_cuentas` int NOT NULL,
  `monto_debe` float DEFAULT NULL,
  `monto_haber` float DEFAULT NULL,
  `id_tipoSaldo` int DEFAULT NULL,
  PRIMARY KEY (`id_mayorizacion`,`id_cuentas`),
  KEY `id_cuentas` (`id_cuentas`),
  KEY `id_tipoSaldo` (`id_tipoSaldo`),
  CONSTRAINT `cuentas_mayorizacion_ibfk_1` FOREIGN KEY (`id_mayorizacion`) REFERENCES `mayorizacion` (`ID_mayorizacion`),
  CONSTRAINT `cuentas_mayorizacion_ibfk_2` FOREIGN KEY (`id_cuentas`) REFERENCES `cuentas` (`ID_cuenta`),
  CONSTRAINT `cuentas_mayorizacion_ibfk_3` FOREIGN KEY (`id_tipoSaldo`) REFERENCES `tipo_saldo` (`ID_tipo_saldo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `cuentas_mayorizacion` */

/*Table structure for table `cuentas_transacciones` */

DROP TABLE IF EXISTS `cuentas_transacciones`;

CREATE TABLE `cuentas_transacciones` (
  `ID_cuenta_transaccion` int NOT NULL AUTO_INCREMENT,
  `id_transaccion` int NOT NULL,
  `id_cuenta` int NOT NULL,
  `id_tipoTransaccion` int DEFAULT NULL,
  `monto` decimal(15,2) NOT NULL,
  PRIMARY KEY (`ID_cuenta_transaccion`),
  KEY `id_transaccion` (`id_transaccion`),
  KEY `id_cuenta` (`id_cuenta`),
  CONSTRAINT `cuentas_transacciones_ibfk_1` FOREIGN KEY (`id_transaccion`) REFERENCES `tipo_transaccion` (`ID_transaccion`),
  CONSTRAINT `cuentas_transacciones_ibfk_2` FOREIGN KEY (`id_cuenta`) REFERENCES `cuentas` (`ID_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `cuentas_transacciones` */

/*Table structure for table `curso` */

DROP TABLE IF EXISTS `curso`;

CREATE TABLE `curso` (
  `ID_curso` int NOT NULL AUTO_INCREMENT,
  `curso` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_curso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `curso` */

/*Table structure for table `docente` */

DROP TABLE IF EXISTS `docente`;

CREATE TABLE `docente` (
  `ID_docente` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `cedula` varchar(20) DEFAULT NULL,
  `id_genero` int DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contactoSOS` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_docente`),
  KEY `id_genero` (`id_genero`),
  CONSTRAINT `docente_ibfk_1` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`ID_genero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `docente` */

/*Table structure for table `est_rep` */

DROP TABLE IF EXISTS `est_rep`;

CREATE TABLE `est_rep` (
  `id_estudiante` int NOT NULL,
  `id_representante` int NOT NULL,
  PRIMARY KEY (`id_estudiante`,`id_representante`),
  KEY `id_representante` (`id_representante`),
  CONSTRAINT `est_rep_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`ID_estudiante`),
  CONSTRAINT `est_rep_ibfk_2` FOREIGN KEY (`id_representante`) REFERENCES `representantes` (`ID_representante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `est_rep` */

/*Table structure for table `estudiantes` */

DROP TABLE IF EXISTS `estudiantes`;

CREATE TABLE `estudiantes` (
  `ID_estudiante` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `cedula` varchar(20) DEFAULT NULL,
  `fecha_nac` datetime DEFAULT NULL,
  `id_genero` int DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contactoSOS` varchar(100) DEFAULT NULL,
  `id_fichaMedica` int DEFAULT NULL,
  PRIMARY KEY (`ID_estudiante`),
  KEY `id_genero` (`id_genero`),
  CONSTRAINT `estudiantes_ibfk_1` FOREIGN KEY (`id_genero`) REFERENCES `generos` (`ID_genero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `estudiantes` */

/*Table structure for table `ficha_medica_doc` */

DROP TABLE IF EXISTS `ficha_medica_doc`;

CREATE TABLE `ficha_medica_doc` (
  `ID_fichaM` int NOT NULL AUTO_INCREMENT,
  `id_docente` int DEFAULT NULL,
  `discapacidad` tinyint(1) DEFAULT NULL,
  `descripcion` text,
  `contactoMedico` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_fichaM`),
  KEY `id_docente` (`id_docente`),
  CONSTRAINT `ficha_medica_doc_ibfk_1` FOREIGN KEY (`id_docente`) REFERENCES `docente` (`ID_docente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ficha_medica_doc` */

/*Table structure for table `ficha_medica_est` */

DROP TABLE IF EXISTS `ficha_medica_est`;

CREATE TABLE `ficha_medica_est` (
  `ID_fichaMedic` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int DEFAULT NULL,
  `discapacidad` tinyint(1) DEFAULT NULL,
  `descripcion` text,
  `contactoMedico` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_fichaMedic`),
  KEY `id_estudiante` (`id_estudiante`),
  CONSTRAINT `ficha_medica_est_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`ID_estudiante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ficha_medica_est` */

/*Table structure for table `generos` */

DROP TABLE IF EXISTS `generos`;

CREATE TABLE `generos` (
  `ID_genero` int NOT NULL AUTO_INCREMENT,
  `genero` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_genero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `generos` */

/*Table structure for table `libros_diarios` */

DROP TABLE IF EXISTS `libros_diarios`;

CREATE TABLE `libros_diarios` (
  `ID_libro_diario` int NOT NULL AUTO_INCREMENT,
  `id_periodoContable` int DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID_libro_diario`),
  KEY `id_periodoContable` (`id_periodoContable`),
  CONSTRAINT `libros_diarios_ibfk_1` FOREIGN KEY (`id_periodoContable`) REFERENCES `periodo_contable` (`ID_periodo_contable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `libros_diarios` */

/*Table structure for table `matriculas` */

DROP TABLE IF EXISTS `matriculas`;

CREATE TABLE `matriculas` (
  `ID_matricula` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `id_periodoAcademico` int DEFAULT NULL,
  `id_curso` int DEFAULT NULL,
  `id_estudiante` int DEFAULT NULL,
  `monto` int DEFAULT NULL,
  PRIMARY KEY (`ID_matricula`),
  KEY `id_periodoAcademico` (`id_periodoAcademico`),
  KEY `id_curso` (`id_curso`),
  KEY `id_estudiante` (`id_estudiante`),
  CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`id_periodoAcademico`) REFERENCES `periodo_academico` (`ID_periodo_academico`),
  CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`ID_curso`),
  CONSTRAINT `matriculas_ibfk_3` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`ID_estudiante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `matriculas` */

/*Table structure for table `mayorizacion` */

DROP TABLE IF EXISTS `mayorizacion`;

CREATE TABLE `mayorizacion` (
  `ID_mayorizacion` int NOT NULL AUTO_INCREMENT,
  `id_periodoContable` int DEFAULT NULL,
  PRIMARY KEY (`ID_mayorizacion`),
  KEY `id_periodoContable` (`id_periodoContable`),
  CONSTRAINT `mayorizacion_ibfk_1` FOREIGN KEY (`id_periodoContable`) REFERENCES `periodo_contable` (`ID_periodo_contable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `mayorizacion` */

/*Table structure for table `mensualidades` */

DROP TABLE IF EXISTS `mensualidades`;

CREATE TABLE `mensualidades` (
  `ID_mensualidad` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `id_estudiante` int DEFAULT NULL,
  `id_mes` int DEFAULT NULL,
  `id_periodoAcademico` int DEFAULT NULL,
  `monto` int DEFAULT NULL,
  PRIMARY KEY (`ID_mensualidad`),
  KEY `id_estudiante` (`id_estudiante`),
  KEY `id_mes` (`id_mes`),
  KEY `id_periodoAcademico` (`id_periodoAcademico`),
  CONSTRAINT `mensualidades_ibfk_1` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`ID_estudiante`),
  CONSTRAINT `mensualidades_ibfk_2` FOREIGN KEY (`id_mes`) REFERENCES `mes` (`ID_mes`),
  CONSTRAINT `mensualidades_ibfk_3` FOREIGN KEY (`id_periodoAcademico`) REFERENCES `periodo_academico` (`ID_periodo_academico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `mensualidades` */

/*Table structure for table `mes` */

DROP TABLE IF EXISTS `mes`;

CREATE TABLE `mes` (
  `ID_mes` int NOT NULL AUTO_INCREMENT,
  `mes` int DEFAULT NULL,
  PRIMARY KEY (`ID_mes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `mes` */

/*Table structure for table `periodo_academico` */

DROP TABLE IF EXISTS `periodo_academico`;

CREATE TABLE `periodo_academico` (
  `ID_periodo_academico` int NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`ID_periodo_academico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `periodo_academico` */

/*Table structure for table `periodo_contable` */

DROP TABLE IF EXISTS `periodo_contable`;

CREATE TABLE `periodo_contable` (
  `ID_periodo_contable` int NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`ID_periodo_contable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `periodo_contable` */

/*Table structure for table `puestos` */

DROP TABLE IF EXISTS `puestos`;

CREATE TABLE `puestos` (
  `ID_puesto` int NOT NULL AUTO_INCREMENT,
  `id_libroDiario` int DEFAULT NULL,
  `num_puesto` int DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `detalles` text,
  PRIMARY KEY (`ID_puesto`),
  KEY `id_libroDiario` (`id_libroDiario`),
  CONSTRAINT `puestos_ibfk_1` FOREIGN KEY (`id_libroDiario`) REFERENCES `libros_diarios` (`ID_libro_diario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `puestos` */

/*Table structure for table `representantes` */

DROP TABLE IF EXISTS `representantes`;

CREATE TABLE `representantes` (
  `ID_representante` int NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `cedula` varchar(20) DEFAULT NULL,
  `direccion` text,
  `telefono` varchar(20) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `contactoSOS` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID_representante`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `representantes` */

/*Table structure for table `sumas_saldos` */

DROP TABLE IF EXISTS `sumas_saldos`;

CREATE TABLE `sumas_saldos` (
  `ID_sumas_saldos` int NOT NULL AUTO_INCREMENT,
  `id_periodoContable` int DEFAULT NULL,
  `id_codigoCuenta` int DEFAULT NULL,
  `id_cuenta` int DEFAULT NULL,
  `total_suma_debe` float DEFAULT NULL,
  `total_suma_haber` float DEFAULT NULL,
  `total_saldo_deudor` float DEFAULT NULL,
  `total_saldo_acreedor` float DEFAULT NULL,
  PRIMARY KEY (`ID_sumas_saldos`),
  KEY `id_periodoContable` (`id_periodoContable`),
  KEY `id_cuenta` (`id_cuenta`),
  CONSTRAINT `sumas_saldos_ibfk_1` FOREIGN KEY (`id_periodoContable`) REFERENCES `periodo_contable` (`ID_periodo_contable`),
  CONSTRAINT `sumas_saldos_ibfk_2` FOREIGN KEY (`id_cuenta`) REFERENCES `cuentas` (`ID_cuenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `sumas_saldos` */

/*Table structure for table `tipo_saldo` */

DROP TABLE IF EXISTS `tipo_saldo`;

CREATE TABLE `tipo_saldo` (
  `ID_tipo_saldo` int NOT NULL AUTO_INCREMENT,
  `tipo_saldo` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_tipo_saldo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tipo_saldo` */

/*Table structure for table `tipo_transaccion` */

DROP TABLE IF EXISTS `tipo_transaccion`;

CREATE TABLE `tipo_transaccion` (
  `ID_transaccion` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_transaccion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tipo_transaccion` */

/*Table structure for table `transacciones` */

DROP TABLE IF EXISTS `transacciones`;

CREATE TABLE `transacciones` (
  `ID_transaccion` int NOT NULL AUTO_INCREMENT,
  `id_puesto` int NOT NULL,
  PRIMARY KEY (`ID_transaccion`),
  KEY `id_puesto` (`id_puesto`),
  CONSTRAINT `transacciones_ibfk_1` FOREIGN KEY (`id_puesto`) REFERENCES `puestos` (`ID_puesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `transacciones` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`username`,`password`,`role`,`created_at`,`status`) values (1,'admin','$2y$10$fHow1ZpLMRGoGVKxWYkABOc9RHt68u6EV3IuI8g5XfpukJA2tk6QK','admin','2024-07-26 22:29:53','active'),(2,'secretaria','$2y$10$cZEHCT7Cmv1SCeCYb3c7E.53MxNgEZ2EmAYkf9Qz4aByA8VYmVHTq','secretaria','2024-07-26 22:29:53','active'),(4,'contador','$2y$10$ew5EmLRjMYQsR8YvvsZSmufSpn.jPwRpxvW0c2TpF1PayATmM3iha','contador','2024-07-27 00:33:34','active'),(25,'edrian','$2y$10$s9tFZHYjr6XUi5NLJMtrsuuqeCR1SWB5UJPcaiK9KYlSu4RSoR1w.','contador','2024-07-27 18:45:51','active'),(27,'guido','$2y$10$nemijhAUDX2.jLzOJBMRiOsYcn3jQcNplEqwpYZuufFU1uDdN.X8i','secretaria','2024-07-27 22:41:57','active');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
