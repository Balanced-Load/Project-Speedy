-- ---
-- Globals
-- ---

-- SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
-- SET FOREIGN_KEY_CHECKS=0;

-- ---
-- Table 'reviews'
--
-- ---

DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews (
  id BIGSERIAL PRIMARY KEY,
  rating INTEGER NULL DEFAULT NULL,
  summary VARCHAR(200) NULL DEFAULT NULL,
  recommend BOOLEAN NULL DEFAULT NULL,
  reponse VARCHAR(200) NULL DEFAULT NULL,
  body VARCHAR(500) NULL DEFAULT NULL,
  date DATE NULL DEFAULT NULL,
  reviewer_name VARCHAR(50) NULL DEFAULT NULL,
  helpfulness INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'photos'
--
-- ---

DROP TABLE IF EXISTS photos;

CREATE TABLE photos (
  id BIGSERIAL PRIMARY KEY,
  url VARCHAR(100) NULL DEFAULT NULL,
  review_id INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'meta'
--
-- ---

DROP TABLE IF EXISTS meta;

CREATE TABLE meta (
  id BIGSERIAL PRIMARY KEY,
  ratings_id INTEGER NULL DEFAULT NULL,
  recommended_id INTEGER NULL DEFAULT NULL,
  characteristics_id INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'ratings'
--
-- ---

DROP TABLE IF EXISTS ratings;

CREATE TABLE ratings (
  id BIGSERIAL PRIMARY KEY,
  one INTEGER NULL DEFAULT NULL,
  two INTEGER NULL DEFAULT NULL,
  three INTEGER NULL DEFAULT NULL,
  four INTEGER NULL DEFAULT NULL,
  five INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'recommended'
--
-- ---

DROP TABLE IF EXISTS recommended;

CREATE TABLE recommended (
  id BIGSERIAL PRIMARY KEY,
  f INTEGER NULL DEFAULT NULL,
  t INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'characteristics'
--
-- ---

DROP TABLE IF EXISTS characteristics;

CREATE TABLE characteristics (
  id BIGSERIAL PRIMARY KEY,
  fit_id INTEGER NULL DEFAULT NULL,
  length_id INTEGER NULL DEFAULT NULL,
  comfort_id INTEGER NULL DEFAULT NULL,
  quality_id INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'fit'
--
-- ---

DROP TABLE IF EXISTS fit;

CREATE TABLE fit (
  id BIGSERIAL PRIMARY KEY,
  value INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'length'
--
-- ---

DROP TABLE IF EXISTS length;

CREATE TABLE length (
  id BIGSERIAL PRIMARY KEY,
  value INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'comfort'
--
-- ---

DROP TABLE IF EXISTS comfort;

CREATE TABLE comfort (
  id BIGSERIAL PRIMARY KEY,
  value INTEGER NULL DEFAULT NULL
);

-- ---
-- Table 'quality'
--
-- ---

DROP TABLE IF EXISTS quality;

CREATE TABLE quality (
  id BIGSERIAL PRIMARY KEY,
  value INTEGER NULL DEFAULT NULL
);

-- ---
-- Foreign Keys
-- ---

ALTER TABLE photos ADD FOREIGN KEY (review_id) REFERENCES reviews (id);
ALTER TABLE meta ADD FOREIGN KEY (ratings_id) REFERENCES ratings (id);
ALTER TABLE meta ADD FOREIGN KEY (recommended_id) REFERENCES recommended (id);
ALTER TABLE meta ADD FOREIGN KEY (characteristics_id) REFERENCES characteristics (id);
ALTER TABLE characteristics ADD FOREIGN KEY (fit_id) REFERENCES fit (id);
ALTER TABLE characteristics ADD FOREIGN KEY (length_id) REFERENCES length (id);
ALTER TABLE characteristics ADD FOREIGN KEY (comfort_id) REFERENCES comfort (id);
ALTER TABLE characteristics ADD FOREIGN KEY (quality_id) REFERENCES quality (id);


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