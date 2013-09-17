-- Creating table 'ProjectCategories'
CREATE TABLE [dbo].[ProjectCategories] (
    [ProjectCategoryID] int IDENTITY(1,1) NOT NULL,
    [CategoryName] varchar(50)  NULL,
    [Description] varchar(max)  NULL
);
GO
-- Creating primary key on [ProjectCategoryID] in table 'ProjectCategories'
ALTER TABLE [dbo].[ProjectCategories]
ADD CONSTRAINT [PK_ProjectCategories]
    PRIMARY KEY CLUSTERED ([ProjectCategoryID] ASC);