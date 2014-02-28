--create database login account
CREATE LOGIN [game_user] WITH PASSWORD=N'123', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
go

--create database , change $dbpath folder
CREATE DATABASE [PHData] 
ON  PRIMARY ( NAME = N'PHData', FILENAME = N'D:\Data\PHData.mdf' , SIZE = 3072KB , FILEGROWTH = 1024KB )
 LOG ON ( NAME = N'PHData_log', FILENAME = N'D:\Data\PHData_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [PHData] SET RECOVERY FULL
go

Use PHData
--grant permission to game_user
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'game_user')
	CREATE USER game_user FOR LOGIN game_user WITH DEFAULT_SCHEMA=[dbo]
GO
EXEC sp_addrolemember N'db_datareader', N'game_user'
EXEC sp_addrolemember N'db_datawriter', N'game_user'
EXEC sp_addrolemember N'db_ddladmin', N'game_user'
GO