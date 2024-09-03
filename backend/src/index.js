const express = require("express");
const path = require("path");
const db = require("./config/database");
const route = require("./routes/api");
require("dotenv").config();
var cookieParser = require("cookie-parser");

//Connect to database
db.connect();

const app = express();
const port = process.env.PORT || 3001;

//middleware
app.use(
  express.urlencoded({
    extended: true,
  })
); //res
app.use(express.json()); //req

app.use(cookieParser());

route(app);

app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
