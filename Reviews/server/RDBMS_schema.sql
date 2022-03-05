-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'reviews'
--
-- ---

DROP TABLE IF EXISTS reviews CASCADE;

CREATE TABLE reviews (
  id BIGSERIAL PRIMARY KEY,
  product_id INTEGER NULL DEFAULT NULL,
  rating INTEGER NULL DEFAULT NULL,
  dates  BIGINT NULL DEFAULT NULL,
  summary VARCHAR(200) NULL DEFAULT NULL,
  body VARCHAR(500) NULL DEFAULT NULL,
  recommend BOOLEAN NULL DEFAULT NULL,
  reported BOOLEAN NULL DEFAULT NULL,
  reviewer_name VARCHAR(50) NULL DEFAULT NULL,
  reviewer_email VARCHAR(100) NULL DEFAULT NULL,
  response VARCHAR(200) NULL DEFAULT NULL,
  helpfulness INTEGER NULL DEFAULT NULL
);

\COPY reviews(id, product_id, rating, dates, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness) FROM '/home/tofu/Documents/hackreactor/Project-Speedy/Reviews/server/data/reviews.csv' DELIMITER ',' CSV HEADER;
\CREATE INDEX idx_id on reviews(id);
\CREATE INDEX idx_product_id on reviews(product_id);
\CREATE INDEX idx_reviews_rating on reviews(rating);


-- ---
-- Table 'photos'
--
-- ---

DROP TABLE IF EXISTS photos CASCADE;

CREATE TABLE photos (
  id BIGSERIAL PRIMARY KEY,
  review_id  BIGINT NULL DEFAULT NULL,
  urls VARCHAR(300) NULL DEFAULT NULL
);

\COPY photos(id, review_id, url) FROM '/home/tofu/Documents/hackreactor/Project-Speedy/Reviews/server/data/reviews_photos.csv' DELIMITER ',' CSV HEADER;
\CREATE INDEX idx_photo_id on photos(id);
\CREATE INDEX idx_photo_review_id on photos(review_id);


-- ---
-- Table 'characteristics'
--
-- ---

DROP TABLE IF EXISTS characteristics CASCADE;

CREATE TABLE characteristics (
  id BIGSERIAL PRIMARY KEY,
  product_id BIGINT NULL DEFAULT NULL,
  characteristic VARCHAR(20) NULL DEFAULT NULL
);

\COPY characteristics FROM '/home/tofu/Documents/hackreactor/Project-Speedy/Reviews/server/data/characteristics.csv' DELIMITER ',' CSV HEADER;
\CREATE INDEX idx_characteristic_primary_id on characteristics(id);
\CREATE INDEX idx_characteristic_product_id on characteristics(product_id);

-- ---
-- Table 'reviewCharacteristics'
--
-- ---

DROP TABLE IF EXISTS reviewCharacteristics CASCADE;

CREATE TABLE reviewCharacteristics(
  id BIGSERIAL PRIMARY KEY,
  characteristic_id BIGINT NULL DEFAULT NULL,
  review_id BIGINT NULL DEFAULT NULL,
  rating INTEGER NULL DEFAULT NULL
);

\COPY reviewCharacteristics FROM '/home/tofu/Documents/hackreactor/Project-Speedy/Reviews/server/data/characteristic_reviews.csv' DELIMITER ',' CSV HEADER;
\CREATE INDEX idx_reviewCharacteristics_primary_id on reviewCharacteristics(id);
\CREATE INDEX idx_reviewCharacteristics_characteristic_id on reviewCharacteristics(characteristic_id);
\CREATE INDEX idx_reviewCharacteristics_review_id on reviewCharacteristics(review_id);


-- ---
-- Foreign Keys
-- ---

ALTER TABLE photos ADD FOREIGN KEY (review_id) REFERENCES reviews (id);
ALTER TABLE reviewCharacteristics ADD FOREIGN KEY (characteristic_id) REFERENCES characteristics (id);
ALTER TABLE reviewCharacteristics ADD FOREIGN KEY (review_id) REFERENCES reviews (id);
-- ALTER TABLE meta ADD FOREIGN KEY (ratings_id) REFERENCES ratings (id);
-- ALTER TABLE meta ADD FOREIGN KEY (recommended_id) REFERENCES recommended (id);
-- ALTER TABLE meta ADD FOREIGN KEY (characteristics_id) REFERENCES characteristics (id);
-- ALTER TABLE characteristics ADD FOREIGN KEY (fit_id) REFERENCES fit (id);
-- ALTER TABLE characteristics ADD FOREIGN KEY (length_id) REFERENCES length (id);
-- ALTER TABLE characteristics ADD FOREIGN KEY (comfort_id) REFERENCES comfort (id);
-- ALTER TABLE characteristics ADD FOREIGN KEY (quality_id) REFERENCES quality (id);


-- ---
-- Test Data
-- ---

-- INSERT INTO reviews (rating,summary,recommend,reponse,body,reviewer_name,helpfulness) VALUES
-- (5,'hello', true,'response','body','chungus', 5);
-- INSERT INTO photos (url,review_id) VALUES
-- ('','');
-- INSERT INTO meta (id,ratings_id,recommended_id,characteristics_id) VALUES
-- ('','','');
-- INSERT INTO ratings (id,1,2,3,4,5) VALUES
-- ('','','','','');
-- INSERT INTO recommended (id,false,true) VALUES
-- ('','');
-- INSERT INTO characteristics (id,fit_id,length_id,comfort_id,quality_id) VALUES
-- ('','','','');
-- INSERT INTO fit (id,value) VALUES
-- ('');
-- INSERT INTO length (id,value) VALUES
-- ('');
-- INSERT INTO comfort (id,value) VALUES
-- ('');
-- INSERT INTO quality (id,value) VALUES
-- ('');


-- ---
-- Table 'fit'
--
-- ---

-- DROP TABLE IF EXISTS fit;

-- ---
-- Table 'length'
--
-- ---

-- DROP TABLE IF EXISTS length;

-- ---
-- Table 'comfort'
--
-- ---

-- DROP TABLE IF EXISTS comfort;

-- ---
-- Table 'quality'
--
-- ---

-- DROP TABLE IF EXISTS quality;


-- ---
-- Table 'meta'
--
-- ---

-- DROP TABLE IF EXISTS meta;

-- CREATE TABLE meta (
--   id BIGSERIAL PRIMARY KEY,
--   ratings_id INTEGER NULL DEFAULT NULL,
--   recommended_id INTEGER NULL DEFAULT NULL,
--   characteristics_id INTEGER NULL DEFAULT NULL
-- );

-- ---
-- Table 'ratings'
--
-- ---

-- DROP TABLE IF EXISTS ratings;

-- CREATE TABLE ratings (
--   id BIGSERIAL PRIMARY KEY,
--   one INTEGER NULL DEFAULT NULL,
--   two INTEGER NULL DEFAULT NULL,
--   three INTEGER NULL DEFAULT NULL,
--   four INTEGER NULL DEFAULT NULL,
--   five INTEGER NULL DEFAULT NULL
-- );

-- ---
-- Table 'recommended'
--
-- ---

-- DROP TABLE IF EXISTS recommended;

-- CREATE TABLE recommended (
--   id BIGSERIAL PRIMARY KEY,
--   f INTEGER NULL DEFAULT NULL,
--   t INTEGER NULL DEFAULT NULL
-- );