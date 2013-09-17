-- Creating table 'WorkDays'
CREATE TABLE [dbo].[WorkDays] (
    [WorkDayID] int IDENTITY(1,1) NOT NULL,
    [Date] datetime  NULL,
    [TaskID] int  NULL,
    [PersonelID] int  NULL
);
GO
-- Creating foreign key on [TaskID] in table 'WorkDays'
ALTER TABLE [dbo].[WorkDays]
ADD CONSTRAINT [FK_WorkDay_Task]
    FOREIGN KEY ([TaskID])
    REFERENCES [dbo].[Tasks]
        ([TaskID])
    ON DELETE CASCADE ON UPDATE NO ACTION;
GO
-- Creating primary key on [WorkDayID] in table 'WorkDays'
ALTER TABLE [dbo].[WorkDays]
ADD CONSTRAINT [PK_WorkDays]
    PRIMARY KEY CLUSTERED ([WorkDayID] ASC);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_WorkDay_Task'
CREATE INDEX [IX_FK_WorkDay_Task]
ON [dbo].[WorkDays]
    ([TaskID]);