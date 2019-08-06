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

INSERT INTO Club(ClubName ,ContactName)
VALUES ('Mt Martha Basketball Club', 'Bob Jane')
,('Coyote Creek Football Team', 'John Smith')
,('Barrys Bush Table Tennis Squad', 'Barry B Benson')
,('Island Isaac Bowls Bash', 'Jane Doe');

INSERT INTO Season(Year ,SeasonName)
VALUES (2018, 'Winter')
,(2018, 'Summer')
,(2019, 'Winter')
,(2019, 'Summer');

INSERT INTO Player(PlayerID ,Fname ,Lname ,Phone)
VALUES (10002, 'John', 'Howard', 5552345)
,(10003, 'John', 'Howard', 5552345)
,(102145149, 'Hunter', 'Docking', 0447781817)
,(123456789, 'Mhorck', 'Rohmig', 0484081250);

INSERT INTO TeamEntry(ClubName ,Year ,SeasonName ,AgeGroup ,TeamNumber)
VALUES ('Mt Martha Basketball Club', 2018, 'Summer', 'U14', 1)
,('Mt Martha Basketball Club', 2018, 'Summer', 'U14', 2)
,('Barrys Bush Table Tennis Squad', 2019, 'Summer', 'O18', 2)
,('Island Isaac Bowls Bash', 2019, 'Winter', 'U16', 4);

INSERT INTO PlayerRegistration(PlayerID ,ClubName ,Year ,SeasonName ,AgeGroup ,TeamNumber ,DateRegistered)
VALUES (10003, 'Mt Martha Basketball Club', 2018, 'Summer', 'U14', 2, '01/JAN/2018')
,(123456789, 'Mt Martha Basketball Club', 2018, 'Summer', 'U14', 2, '25/DEC/2017')
,(102145149, 'Island Isaac Bowls Bash', 2019, 'Winter', 'U16', 4, '09/FEB/2019')
,(102145149, 'Barrys Bush Table Tennis Squad', 2019, 'Summer', 'O18', 2, '14/NOV/2018');



-- Query a
SELECT pr.PlayerId, p.FName, p.LName, p.Phone, pr.ClubName, c.ContactName, pr.Year, pr.SeasonName, pr.AgeGroup, pr.TeamNumber
FROM PlayerRegistration pr

INNER JOIN Player p
ON p.PlayerID = pr.PlayerID

INNER JOIN Club c
ON c.ClubName = pr.ClubName

ORDER BY PlayerID ASC



-- Query b
SELECT Year, AgeGroup, COUNT(AgeGroup) as "Number of Players"
FROM TeamEntry

GROUP BY Year, AgeGroup
ORDER BY Year, AgeGroup DESC



-- Query c
SELECT ClubName, (SELECT COUNT(Year) FROM PlayerRegistration) as "Amount of Entries total",SeasonName, DateRegistered
FROM PlayerRegistration

WHERE Year >= 2019
GROUP BY ClubName, SeasonName, DateRegistered

