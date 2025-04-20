const express = require('express');
const app = express();
const port = 3000;

// Optional: Read environment variable MESSAGE
const message = process.env.MESSAGE || 'Hello from Microservice';

app.get('/', (req, res) => {
    res.send(message);
});

app.listen(port, () => {
    console.log(`Microservice listening at http://localhost:${port}`);
});
