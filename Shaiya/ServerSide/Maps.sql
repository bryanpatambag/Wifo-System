USE [PS_GameDefs]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Maps](    
    [MapID] [smallint] NOT NULL,
    [MapName] [varchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

TRUNCATE TABLE PS_GameDefs.dbo.Maps
INSERT INTO PS_GameDefs.dbo.Maps VALUES ('0','D-Water Borderland')
INSERT INTO PS_GameDefs.dbo.Maps VALUES ('11','Kimuraku Room')
INSERT INTO PS_GameDefs.dbo.Maps VALUES ('45','Deep Desert-1')
INSERT INTO PS_GameDefs.dbo.Maps VALUES ('46','Deep Desert-2')
INSERT INTO PS_GameDefs.dbo.Maps VALUES ('47','Stable Erde')
INSERT INTO PS_GameDefs.dbo.Maps VALUES ('58','Seraphim Room')
INSERT INTO PS_GameDefs.dbo.Maps VALUES ('70','Kanos Illium')
