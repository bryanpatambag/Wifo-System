CREATE PROCEDURE [dbo].[BALANCE_NOTICE]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @lightKills INT = 0;
    DECLARE @furyKills INT = 0;
    DECLARE @lightPercent DECIMAL(5,2) = 0;
    DECLARE @furyPercent DECIMAL(5,2) = 0;
    DECLARE @command NVARCHAR(400);

    SELECT @lightKills = COUNT(*)
    FROM PS_GameLog.dbo.PvP_Log p
    JOIN PS_GameData.dbo.UserMaxGrow u ON p.UserUID = u.UserUID
    WHERE u.Country = 0 AND p.ActionType = 103
      AND p.ActionTime >= CAST(GETDATE() AS DATE)
      AND p.ActionTime < DATEADD(DAY, 1, CAST(GETDATE() AS DATE));

    SELECT @furyKills = COUNT(*)
    FROM PS_GameLog.dbo.PvP_Log p
    JOIN PS_GameData.dbo.UserMaxGrow u ON p.UserUID = u.UserUID
    WHERE u.Country = 1 AND p.ActionType = 103
      AND p.ActionTime >= CAST(GETDATE() AS DATE)
      AND p.ActionTime < DATEADD(DAY, 1, CAST(GETDATE() AS DATE));

    IF (@lightKills + @furyKills) > 0
    BEGIN
        SET @lightPercent = CAST(@lightKills * 100.0 / (@lightKills + @furyKills) AS DECIMAL(5,2));
        SET @furyPercent  = CAST(@furyKills * 100.0 / (@lightKills + @furyKills) AS DECIMAL(5,2));

        SET @command = '/nt [BALANCE_NOTICE] '
                     + CAST(@lightPercent AS NVARCHAR(10)) + ' '
                     + CAST(@furyPercent AS NVARCHAR(10));

        EXEC securetech.dbo.RunServiceCommand 
            @Service = N'ps_game',
            @CommandText = @command;
    END

    SELECT 
        @lightKills   AS LightKillsToday,
        @lightPercent AS LightPercent,
        @furyKills    AS FuryKillsToday,
        @furyPercent  AS FuryPercent,
        ISNULL(@command, '') AS CommandString;
END;
