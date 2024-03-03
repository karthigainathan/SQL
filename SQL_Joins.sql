----drop table table_1;
--create table table_1
--(id int);

----drop table table_2;
--create table table_2
--(id int);

--insert into table_1 values (1),(1),(1),(2),(3),(3),(3);
--insert into table_2 values (1),(1),(2),(2),(4),(null);

SELECT * FROM table_1;
SELECT * FROM table_2;


SELECT * FROM table_1
left join  table_2 on
table_1.id = table_2.id

SELECT * FROM table_1
right join  table_2 on
table_1.id = table_2.id

SELECT * FROM table_1
join  table_2 on
table_1.id = table_2.id

SELECT * FROM table_1
join  table_2 on
table_1.id = table_2.id