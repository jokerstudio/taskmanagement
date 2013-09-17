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
-- Creating foreign key on [PersonelID] in table 'Tasks'
ALTER TABLE [dbo].[Tasks]
ADD CONSTRAINT [FK_Task_Personel]
    FOREIGN KEY ([PersonelID])
    REFERENCES [dbo].[Personels]
        ([PersonnelID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO
-- Creating foreign key on [ProjectID] in table 'Tasks'
ALTER TABLE [dbo].[Tasks]
ADD CONSTRAINT [FK_Task_Project]
    FOREIGN KEY ([ProjectID])
    REFERENCES [dbo].[Projects]
        ([ProjectID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO
-- Creating primary key on [TaskID] in table 'Tasks'
ALTER TABLE [dbo].[Tasks]
ADD CONSTRAINT [PK_Tasks]
    PRIMARY KEY CLUSTERED ([TaskID] ASC);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_Task_Personel'
CREATE INDEX [IX_FK_Task_Personel]
ON [dbo].[Tasks]
    ([PersonelID]);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_Task_Project'
CREATE INDEX [IX_FK_Task_Project]
ON [dbo].[Tasks]
    ([ProjectID]);