/*
##################################################################################
# Date Modified: 4/27/2023
# Purpose of Code: Stored Procedure for finding values
# Written by: Brian Roskelley
# Updated by: 
# Tableau: N/A

This stored procedure is not used within Tableau. Its strictly a stored procedure for finding values or keywords within the database. It will return the table and field name where that value resides. 
It is typical that a search can take 30 + minutes. This is because there are 5000 + tables to traverse. From my experience, it does not build up a cache within the database.

A stored procedure is a subroutine available to applications that access a relational database management system. Such procedures are stored in the database data dictionary. Uses for stored procedures include data-validation or access-control mechanisms.

##################################################################################
*/


--Step 2
--To execute, provide a value below with underscores to separate.
exec FindMyData_string 'type_value_here', 0


--Step 1
--Run this to create the stored procedure. Once created, execute the command above to search for a value. 
CREATE PROCEDURE FindMyData_String
    @DataToFind NVARCHAR(4000),
    @ExactMatch BIT = 0
AS
SET NOCOUNT ON

DECLARE @Temp TABLE(RowId INT IDENTITY(1,1), SchemaName sysname, TableName sysname, ColumnName SysName, DataType VARCHAR(100), DataFound BIT)

    INSERT  INTO @Temp(TableName,SchemaName, ColumnName, DataType)
    SELECT  C.Table_Name,C.TABLE_SCHEMA, C.Column_Name, C.Data_Type
    FROM    Information_Schema.Columns AS C
            INNER Join Information_Schema.Tables AS T
                ON C.Table_Name = T.Table_Name
        AND C.TABLE_SCHEMA = T.TABLE_SCHEMA
    WHERE   Table_Type = 'Base Table'
            And Data_Type In ('ntext','text','nvarchar','nchar','varchar','char')


DECLARE @i INT
DECLARE @MAX INT
DECLARE @TableName sysname
DECLARE @ColumnName sysname
DECLARE @SchemaName sysname
DECLARE @SQL NVARCHAR(4000)
DECLARE @PARAMETERS NVARCHAR(4000)
DECLARE @DataExists BIT
DECLARE @SQLTemplate NVARCHAR(4000)

SELECT  @SQLTemplate = CASE WHEN @ExactMatch = 1
                            THEN 'If Exists(Select *
                                          From   ReplaceTableName
                                          Where  Convert(nVarChar(4000), [ReplaceColumnName])
                                                       = ''' + @DataToFind + '''
                                          )
                                     Set @DataExists = 1
                                 Else
                                     Set @DataExists = 0'
                            ELSE 'If Exists(Select *
                                          From   ReplaceTableName
                                          Where  Convert(nVarChar(4000), [ReplaceColumnName])
                                                       Like ''%' + @DataToFind + '%''
                                          )
                                     Set @DataExists = 1
                                 Else
                                     Set @DataExists = 0'
                            END,
        @PARAMETERS = '@DataExists Bit OUTPUT',
        @i = 1

SELECT @i = 1, @MAX = MAX(RowId)
FROM   @Temp

WHILE @i <= @MAX
    BEGIN
        SELECT  @SQL = REPLACE(REPLACE(@SQLTemplate, 'ReplaceTableName', QUOTENAME(SchemaName) + '.' + QUOTENAME(TableName)), 'ReplaceColumnName', ColumnName)
        FROM    @Temp
        WHERE   RowId = @i


        PRINT @SQL
        EXEC SP_EXECUTESQL @SQL, @PARAMETERS, @DataExists = @DataExists OUTPUT

        IF @DataExists =1
            UPDATE @Temp SET DataFound = 1 WHERE RowId = @i

        SET @i = @i + 1
    END

SELECT  SchemaName,TableName, ColumnName
FROM    @Temp
WHERE   DataFound = 1
GO