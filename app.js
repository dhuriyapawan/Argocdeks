const express = require("express");
const bodyParser = require("body-parser");
const Database = require("better-sqlite3");

const app = express();

const db = new Database("./database/database.db");

db.prepare(`
CREATE TABLE IF NOT EXISTS users(
id INTEGER PRIMARY KEY AUTOINCREMENT,
username TEXT UNIQUE,
password TEXT
)
`).run();

const count = db.prepare("SELECT COUNT(*) AS total FROM users").get();

if (count.total === 0) {
    db.prepare("INSERT INTO users(username,password) VALUES (?,?)")
        .run("admin", "password");
}

app.use(bodyParser.json());
app.use(express.static("public"));

app.post("/login", (req, res) => {

    const { username, password } = req.body;

    const user = db.prepare(
        "SELECT * FROM users WHERE username=? AND password=?"
    ).get(username, password);

    if (user) {

        res.json({
            success: true,
            message: "Login Successful"
        });

    } else {

        res.status(401).json({
            success: false,
            message: "Invalid Credentials"
        });

    }

});

const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Server running on ${PORT}`);
});