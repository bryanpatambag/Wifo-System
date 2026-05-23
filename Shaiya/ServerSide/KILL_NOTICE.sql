CREATE PROCEDURE [dbo].[KILL_NOTICE]
    @CharName varchar(120),
    @Text1    varchar(120),
    @MapID    int
AS
BEGIN
    DECLARE @MapName varchar(120) = (
        SELECT MapName 
        FROM PS_GameDefs.dbo.Maps 
        WHERE MapID = @MapID
    );

    DECLARE @Notice varchar(120) = '[KILL_NOTICE] ' + @CharName + ' killed ' + @Text1 + ' in ' + @MapName;

    DECLARE @command varchar(160) = N'/nt ' + @Notice;

    EXEC securetech.dbo.RunServiceCommand
        @Service     = N'ps_game',
        @CommandText = @command;
END
