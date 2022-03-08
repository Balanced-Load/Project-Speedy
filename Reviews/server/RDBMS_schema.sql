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
CREATE INDEX idx_id on reviews(id);
CREATE INDEX idx_product_id on reviews(product_id);
CREATE INDEX idx_reviews_rating on reviews(rating);


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
CREATE INDEX idx_photo_id on photos(id);
CREATE INDEX idx_photo_review_id on photos(review_id);


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
CREATE INDEX idx_characteristic_primary_id on characteristics(id);
CREATE INDEX idx_characteristic_product_id on characteristics(product_id);

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
CREATE INDEX idx_reviewCharacteristics_primary_id on reviewCharacteristics(id);
CREATE INDEX idx_reviewCharacteristics_characteristic_id on reviewCharacteristics(characteristic_id);
CREATE INDEX idx_reviewCharacteristics_review_id on reviewCharacteristics(review_id);


-- ---
-- Foreign Keys
-- ---

ALTER TABLE photos ADD FOREIGN KEY (review_id) REFERENCES reviews (id);
ALTER TABLE reviewCharacteristics ADD FOREIGN KEY (characteristic_id) REFERENCES characteristics (id);
ALTER TABLE reviewCharacteristics ADD FOREIGN KEY (review_id) REFERENCES reviews (id);

\CREATE MATERIALIZED VIEW entire_review as select product_id, rating, dates, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness, urls, reviews.id as review_id from reviews left join photos on reviews.id = photos.review_id;

CREATE INDEX index_entire_review_product_id on entire_review(product_id);

