const express = require('express');
const axios = require('axios');
const path = require('path');
const { Pool, Client } = require('pg')

const pool = new Pool({
  host: 'localhost',
  user: 'tofustore',
  password: '56505under',
  database: 'test',
})

// const pgp = require('pg-promise')();
// const db = pgp('postgress://tofustore:56505under@localhost:4000/test');

const app = express();
const PORT = 4000 || process.env.PORT;

app.use(express.static('client/dist'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/product/reviews', (req, res) => {
  pool.query('select summary from reviews where id = 1', (err, results) => {
    if (err) {
      res.send(err);
    } else {
      res.send(results.rows[0]);
    }
  })

})

app.listen(PORT, () => {
  console.log(`Server listening on port: ${PORT}`);
});