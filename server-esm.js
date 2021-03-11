"use strict";

import http from "http";
import fs from "fs";

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
  if (req.url === "/") {
    res.writeHead(200, { "Content-Type": "text/html" });
    res.write("<h1>Hello World</h1>");
  } else if (req.url === "/api/sessions") {
    const sessions = fs.readFileSync(
      new URL("./sessions.json", import.meta.url),
      "utf8"
    );
    res.writeHead(200, { "Content-Type": "application/json" });
    res.write(sessions);
  } else {
    res.writeHead(404, { "Content-Type": "text/plain" });
    res.write(`404: ${req.url} not found`);
  }

  res.end();
});

server.listen(PORT, () => {
  console.log(`Server listening on port http://localhost:${PORT}`);
});