CREATE DATABASE IF NOT EXISTS domcode_rafflers;

USE domcode_rafflers;

CREATE TEMPORARY TABLE names(name VARCHAR(30) NOT NULL);

LOAD DATA LOCAL INFILE '/var/names.txt' INTO TABLE names;

SELECT name AS 'The winner is:' FROM names ORDER BY RAND() LIMIT 1;

DROP DATABASE domcode_rafflers;

