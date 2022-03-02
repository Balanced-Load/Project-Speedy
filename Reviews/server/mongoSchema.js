const mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/fetcher');

let reviewSchema = mongoose.Schema({
  // TODO: your schema here!
  id: {type: String, unique: true},
  product_id: String,
  rating: String,
  summary: String,
  recommend: Boolean,
  response: String,
  body: String,
  date: Date,
  reviewer_name: String,
  helpfulness:  String,
  photos: Array
});

let metaSchema = mongoose.Schema({
  id: {type: String, unique: true},
  ratings: Object,
  recommended: Object,
  characteristics: Object
});

let Review = mongoose.model('Review', reviewSchema);
let Meta = mongoose.model('Meta', metaSchema);

// let save = (repo) => {
//   // TODO: Your code here
//   // This function should save a repo or repos to
//   // the MongoDB{{
//   var newRepo = new Repo({id: repo.id, name: repo.name, link: repo.html_url, size:repo.size});

//   newRepo.save((err, repo) => {
//     if (err) {
//       return console.log(err);
//     } else {
//       console.log(repo.name + ' is saved');
//     }
//   })
// }

// let retrieve = (callback) => {{}
//   Repo.find({}, (err, repos) => {
//     callback(err, repos);
//   }).sort({size: -1}).limit(25);
// }

// module.exports.save = save;
// module.exports.retrieve = retrieve;