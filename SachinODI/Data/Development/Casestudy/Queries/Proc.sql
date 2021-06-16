ALTER PROCEDURE Mstr.PopulateDW
AS
BEGIN TRY
	INSERT INTO MSTR.DimMatchDate (MatchDate)
	SELECT DISTINCT MatchDate
	FROM [STG].[SachinODI]

	INSERT INTO MSTR.DimOpposition (Opposition)
	SELECT DISTINCT Opposition
	FROM [STG].[SachinODI]

	INSERT INTO MSTR.[DimBattingPosition] (BattingPosition)
	SELECT DISTINCT BattingPosition
	FROM [STG].[SachinODI]

	INSERT INTO MSTR.[DimDismissal] (Dismissal)
	SELECT DISTINCT Dismissal
	FROM [STG].[SachinODI]

	INSERT INTO MSTR.[DimInns] (Inns)
	SELECT DISTINCT Inns
	FROM [STG].[SachinODI]

	INSERT INTO MSTR.FCTSachinODI (
		MatchDateID
		,OppositionID
		,DismissalID
		,BattingPositionID
		,InnsID
		,BallsFaced
		,Runs
		,Boundaries
		,Sixes
		)
	SELECT MatchDateID
		,OppositionID
		,DismissalID
		,BattingPositionID
		,InnsID
		,[Balls Faced]
		,Runs
		,[4s]
		,[6s]
	FROM [STG].[SachinODI] SSO
	INNER JOIN MSTR.DimMatchDate MD ON SSO.MatchDate = MD.MatchDate
	INNER JOIN [MSTR].[DimOpposition] DO ON SSO.Opposition = DO.Opposition
	INNER JOIN [MSTR].[DimDismissal] Dis ON SSO.Dismissal = Dis.dismissal
	INNER JOIN [MSTR].[DimBattingPosition] BP ON SSO.BattingPosition = BP.BattingPosition
	INNER JOIN [MSTR].[DimInns] DI ON SSO.Inns = DI.Inns
END TRY

BEGIN CATCH
	INSERT INTO dbo.DB_Errors
	VALUES (
		SUSER_SNAME()
		,ERROR_NUMBER()
		,ERROR_STATE()
		,ERROR_SEVERITY()
		,ERROR_LINE()
		,ERROR_PROCEDURE()
		,ERROR_MESSAGE()
		,GETDATE()
		);
END CATCH