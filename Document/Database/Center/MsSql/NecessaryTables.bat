@echo off

cd %cd%

set dbServer=.
set dbAcount=gamesql
set dbPass=Start123
set gameuser=game_user
set gamepass=123
set dbpath=D:\Data


@echo Config parameters are as follows��
@echo     [dbServer] Database server:%dbServer%
@echo     [dbAcount] database account name(sa):%dbAcount%
@echo     [dbPass]   database password (sa):%dbPass%
@echo     [gameuser] game login username:%gameuser%
@echo     [gamepass] game login password:%gamepass%
@echo     [dbpath] database path:%dbpath%
@echo ================================================================

MD %dbpath%

Sqlcmd -? 2>nul 1>nul
if errorlevel 1 (
echo please install sql cmd support&pause>nul
exit
)

Sqlcmd -S %dbServer% -U %dbAcount% -P %dbPass% -d master -i creategameaccount.sql -v gameuser="%gameuser%" loginPass="%gamepass%"
@echo create database game user account successfully!

Sqlcmd -S %dbServer% -U %dbAcount% -P %dbPass% -d master -i usertablestructure.sql -v gameuser="%gameuser%" dbpath="%dbpath%" 
@echo create user table successfully!

Sqlcmd -S %dbServer% -U %dbAcount% -P %dbPass% -d master -i dirandpaytablestructure.sql -v gameuser="%gameuser%" dbpath="%dbpath%" 
@echo create dir center and pay table successfully!

@echo Execute successfully
ECHO Run End��& PAUSE
