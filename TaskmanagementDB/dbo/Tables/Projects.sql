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
-- Creating foreign key on [CategoryId] in table 'Projects'
ALTER TABLE [dbo].[Projects]
ADD CONSTRAINT [FK_Project_ProjectCategory1]
    FOREIGN KEY ([CategoryId])
    REFERENCES [dbo].[ProjectCategories]
        ([ProjectCategoryID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO
-- Creating primary key on [ProjectID] in table 'Projects'
ALTER TABLE [dbo].[Projects]
ADD CONSTRAINT [PK_Projects]
    PRIMARY KEY CLUSTERED ([ProjectID] ASC);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_Project_ProjectCategory1'
CREATE INDEX [IX_FK_Project_ProjectCategory1]
ON [dbo].[Projects]
    ([CategoryId]);