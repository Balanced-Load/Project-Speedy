import http from 'k6/http';
import { sleep } from 'k6';

const randomID = Math.floor(Math.random() * (200000) + 1);
const url = `http://localhost:4000/reviews/?product_id=41252`;

export default function () {
  http.get(url);
  sleep(1);
}