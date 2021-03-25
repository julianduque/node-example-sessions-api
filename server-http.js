'use strict';

const http = require('http');
const port = process.env.PORT || 3000;
const sessions = require('./sessions.json');

const server = http.createServer((req, res) => {
  if (req.url === '/') {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.write('<h1>Hello Salesforce Developers</h1>');
    res.write('<p>This is our first Node app</p>');
  } else if (req.url === '/api/sessions') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.write(JSON.stringify(sessions));
  } else {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.write(`404: Not found - ${req.url}`);
  }

  res.end();
});

server.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
