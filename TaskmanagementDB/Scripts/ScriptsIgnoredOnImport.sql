
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, and Azure
-- --------------------------------------------------
-- Date Created: 03/30/2013 16:48:31
-- Generated from EDMX file: D:\git\TaskManagement\TaskManagement\Models\Taskmanagement.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO

USE [TaskManagement];
GO

IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Personel_Position]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Personel] DROP CONSTRAINT [FK_Personel_Position];
GO

IF OBJECT_ID(N'[dbo].[FK_Project_ProjectCategory1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Project] DROP CONSTRAINT [FK_Project_ProjectCategory1];
GO

IF OBJECT_ID(N'[dbo].[FK_ProjectPersonel_Personel1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectPersonel] DROP CONSTRAINT [FK_ProjectPersonel_Personel1];
GO

IF OBJECT_ID(N'[dbo].[FK_ProjectPersonel_Project]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProjectPersonel] DROP CONSTRAINT [FK_ProjectPersonel_Project];
GO

IF OBJECT_ID(N'[dbo].[FK_Task_Personel]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Task] DROP CONSTRAINT [FK_Task_Personel];
GO

IF OBJECT_ID(N'[dbo].[FK_Task_Project]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Task] DROP CONSTRAINT [FK_Task_Project];
GO

IF OBJECT_ID(N'[dbo].[FK_WorkDay_Task]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[WorkDay] DROP CONSTRAINT [FK_WorkDay_Task];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Admin]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Admin];
GO

IF OBJECT_ID(N'[dbo].[Personel]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Personel];
GO

IF OBJECT_ID(N'[dbo].[Position]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Position];
GO

IF OBJECT_ID(N'[dbo].[Project]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Project];
GO

IF OBJECT_ID(N'[dbo].[ProjectCategory]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProjectCategory];
GO

IF OBJECT_ID(N'[dbo].[ProjectPersonel]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProjectPersonel];
GO

IF OBJECT_ID(N'[dbo].[Task]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Task];
GO

IF OBJECT_ID(N'[dbo].[WorkDay]', 'U') IS NOT NULL
    DROP TABLE [dbo].[WorkDay];
GO


-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------

GO
