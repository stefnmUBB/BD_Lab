CREATE OR ALTER PROCEDURE ExecuteIndividualTestTable @tid INT 
AS
BEGIN
	
	DECLARE @test_name VARCHAR(100)
	SELECT @test_name = Name FROM Tests WHERE TestId = @tid;
	PRINT 'Executing tests : ' + @test_name;

	DECLARE @table VARCHAR(100)
	DECLARE @norows INT	

	-- removals
	DECLARE crs CURSOR FOR 
		SELECT Name, NoOfRows FROM TestTables TT INNER JOIN Tables T On TT.TableID = T.TableID  WHERE TT.TestID = 1
		ORDER BY Position DESC
	OPEN crs
	
	FETCH NEXT FROM crs INTO @table, @norows;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'DELETE FROM ' + @table;
		EXEC DeleteFromTable @table
		FETCH NEXT FROM crs INTO @table, @norows;
	END

	CLOSE crs
	DEALLOCATE crs

	-- additions

	DECLARE crs2 CURSOR FOR 
		SELECT Name, NoOfRows FROM TestTables TT INNER JOIN Tables T On TT.TableID = T.TableID  WHERE TT.TestID = 1
		ORDER BY Position ASC
	OPEN crs2
	
	FETCH NEXT FROM crs2 INTO @table, @norows;

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT 'INSERT INTO ' + @table;
		EXEC AddToTable @table, @norows
		FETCH NEXT FROM crs2 INTO @table, @norows;
	END

	CLOSE crs2
	DEALLOCATE crs2
END
GO

EXEC ExecuteIndividualTestTable 1