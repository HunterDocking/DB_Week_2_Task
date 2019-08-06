DROP TABLE IF EXISTS dbo.PlayerRegistration;
DROP TABLE IF EXISTS dbo.TeamEntry;
DROP TABLE IF EXISTS dbo.Player;
DROP TABLE IF EXISTS dbo.Season;
DROP TABLE IF EXISTS dbo.Club;

CREATE TABLE Club(
ClubName        NVARCHAR(100) PRIMARY KEY
,ContactName    NVARCHAR(100) NULL
)

CREATE TABLE Season(
Year            INT
,SeasonName      NVARCHAR(6)
,PRIMARY KEY (Year, SeasonName)
)

CREATE TABLE Player(
PlayerID        INT PRIMARY KEY
,Fname          NVARCHAR(100) NOT NULL
,Lname          NVARCHAR(100) NOT NULL
,Phone          NVARCHAR(50) NULL
)

CREATE TABLE TeamEntry(
ClubName        NVARCHAR(100)
,Year           INT
,SeasonName     NVARCHAR(6)
,AgeGroup       NVARCHAR(3)
,TeamNumber     INT
,PRIMARY KEY (ClubName, Year, SeasonName, AgeGroup, TeamNumber)
,FOREIGN KEY (ClubName) REFERENCES Club
,FOREIGN KEY (Year, SeasonName) REFERENCES Season
)

CREATE TABLE PlayerRegistration(
PlayerID        INT
,ClubName       NVARCHAR(100)
,Year           INT
,SeasonName     NVARCHAR(6)
,AgeGroup       NVARCHAR(3)
,TeamNumber     INT
,DateRegistered DATE NOT NULL
,PRIMARY KEY (PlayerID, ClubName, Year, SeasonName, AgeGroup, TeamNumber)
,FOREIGN KEY (PlayerID) REFERENCES Player
,FOREIGN KEY (ClubName, Year, SeasonName, AgeGroup, TeamNumber) REFERENCES TeamEntry
)