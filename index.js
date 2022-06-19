const express = require('express');

const app = express();

const httpPort = 3000;

app.get('/', (req, res) => {
    res.send('Hello world!');
});

app.listen(httpPort, () => {
    console.log("Listening on port", httpPort, `for http. Local: http://localhost:${httpPort}`);
});
