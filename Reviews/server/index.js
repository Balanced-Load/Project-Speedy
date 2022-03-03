const express = require('express');
const axios = require('axios');
const path = require('path');

const app = express();
const PORT = 4000 || process.env.PORT;

app.use(express.static('client/dist'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.listen(PORT, () => {
  console.log(`Server listening on port: ${PORT}`);
});