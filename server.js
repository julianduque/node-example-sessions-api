'use strict';

const fs = require('fs');
const path = require('path');
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const db = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
});

const app = express();
const port = process.env.PORT || 3001;
const sessions = fs.readFileSync(path.join(__dirname, 'sessions.json'), 'utf8');

app.use(cors());

app.get('/', (req, res) => {
  res.send('<h1>Hello Salesforce Devs from Express</h1>');
});

app.get('/api/sessions', async (req, res) => {
  const { rows } = await db.query(`
  SELECT json_build_object(
    'id', t.id,
    'name', t.name,
    'description', t.description,
    'room', t.room,
    'dateTime', t."datetime",
    'speakers', json_agg(json_build_object(
      'id', s.id,
      'name', s.name,
      'bio', s.bio,
      'pictureUrl', s.pictureurl
      ))
    ) AS session
  FROM sessions t
  INNER JOIN sessions_speakers ts ON ts.session_id = t.id
  INNER JOIN speakers s ON ts.speaker_id = s.id
  GROUP BY t.id
  `);
  res.json(rows);
});

app.listen(port, () => {
  console.log(`Express server running on http://localhost:${port}`);
});
