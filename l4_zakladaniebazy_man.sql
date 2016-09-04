CREATE DATABASE [baza_testowa_sql1] ON  PRIMARY 
( NAME = N'baza_testowa_sql1', FILENAME = N'D:\abd\bazy\baza_testowa_sql1.mdf' , SIZE = 3MB , FILEGROWTH = 5MB, MAXSIZE = UNLIMITED ), 
 FILEGROUP [SECONDARY] 
( NAME = N'baza_testowa_sql1_sec', FILENAME = N'D:\abd\bazy\baza_testowa_sql1_sec.ndf' , SIZE = 2MB , FILEGROWTH = 5MB, MAXSIZE = UNLIMITED )
 LOG ON 
( NAME = N'baza_testowa_sql1_log', FILENAME = N'D:\abd\bazy\baza_testowa_sql1_log.ldf' , SIZE = 1024KB , FILEGROWTH = 5MB)
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [baza_testowa_sql1] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO



CREATE TABLE tmp_1
(id INTEGER IDENTITY
            PRIMARY KEY
);
CREATE TABLE tmp_2
(id INTEGER IDENTITY
            PRIMARY KEY
);
CREATE TABLE tmp_3
(id INTEGER IDENTITY
            PRIMARY KEY
)
ON SECONDARY;

select * into tmp_4 from tmp_3;


EXEC sp_helpdb
     baza_testowa_sql1;
EXEC sp_spaceused;
ALTER DATABASE baza_testowa_sql1 ADD FILEGROUP thrid;
ALTER 