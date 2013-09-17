-- Creating table 'ProjectPersonel'
CREATE TABLE [dbo].[ProjectPersonel] (
    [Personels_PersonnelID] int  NOT NULL,
    [Projects_ProjectID] int  NOT NULL
);
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
GO
-- Creating primary key on [Personels_PersonnelID], [Projects_ProjectID] in table 'ProjectPersonel'
ALTER TABLE [dbo].[ProjectPersonel]
ADD CONSTRAINT [PK_ProjectPersonel]
    PRIMARY KEY NONCLUSTERED ([Personels_PersonnelID], [Projects_ProjectID] ASC);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_ProjectPersonel_Project'
CREATE INDEX [IX_FK_ProjectPersonel_Project]
ON [dbo].[ProjectPersonel]
    ([Projects_ProjectID]);