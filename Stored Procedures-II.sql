


select * from target_data 
select * from source_data 


drop table target_data 
drop table source_data 


-- Create source_data table
CREATE TABLE source_data (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    value INT,
    last_updated DATETIME
);

-- Insert sample data into source_data
INSERT INTO source_data (id, name, value, last_updated)
VALUES 
    (1, 'Alice', 100, '2024-03-01 12:00:00'),
    (2, 'Bob', 200, '2024-03-01 12:00:00'),
    (3, 'Charlie', 300, '2024-03-01 12:00:00');

-- Create target_data table
CREATE TABLE target_data (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    value INT,
    last_updated DATETIME
);

-- Insert initial data into target_data (to simulate existing data)
INSERT INTO target_data (id, name, value, last_updated)
VALUES 
    (1, 'Alice', 100, '2024-02-28 12:00:00'),
    (2, 'Bob', 200, '2024-02-28 12:00:00');


-- Create the IncrementalLoad stored procedure
CREATE PROCEDURE IncrementalLoad
AS
BEGIN
    -- Insert new records from source_data into target_data
    INSERT INTO target_data (id, name, value, last_updated)
    SELECT s.id, s.name, s.value, s.last_updated
    FROM source_data s
    LEFT JOIN target_data t ON s.id = t.id
    WHERE t.id IS NULL; -- Only insert records that don't already exist in target_data
    
    -- Update existing records in target_data with modified values from source_data
    UPDATE t
    SET t.name = s.name,
        t.value = s.value,
        t.last_updated = s.last_updated
    FROM target_data t
    INNER JOIN source_data s ON s.id = t.id
    WHERE  t.last_updated > s.last_updated  -- Only update records that have been modified in source_data
END;


EXEC IncrementalLoad;