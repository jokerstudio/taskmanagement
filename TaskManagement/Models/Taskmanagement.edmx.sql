
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
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Admins'
CREATE TABLE [dbo].[Admins] (
    [AdminID] int IDENTITY(1,1) NOT NULL,
    [Username] varchar(50)  NOT NULL,
    [Password] varchar(50)  NOT NULL
);
GO

-- Creating table 'Personels'
CREATE TABLE [dbo].[Personels] (
    [PersonnelID] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(50)  NULL,
    [PositionID] int  NULL,
    [Birthday] datetime  NULL,
    [Address] varchar(max)  NULL,
    [Phone] varchar(10)  NULL,
    [IDCard] varchar(13)  NULL,
    [Username] varchar(50)  NULL,
    [Password] varchar(50)  NULL,
    [IsActive] int  NULL
);
GO

-- Creating table 'Positions'
CREATE TABLE [dbo].[Positions] (
    [PositionID] int IDENTITY(1,1) NOT NULL,
    [PositionName] varchar(50)  NULL,
    [Description] varchar(max)  NULL
);
GO

-- Creating table 'Projects'
CREATE TABLE [dbo].[Projects] (
    [ProjectID] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(50)  NULL,
    [ProjectManagerID] int  NULL,
    [CategoryId] int  NULL,
    [DateofCreate] datetime  NULL,
    [Description] varchar(max)  NULL,
    [Status] int  NULL
);
GO

-- Creating table 'ProjectCategories'
CREATE TABLE [dbo].[ProjectCategories] (
    [ProjectCategoryID] int IDENTITY(1,1) NOT NULL,
    [CategoryName] varchar(50)  NULL,
    [Description] varchar(max)  NULL
);
GO

-- Creating table 'Tasks'
CREATE TABLE [dbo].[Tasks] (
    [TaskID] int IDENTITY(1,1) NOT NULL,
    [TaskName] varchar(max)  NULL,
    [Description] varchar(max)  NULL,
    [PersonelID] int  NULL,
    [Priority] int  NULL,
    [Status] varchar(50)  NULL,
    [ProjectID] int  NULL
);
GO

-- Creating table 'WorkDays'
CREATE TABLE [dbo].[WorkDays] (
    [WorkDayID] int IDENTITY(1,1) NOT NULL,
    [Date] datetime  NULL,
    [TaskID] int  NULL,
    [PersonelID] int  NULL
);
GO

-- Creating table 'ProjectPersonel'
CREATE TABLE [dbo].[ProjectPersonel] (
    [Personels_PersonnelID] int  NOT NULL,
    [Projects_ProjectID] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [AdminID] in table 'Admins'
ALTER TABLE [dbo].[Admins]
ADD CONSTRAINT [PK_Admins]
    PRIMARY KEY CLUSTERED ([AdminID] ASC);
GO

-- Creating primary key on [PersonnelID] in table 'Personels'
ALTER TABLE [dbo].[Personels]
ADD CONSTRAINT [PK_Personels]
    PRIMARY KEY CLUSTERED ([PersonnelID] ASC);
GO

-- Creating primary key on [PositionID] in table 'Positions'
ALTER TABLE [dbo].[Positions]
ADD CONSTRAINT [PK_Positions]
    PRIMARY KEY CLUSTERED ([PositionID] ASC);
GO

-- Creating primary key on [ProjectID] in table 'Projects'
ALTER TABLE [dbo].[Projects]
ADD CONSTRAINT [PK_Projects]
    PRIMARY KEY CLUSTERED ([ProjectID] ASC);
GO

-- Creating primary key on [ProjectCategoryID] in table 'ProjectCategories'
ALTER TABLE [dbo].[ProjectCategories]
ADD CONSTRAINT [PK_ProjectCategories]
    PRIMARY KEY CLUSTERED ([ProjectCategoryID] ASC);
GO

-- Creating primary key on [TaskID] in table 'Tasks'
ALTER TABLE [dbo].[Tasks]
ADD CONSTRAINT [PK_Tasks]
    PRIMARY KEY CLUSTERED ([TaskID] ASC);
GO

-- Creating primary key on [WorkDayID] in table 'WorkDays'
ALTER TABLE [dbo].[WorkDays]
ADD CONSTRAINT [PK_WorkDays]
    PRIMARY KEY CLUSTERED ([WorkDayID] ASC);
GO

-- Creating primary key on [Personels_PersonnelID], [Projects_ProjectID] in table 'ProjectPersonel'
ALTER TABLE [dbo].[ProjectPersonel]
ADD CONSTRAINT [PK_ProjectPersonel]
    PRIMARY KEY NONCLUSTERED ([Personels_PersonnelID], [Projects_ProjectID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [PositionID] in table 'Personels'
ALTER TABLE [dbo].[Personels]
ADD CONSTRAINT [FK_Personel_Position]
    FOREIGN KEY ([PositionID])
    REFERENCES [dbo].[Positions]
        ([PositionID])
    ON DELETE CASCADE ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Personel_Position'
CREATE INDEX [IX_FK_Personel_Position]
ON [dbo].[Personels]
    ([PositionID]);
GO

-- Creating foreign key on [PersonelID] in table 'Tasks'
ALTER TABLE [dbo].[Tasks]
ADD CONSTRAINT [FK_Task_Personel]
    FOREIGN KEY ([PersonelID])
    REFERENCES [dbo].[Personels]
        ([PersonnelID])
    ON DELETE CASCADE ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Task_Personel'
CREATE INDEX [IX_FK_Task_Personel]
ON [dbo].[Tasks]
    ([PersonelID]);
GO

-- Creating foreign key on [CategoryId] in table 'Projects'
ALTER TABLE [dbo].[Projects]
ADD CONSTRAINT [FK_Project_ProjectCategory1]
    FOREIGN KEY ([CategoryId])
    REFERENCES [dbo].[ProjectCategories]
        ([ProjectCategoryID])
    ON DELETE CASCADE ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Project_ProjectCategory1'
CREATE INDEX [IX_FK_Project_ProjectCategory1]
ON [dbo].[Projects]
    ([CategoryId]);
GO

-- Creating foreign key on [ProjectID] in table 'Tasks'
ALTER TABLE [dbo].[Tasks]
ADD CONSTRAINT [FK_Task_Project]
    FOREIGN KEY ([ProjectID])
    REFERENCES [dbo].[Projects]
        ([ProjectID])
    ON DELETE CASCADE ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_Task_Project'
CREATE INDEX [IX_FK_Task_Project]
ON [dbo].[Tasks]
    ([ProjectID]);
GO

-- Creating foreign key on [TaskID] in table 'WorkDays'
ALTER TABLE [dbo].[WorkDays]
ADD CONSTRAINT [FK_WorkDay_Task]
    FOREIGN KEY ([TaskID])
    REFERENCES [dbo].[Tasks]
        ([TaskID])
    ON DELETE CASCADE ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_WorkDay_Task'
CREATE INDEX [IX_FK_WorkDay_Task]
ON [dbo].[WorkDays]
    ([TaskID]);
GO

-- Creating foreign key on [Personels_PersonnelID] in table 'ProjectPersonel'
ALTER TABLE [dbo].[ProjectPersonel]
ADD CONSTRAINT [FK_ProjectPersonel_Personel]
    FOREIGN KEY ([Personels_PersonnelID])
    REFERENCES [dbo].[Personels]
        ([PersonnelID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Projects_ProjectID] in table 'ProjectPersonel'
ALTER TABLE [dbo].[ProjectPersonel]
ADD CONSTRAINT [FK_ProjectPersonel_Project]
    FOREIGN KEY ([Projects_ProjectID])
    REFERENCES [dbo].[Projects]
        ([ProjectID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectPersonel_Project'
CREATE INDEX [IX_FK_ProjectPersonel_Project]
ON [dbo].[ProjectPersonel]
    ([Projects_ProjectID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------