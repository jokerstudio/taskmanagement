﻿/*
Deployment script for Taskmanagement

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Taskmanagement"
:setvar DefaultFilePrefix "Taskmanagement"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[Admins]...';


GO
CREATE TABLE [dbo].[Admins] (
    [AdminID]  INT          IDENTITY (1, 1) NOT NULL,
    [Username] VARCHAR (50) NOT NULL,
    [Password] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_Admins] PRIMARY KEY CLUSTERED ([AdminID] ASC)
);


GO
PRINT N'Creating [dbo].[Personels]...';


GO
CREATE TABLE [dbo].[Personels] (
    [PersonnelID] INT           IDENTITY (1, 1) NOT NULL,
    [Name]        VARCHAR (50)  NULL,
    [PositionID]  INT           NULL,
    [Birthday]    DATETIME      NULL,
    [Address]     VARCHAR (MAX) NULL,
    [Phone]       VARCHAR (10)  NULL,
    [IDCard]      VARCHAR (13)  NULL,
    [Username]    VARCHAR (50)  NULL,
    [Password]    VARCHAR (50)  NULL,
    [IsActive]    INT           NULL,
    CONSTRAINT [PK_Personels] PRIMARY KEY CLUSTERED ([PersonnelID] ASC)
);


GO
PRINT N'Creating [dbo].[Personels].[IX_FK_Personel_Position]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_Personel_Position]
    ON [dbo].[Personels]([PositionID] ASC);


GO
PRINT N'Creating [dbo].[Positions]...';


GO
CREATE TABLE [dbo].[Positions] (
    [PositionID]   INT           IDENTITY (1, 1) NOT NULL,
    [PositionName] VARCHAR (50)  NULL,
    [Description]  VARCHAR (MAX) NULL,
    CONSTRAINT [PK_Positions] PRIMARY KEY CLUSTERED ([PositionID] ASC)
);


GO
PRINT N'Creating [dbo].[ProjectCategories]...';


GO
CREATE TABLE [dbo].[ProjectCategories] (
    [ProjectCategoryID] INT           IDENTITY (1, 1) NOT NULL,
    [CategoryName]      VARCHAR (50)  NULL,
    [Description]       VARCHAR (MAX) NULL,
    CONSTRAINT [PK_ProjectCategories] PRIMARY KEY CLUSTERED ([ProjectCategoryID] ASC)
);


GO
PRINT N'Creating [dbo].[ProjectPersonel]...';


GO
CREATE TABLE [dbo].[ProjectPersonel] (
    [Personels_PersonnelID] INT NOT NULL,
    [Projects_ProjectID]    INT NOT NULL,
    CONSTRAINT [PK_ProjectPersonel] PRIMARY KEY NONCLUSTERED ([Personels_PersonnelID] ASC, [Projects_ProjectID] ASC)
);


GO
PRINT N'Creating [dbo].[ProjectPersonel].[IX_FK_ProjectPersonel_Project]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_ProjectPersonel_Project]
    ON [dbo].[ProjectPersonel]([Projects_ProjectID] ASC);


GO
PRINT N'Creating [dbo].[Projects]...';


GO
CREATE TABLE [dbo].[Projects] (
    [ProjectID]        INT           IDENTITY (1, 1) NOT NULL,
    [Name]             VARCHAR (50)  NULL,
    [ProjectManagerID] INT           NULL,
    [CategoryId]       INT           NULL,
    [DateofCreate]     DATETIME      NULL,
    [Description]      VARCHAR (MAX) NULL,
    [Status]           INT           NULL,
    CONSTRAINT [PK_Projects] PRIMARY KEY CLUSTERED ([ProjectID] ASC)
);


GO
PRINT N'Creating [dbo].[Projects].[IX_FK_Project_ProjectCategory1]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_Project_ProjectCategory1]
    ON [dbo].[Projects]([CategoryId] ASC);


GO
PRINT N'Creating [dbo].[Tasks]...';


GO
CREATE TABLE [dbo].[Tasks] (
    [TaskID]      INT           IDENTITY (1, 1) NOT NULL,
    [TaskName]    VARCHAR (MAX) NULL,
    [Description] VARCHAR (MAX) NULL,
    [PersonelID]  INT           NULL,
    [Priority]    INT           NULL,
    [Status]      VARCHAR (50)  NULL,
    [ProjectID]   INT           NULL,
    CONSTRAINT [PK_Tasks] PRIMARY KEY CLUSTERED ([TaskID] ASC)
);


GO
PRINT N'Creating [dbo].[Tasks].[IX_FK_Task_Personel]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_Task_Personel]
    ON [dbo].[Tasks]([PersonelID] ASC);


GO
PRINT N'Creating [dbo].[Tasks].[IX_FK_Task_Project]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_Task_Project]
    ON [dbo].[Tasks]([ProjectID] ASC);


GO
PRINT N'Creating [dbo].[WorkDays]...';


GO
CREATE TABLE [dbo].[WorkDays] (
    [WorkDayID]  INT      IDENTITY (1, 1) NOT NULL,
    [Date]       DATETIME NULL,
    [TaskID]     INT      NULL,
    [PersonelID] INT      NULL,
    CONSTRAINT [PK_WorkDays] PRIMARY KEY CLUSTERED ([WorkDayID] ASC)
);


GO
PRINT N'Creating [dbo].[WorkDays].[IX_FK_WorkDay_Task]...';


GO
CREATE NONCLUSTERED INDEX [IX_FK_WorkDay_Task]
    ON [dbo].[WorkDays]([TaskID] ASC);


GO
PRINT N'Creating FK_Personel_Position...';


GO
ALTER TABLE [dbo].[Personels]
    ADD CONSTRAINT [FK_Personel_Position] FOREIGN KEY ([PositionID]) REFERENCES [dbo].[Positions] ([PositionID]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_ProjectPersonel_Personel...';


GO
ALTER TABLE [dbo].[ProjectPersonel]
    ADD CONSTRAINT [FK_ProjectPersonel_Personel] FOREIGN KEY ([Personels_PersonnelID]) REFERENCES [dbo].[Personels] ([PersonnelID]);


GO
PRINT N'Creating FK_ProjectPersonel_Project...';


GO
ALTER TABLE [dbo].[ProjectPersonel]
    ADD CONSTRAINT [FK_ProjectPersonel_Project] FOREIGN KEY ([Projects_ProjectID]) REFERENCES [dbo].[Projects] ([ProjectID]);


GO
PRINT N'Creating FK_Project_ProjectCategory1...';


GO
ALTER TABLE [dbo].[Projects]
    ADD CONSTRAINT [FK_Project_ProjectCategory1] FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[ProjectCategories] ([ProjectCategoryID]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_Task_Personel...';


GO
ALTER TABLE [dbo].[Tasks]
    ADD CONSTRAINT [FK_Task_Personel] FOREIGN KEY ([PersonelID]) REFERENCES [dbo].[Personels] ([PersonnelID]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_Task_Project...';


GO
ALTER TABLE [dbo].[Tasks]
    ADD CONSTRAINT [FK_Task_Project] FOREIGN KEY ([ProjectID]) REFERENCES [dbo].[Projects] ([ProjectID]) ON DELETE CASCADE;


GO
PRINT N'Creating FK_WorkDay_Task...';


GO
ALTER TABLE [dbo].[WorkDays]
    ADD CONSTRAINT [FK_WorkDay_Task] FOREIGN KEY ([TaskID]) REFERENCES [dbo].[Tasks] ([TaskID]) ON DELETE CASCADE;


GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Update complete.';


GO
