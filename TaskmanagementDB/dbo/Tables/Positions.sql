-- Creating table 'Positions'
CREATE TABLE [dbo].[Positions] (
    [PositionID] int IDENTITY(1,1) NOT NULL,
    [PositionName] varchar(50)  NULL,
    [Description] varchar(max)  NULL
);
GO
-- Creating primary key on [PositionID] in table 'Positions'
ALTER TABLE [dbo].[Positions]
ADD CONSTRAINT [PK_Positions]
    PRIMARY KEY CLUSTERED ([PositionID] ASC);