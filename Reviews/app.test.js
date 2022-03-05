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