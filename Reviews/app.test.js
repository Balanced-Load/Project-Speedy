const request = require("supertest");
const app = require("./server/index");

describe("Test reviews endpoint", () => {
  test("GET /reviews", (done) => {
    request(app)
      .get("/reviews/?product_id=40344")
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        return done();
      })
  });
});

describe("Test meta endpoint", () => {
  test("GET /reviews/meta", (done) => {
    request(app)
      .get("/reviews/meta/?product_id=40344")
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        return done();
      })
  });
});

describe("Test reviews post endpoint", () => {
  test("POST /reviews", (done) => {
    request(app)
      .post("/reviews")
      .send(
        {
          "product_id": 40347,
          "rating": 5,
          "summary": "summary",
          "body": "body",
          "recommend": false,
          "name": "name",
          "email": "email@gmail.com",
          "photos": ["photo1", "photo2"],
          "characteristics": {"14": 5, "15": 1}
        }
      )
      .expect(200)
      .end((err, res) => {
        if (err) return done(err);
        return done();
      })
  });
});