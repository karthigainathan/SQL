/****** Script for UPDATE  ******/
MERGE INTO [dbo].[Main Table]
   USING [dbo].[staging table]
      ON [dbo].[Main Table].[id] = [dbo].[staging table].[id]
WHEN MATCHED THEN
   UPDATE 
      SET column = [dbo].[staging table].column;
	  
	  
	  UPDATE 
    [dbo].[Main Table]
SET 
     [dbo].[Main Table].column = [dbo].[staging table].column
FROM 
    [dbo].[Main Table]
     INNER JOIN [dbo].[staging table]
     ON [dbo].[Main Table].id = [dbo].[staging table].id;
	 
	 
	 
	 
UPDATE [dbo].[Main Table]
SET [Column name] = 'value'
WHERE [Id] = ('value', 'value', 'value');
