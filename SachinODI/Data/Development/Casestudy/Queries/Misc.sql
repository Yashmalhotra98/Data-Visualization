Create schema STG
ALTER SCHEMA STG TRANSFER dbo.SachinODI /*Changing the Database Schema fro DBO to STG*/

Select * from [STG].[SachinODI]

Delete from [STG].[SachinODI] where MatchDate = '' /*Deleting Blank Rows from the DB*/

Create schema MSTR

ALTER SCHEMA MSTR TRANSFER dbo.DimMatchDate

Insert into  MSTR.DimMatchDate(MatchDate)
Select Distinct MatchDate
from 
[STG].[SachinODI]

Select * from MSTR.DimMatchDate

Insert into  MSTR.DimMatchDate(MatchDate)
Select Distinct MatchDate
from 
[STG].[SachinODI]

Select * from MSTR.DimMatchDate

ALTER SCHEMA MSTR TRANSFER dbo.DimOpposition

Insert into  MSTR.DimOpposition(Opposition)
Select Distinct Opposition
from 
[STG].[SachinODI]


select * from MSTR.DimOpposition


alter schema MSTR transfer [dbo].[DimBattingPosition]
alter schema MSTR transfer[dbo].[DimDismissal]
alter schema MSTR transfer[dbo].[DimOpposition]
alter schema MSTR transfer[dbo].[DimInns]

Insert into  MSTR.[DimBattingPosition](BattingPosition)
Select Distinct BattingPosition
from 
[STG].[SachinODI]

Select * from MSTR.[DimBattingPosition]

Insert into  MSTR.[DimDismissal](Dismissal)
Select Distinct Dismissal
from 
[STG].[SachinODI]

Select * From MSTR.[DimDismissal]

Insert into  MSTR.[DimInns](Inns)
Select Distinct Inns
from 
[STG].[SachinODI]

Select * From MSTR.[DimInns]


Select * from MSTR.DimMatchDate
Select * From MSTR.[DimInns]
Select * from MSTR.[DimBattingPosition]
Select * From MSTR.[DimDismissal]
select * from MSTR.DimOpposition

alter schema mstr transfer dbo.FctSachinODI

/*
insert into MSTR.FctSachinODI
(
   MatchDateID, OppositionID, InnsID, BattingPositionID, DismissalID, BallsFaced, Runs, Boundaries, Boundaries, Sixes
)

select 
MatchDateID, OppositionID, InnsID, BattingPositionID, DismissalID, [Balls Faced], Runs, [4s], [6s]
from STG.SachinODI SSO
inner join MSTR.DimMatchDate MD
on sso.MatchDate = MD.MatchDate
inner join MSTR.DimOpposition DO 
on sso.Opposition = DO.Opposition
inner join MSTR.DimBattingPosition BP
on sso.BattingPosition = BP.BattingPosition
inner join MSTR.DimDismissal DD
on SSO.Dismissal = DD.Dismissal
inner join MSTR.DimInns DI
on sso.Inns = DI.inns
*/

insert into MSTR.FCTSachinODI(MatchDateID,OppositionID,DismissalID,BattingPositionID,InnsID,BallsFaced,Runs,Boundaries,Sixes)
SELECT
MatchDateID,OppositionID,DismissalID,BattingPositionID,InnsID,[Balls Faced],Runs,[4s],[6s] FROM  [STG].[SachinODI] SSO
INNER JOIN MSTR.DimMatchDate MD
on SSO.MatchDate=MD.MatchDate
INNER JOIN  [MSTR].[DimOpposition] DO
ON SSO.Opposition=DO.Opposition

inner join [MSTR].[DimDismissal] Dis
ON SSO.Dismissal=Dis.dismissal

inner join  [MSTR].[DimBattingPosition] BP
on SSO.BattingPosition=BP.BattingPosition

INNER JOIN [MSTR].[DimInns] DI
on SSO.Inns=DI.Inns

select * from [MSTR].[FctSachinODI]

CREATE TABLE DB_Errors         (ErrorID        INT IDENTITY(1, 1),          UserName       VARCHAR(100),          ErrorNumber    INT,          ErrorState     INT,          ErrorSeverity  INT,          ErrorLine      INT,          ErrorProcedure VARCHAR(MAX),          ErrorMessage   VARCHAR(MAX),          ErrorDateTime  DATETIME)


