const express = require('express');
const axios = require('axios');
const path = require('path');
const { Pool, Client } = require('pg')
const pass = require ('./config')

const pool = new Pool({
  host: 'localhost',
  user: 'tofustore',
  password: pass,
  database: 'test',
})

const app = express();
const PORT = 4000 || process.env.PORT;

app.use(express.static('client/dist'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/reviews', (req, res) => {
  let id = req._parsedUrl.query;
  id = id.slice(id.indexOf('=') + 1);
  pool.query('select * from reviews left join photos on reviews.id = photos.review_id where product_id = $1', [id], (err, results) => {
    if (err) {
      res.send(err);
    } else {
      results.rows.forEach((row) => {
        row.photos = [row.urls];
        let d = new Date(row.dates * 1000);
        row.date = d.toISOString();
      })
      let reviews = {
        product: id,
        page: 0,
        count: results.rows.length,
        results: results.rows
      };
      res.send(reviews);
    }
  })
})

app.post('/reviews', (req, res) => {
  let reviewID = 0;
  let photosID = 0;
  let characteristicID = 0;
  pool.query("SELECT max(id) FROM reviews", (err, results) => {
    if (err) {
      res.send(err);
    } else {
      reviewID = results.rows[0].max + 1;
      pool.query("insert into reviews (id, product_id, rating, dates, summary, body, recommend, reported, reviewer_name, reviewer_email, response, helpfulness) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12) returning *", [reviewID, req.body.product_id, req.body.rating, 0, req.body.summary, req.body.body, req.body.recommend, false, req.body.name, req.body.email, null, 0], (err, results) => {
        if(err) {
          res.send(err);
        } else {
          pool.query("SELECT max(id) FROM photos", (err, results) => {
            if (err) {
              res.send(err);
            } else {
              photosID = results.rows[0].max + 1;
                pool.query("insert into photos (id, review_id, urls) values ($1, $2, $3)", [photosID, reviewID, req.body.photos[0]], (err, results) => {
                  if(err) {
                    res.send(err);
                  } else {
                    pool.query("SELECT max(id) FROM characteristics", (err, results) => {
                      if (err) {
                        res.send(err);
                      } else {
                        characteristicID = results.rows[0].max + 1;
                        for (let i = 0; i < req.body.photos.length; i++) {
                          pool.query("insert into characteristics (id, product_id, characteristic) values ($1, $2, $3)", [req.body.characteristics, req.body.product_id], (err, results) => {
                            if(err) {
                              res.send(err);
                            } else {

                            }
                          })
                        }
                      }
                    })
                  }
                })
            }
          })
        }
      })
    }
  })
})

app.get('/reviews/meta', (req, res) => {
  let id = req._parsedUrl.query;
  id = id.slice(id.indexOf('=') + 1);
  let meta = {
    ratings: {},
    recommended: {},
    characteristics: {}
  }
  pool.query("select count(rating) from reviews where product_id = $1 and rating = 1 union all select count(rating) from reviews where product_id = $1 and rating = 2 union all select count(rating) from reviews where product_id = $1 and rating = 3 union all select count(rating) from reviews where product_id = $1 and rating = 4 union all select count(rating) from reviews where product_id = $1 and rating = 5 union all select count(recommend) from reviews where product_id = $1 and recommend = true union all select count(recommend) from reviews where product_id = $1 and recommend = false union all select avg(rating) from characteristics full join reviewCharacteristics on reviewCharacteristics.characteristic_id = characteristics.id where product_id = $1 and characteristic = 'Fit' union all select avg(rating) from characteristics full join reviewCharacteristics on reviewCharacteristics.characteristic_id = characteristics.id where product_id = $1 and characteristic = 'Length' union all select avg(rating) from characteristics full join reviewCharacteristics on reviewCharacteristics.characteristic_id = characteristics.id where product_id = $1 and characteristic = 'Comfort' union all select avg(rating) from characteristics full join reviewCharacteristics on reviewCharacteristics.characteristic_id = characteristics.id where product_id = $1 and characteristic = 'Quality'", [id], (err, results) => {
    if (err) {
      res.send(err);
    } else {
      console.log(results.rows);
      meta.ratings["1"] = results.rows[0].count;
      meta.ratings["2"] = results.rows[1].count;
      meta.ratings["3"] = results.rows[2].count;
      meta.ratings["4"] = results.rows[3].count;
      meta.ratings["5"] = results.rows[4].count;
      meta.recommended["true"] = results.rows[5].count;
      meta.recommended["false"] = results.rows[6].count;
      meta.characteristics["Fit"] = {value: results.rows[7].count};
      meta.characteristics["Length"] = {value: results.rows[8].count};
      meta.characteristics["Comfort"] = {value: results.rows[9].count};
      meta.characteristics["Quality"] = {value: results.rows[10].count};
      res.send(meta);
    }
  })
})

app.listen(PORT, () => {
  console.log(`Server listening on port: ${PORT}`);
});

module.exports = app;