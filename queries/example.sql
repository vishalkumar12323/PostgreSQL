-- Active: 1783355328541@@127.0.0.1@5432@postgres
-- SELECT DISTINCT

-- example
CREATE TABLE IF NOT EXISTS colors(
    id SERIAL PRIMARY KEY,
    bcolor VARCHAR,
    fcolor VARCHAR
);

-- insert some rows
INSERT INTO
    colors (bcolor, fcolor)
VALUES ('red', 'red'),
    ('red', 'red'),
    ('red', NULL),
    (NULL, 'red'),
    (NULL, NULL),
    ('green', 'green'),
    ('blue', 'blue'),
    ('blue', 'blue');


SELECT id, bcolor, fcolor FROM colors;

-- SELECT DISTINCT column1 FROM table_name
SELECT DISTINCT bcolor
FROM colors
ORDER BY bcolor;


-- SELECT DISTINCT column1, column2 FROM table_name
SELECT DISTINCT bcolor, fcolor
FROM colors
ORDER BY bcolor, fcolor;