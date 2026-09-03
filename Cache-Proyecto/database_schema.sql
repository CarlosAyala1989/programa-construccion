-- Script de Creación de Base de Datos MySQL para la Plataforma de Gobernanza
-- Credenciales Locales Recomendadas para Desarrollo:
-- Usuario: root
-- Contraseña: (vacía) o root
-- Puerto: 3306

CREATE DATABASE IF NOT EXISTS `gobernanza_db`;
USE `gobernanza_db`;

-- -----------------------------------------------------
-- Tabla: User
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `User` (
  `id` VARCHAR(191) NOT NULL,
  `name` VARCHAR(191) NOT NULL,
  `email` VARCHAR(191) NOT NULL,
  `password` VARCHAR(191) NOT NULL,
  `role` VARCHAR(191) NOT NULL DEFAULT 'EMPLOYEE',
  `isActive` BOOLEAN NOT NULL DEFAULT 1,
  `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` DATETIME(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `User_email_key` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Tabla: Workspace
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Workspace` (
  `id` VARCHAR(191) NOT NULL,
  `name` VARCHAR(191) NOT NULL,
  `cloudPath` VARCHAR(191) NOT NULL,
  `defaultPassword` VARCHAR(191) NOT NULL,
  `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` DATETIME(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Tabla: _UserWorkspaces (Relación Muchos a Muchos)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `_UserWorkspaces` (
  `A` VARCHAR(191) NOT NULL,
  `B` VARCHAR(191) NOT NULL,
  UNIQUE INDEX `_UserWorkspaces_AB_unique` (`A`, `B`),
  INDEX `_UserWorkspaces_B_index` (`B`),
  CONSTRAINT `_UserWorkspaces_A_fkey` FOREIGN KEY (`A`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `_UserWorkspaces_B_fkey` FOREIGN KEY (`B`) REFERENCES `Workspace` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Tabla: SecurityPolicy
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SecurityPolicy` (
  `id` VARCHAR(191) NOT NULL,
  `type` VARCHAR(191) NOT NULL,
  `target` VARCHAR(191) NOT NULL,
  `password` VARCHAR(191) NOT NULL,
  `priority` INTEGER NOT NULL DEFAULT 0,
  `workspaceId` VARCHAR(191) NULL,
  `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` DATETIME(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Tabla: AuditLog
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AuditLog` (
  `id` VARCHAR(191) NOT NULL,
  `userId` VARCHAR(191) NULL,
  `userName` VARCHAR(191) NULL,
  `action` VARCHAR(191) NOT NULL,
  `details` TEXT NOT NULL,
  `status` VARCHAR(191) NOT NULL,
  `workspaceId` VARCHAR(191) NULL,
  `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Tabla: Config (Configuración Global del Sistema)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Config` (
  `id` VARCHAR(191) NOT NULL,
  `compressionEnabled` BOOLEAN NOT NULL DEFAULT 0,
  `compressionThresholdMb` INTEGER NOT NULL DEFAULT 10,
  `deleteLocalAfterUpload` BOOLEAN NOT NULL DEFAULT 0,
  `cloudProvider` VARCHAR(191) NOT NULL DEFAULT 'MANUAL',
  `cloudCredentials` TEXT NULL,
  `updatedAt` DATETIME(3) NOT NULL,
  `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Tabla: NomenclatureField (Campos de Nomenclatura)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NomenclatureField` (
  `id` VARCHAR(191) NOT NULL,
  `fieldName` VARCHAR(191) NOT NULL,
  `fieldOrder` INTEGER NOT NULL DEFAULT 0,
  `isRequired` BOOLEAN NOT NULL DEFAULT 1,
  `separator` VARCHAR(10) NOT NULL DEFAULT '_',
  `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `updatedAt` DATETIME(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------------
-- Inserción del Administrador por Defecto
-- Contraseña hash para: admin123
-- -----------------------------------------------------
INSERT INTO `User` (`id`, `name`, `email`, `password`, `role`, `isActive`, `updatedAt`) 
VALUES (
  'admin-uuid-1234', 
  'Administrador Global', 
  'admin@empresa.com', 
  '$2b$10$0v6r0WSa4OL5vwq2IMvaFeUP6wZa6HShqu/YOna2ahaRHhJuxJnVC', 
  'ADMIN', 
  1, 
  CURRENT_TIMESTAMP(3)
) ON DUPLICATE KEY UPDATE `email` = `email`;

-- -----------------------------------------------------
-- Inserción de Configuración por Defecto
-- -----------------------------------------------------
INSERT INTO `Config` (`id`, `compressionEnabled`, `compressionThresholdMb`, `deleteLocalAfterUpload`, `cloudProvider`, `updatedAt`)
VALUES ('default-config-1', 0, 10, 0, 'MANUAL', CURRENT_TIMESTAMP(3))
ON DUPLICATE KEY UPDATE `id` = `id`;
