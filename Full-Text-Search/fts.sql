CREATE TABLE IF NOT EXISTS fts (
	id SERIAL PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	description TEXT,
	tags TEXT[],
	sku VARCHAR(50) UNIQUE,
	price NUMERIC(10, 2)
);

INSERT INTO fts (title, description, tags, sku, price)
VALUES
('Ultra-Fast Running Shoes', 'Lightweight breathable mesh sneakers designed for marathons and long distance running tracks.', '{footwear, athletic, running}', 'RUN-FAST-01', 129.99),
('Waterproof Hiking Boots', 'Durable leather boots with advanced ankle support, perfect for mountain climbing and muddy trails.', '{footwear, outdoor, hiking}', 'BOOT-HIKE-02', 159.50),
('Ergonomic Wireless Mouse', 'High precision optical tracking mouse with programmable buttons and long battery life for office work.', '{electronics, office, tech}', 'MSE-WRLS-03', 45.00),
('Mechanical Gaming Keyboard', 'RGB backlit mechanical keyboard with tactile blue switches. Fast response time for competitive gamers.', '{electronics, gaming, tech}', 'KEY-MECH-04', 89.99),
('Stainless Steel Water Bottle', 'Vacuum insulated thermal flask keeps drinks ice cold for 24 hours. Eco-friendly and leak-proof.', '{kitchen, outdoor, lifestyle}', 'BTL-SST-05', 25.00);


-- 1. Add the column using array_to_tsvector for the tags array
ALTER TABLE fts 
ADD COLUMN textsearchable_index_col tsvector
GENERATED ALWAYS AS (
    setweight(to_tsvector('english', title), 'A') ||
    setweight(array_to_tsvector(tags), 'B') || -- Native, immutable array converter
    setweight(to_tsvector('english', coalesce(description, '')), 'C')
) STORED;

-- 2. Create your GIN index
CREATE INDEX idx_products_search ON fts USING gin(textsearchable_index_col);


-- queries...
-- Basic stemming match.
SELECT title, description FROM fts
WHERE (
	setweight(to_tsvector('english', title), 'A') ||
	setweight(array_to_tsvector(tags), 'B') ||
	setweight(to_tsvector('english', coalesce(description, '')), 'C')
) @@ to_tsquery('english', 'wireless');

-- Google Style web search with ranking.
SELECT 
    title, 
    ts_rank(
        (setweight(to_tsvector('english', title), 'A') ||
         setweight(array_to_tsvector(tags), 'B') ||
         setweight(to_tsvector('english', coalesce(description, '')), 'C')), 
        query
    ) AS rank
FROM fts, websearch_to_tsquery('english', 'outdoor -boots') query
WHERE (
    setweight(to_tsvector('english', title), 'A') ||
    setweight(array_to_tsvector(tags), 'B') ||
    setweight(to_tsvector('english', coalesce(description, '')), 'C')
) @@ query
ORDER BY rank DESC;

















