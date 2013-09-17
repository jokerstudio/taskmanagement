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
GO
-- Creating primary key on [PersonnelID] in table 'Personels'
ALTER TABLE [dbo].[Personels]
ADD CONSTRAINT [PK_Personels]
    PRIMARY KEY CLUSTERED ([PersonnelID] ASC);
GO
-- Creating non-clustered index for FOREIGN KEY 'FK_Personel_Position'
CREATE INDEX [IX_FK_Personel_Position]
ON [dbo].[Personels]
    ([PositionID]);