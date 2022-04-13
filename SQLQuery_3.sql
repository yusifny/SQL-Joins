CREATE DATABASE IMDb

USE IMDb

CREATE TABLE Directors(
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(50),
    Surname NVARCHAR(50),
    [Birth Date] DATE
)

CREATE TABLE Actors(
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(50),
    Surname NVARCHAR(50),
    [Birth Date] DATE
)

CREATE TABLE Genres(
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(50),
)

CREATE TABLE Movies(
    ID INT PRIMARY KEY IDENTITY,
    [Rank] TINYINT,
    Title NVARCHAR(255),
    [Year] INT,
    [IMDb Rating] DECIMAL(2,1),
    DirectorId INT CONSTRAINT FK_DirectorId FOREIGN KEY REFERENCES Directors(Id)
)

CREATE TABLE MovieActors(
    Id INT PRIMARY KEY IDENTITY,
    MovieId INT CONSTRAINT FK_MovieId FOREIGN KEY REFERENCES Movies(Id),
    ActorId INT CONSTRAINT FK_ActorId FOREIGN KEY REFERENCES Actors(Id)
)

CREATE TABLE MovieGenres(
    Id INT PRIMARY KEY IDENTITY,
    MovieId INT CONSTRAINT FK_MoviesId FOREIGN KEY REFERENCES Movies(Id),
    GenreId INT CONSTRAINT FK_GenreId FOREIGN KEY REFERENCES Genres(Id)
)

SELECT Movies.Title AS 'Movie Title', Movies.[IMDb Rating] AS IMDbRating, Genres.[Name] AS 'Genre', Directors.Name AS 'DirectorName', Actors.Name AS 'ActorName' 

FROM Movies


JOIN Genres
ON Movies.ID = Genres.Id

JOIN Directors
ON Movies.ID = Directors.Id

JOIN Actors
ON Movies.ID = Actors.Id

WHERE [IMDb Rating]>6
--------------------------------------------------------------------------------------------------
SELECT Movies.Title AS 'Movie Title', Movies.[IMDb Rating] AS IMDbRating, Genres.[Name] AS 'Genre'

FROM Movies

JOIN Genres
ON Movies.ID = Genres.Id

WHERE Movies.Title LIKE '%A%'
---------------------------------------------------------------------------------------------------
SELECT Movies.Title AS 'Movie Title', Movies.[IMDb Rating] AS IMDbRating, Actors.[Name] AS 'ActorName'

FROM Movies

JOIN Actors
ON Movies.ID = Actors.Id

WHERE LEN(Movies.Title)>13 AND Movies.Title LIKE '%t'
-------------------------------------------------------------------------------------------------------
SELECT Movies.Title AS 'Movie Title', Movies.[IMDb Rating] AS IMDbRating, Genres.[Name] AS 'Genre', Directors.Name AS 'DirectorName', Actors.[Name] AS 'ActorName'

FROM Movies

JOIN Genres
ON Movies.ID = Genres.Id

JOIN Directors
ON Movies.ID = Directors.Id

JOIN Actors
ON Movies.ID = Actors.Id

WHERE [IMDb Rating] > (SELECT AVG([IMDb Rating]) FROM Movies)

ORDER BY [IMDb Rating] DESC