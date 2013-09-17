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
-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [AdminID] in table 'Admins'
ALTER TABLE [dbo].[Admins]
ADD CONSTRAINT [PK_Admins]
    PRIMARY KEY CLUSTERED ([AdminID] ASC);