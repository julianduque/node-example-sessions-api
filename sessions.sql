

CREATE TABLE sessions
(
  id          serial            NOT NULL,
  name        character varying NOT NULL,
  description text              NOT NULL,
  room        character varying NOT NULL,
  dateTime    timestamptz       NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE sessions_speakers
(
  session_id serial,
  speaker_id serial
);

CREATE TABLE speakers
(
  id         serial            NOT NULL,
  name       character varying NOT NULL,
  bio        character varying NOT NULL,
  email      character varying NOT NULL,
  pictureUrl character varying NOT NULL,
  PRIMARY KEY (id)
);

ALTER TABLE sessions_speakers
  ADD CONSTRAINT FK_sessions_TO_sessions_speakers
    FOREIGN KEY (session_id)
    REFERENCES sessions (id);

ALTER TABLE sessions_speakers
  ADD CONSTRAINT FK_speakers_TO_sessions_speakers
    FOREIGN KEY (speaker_id)
    REFERENCES speakers (id);

INSERT INTO speakers (name, bio, email, pictureUrl)
VALUES (
  'John Doe',
  'Master of all things JavaScript. Cat herder. ECMAScript lover.',
  'john.doe@trailhead.com',
  'https://developer.salesforce.com/files/js-dev/speaker-images/john_doe.jpg'
);

INSERT INTO speakers (name, bio, email, pictureUrl)
VALUES (
  'Laetitia Arevik',
  'Laetitia Arevik codes at night and during the day. Making the web accessible is her mission.',
  'laetitia.arevik@trailhead.com',
  'https://developer.salesforce.com/files/js-dev/speaker-images/laetitia_arevik.jpg'
);

INSERT INTO speakers (name, bio, email, pictureUrl)
VALUES (
  'Meghan Gerald',
  'Grown up with the web as a platform, Meghan''s passion is bringing the latest enhancements of web development to the broader developer community.',
  'meghan.gerald@trailhead.com',
  'https://developer.salesforce.com/files/js-dev/speaker-images/meghan_gerald.jpg'
);

INSERT INTO speakers (name, bio, email, pictureUrl)
VALUES (
  'Ermenrich Nalani',
  'Ermenrich codes for fun and profit. You can wake him up at 3am in the night, and he will code you away.',
  'ermenrich.nalani@trailhead.com',
  'https://developer.salesforce.com/files/js-dev/speaker-images/ermenrich_nalani.jpg'
);

INSERT INTO sessions (name, description, room, dateTime)
VALUES (
  'The Future of JavaScript',
  'Since its inception in 1995, JavaScript has become the most popular language of the web. With new additions to the ECMAScript standard there are no signs of slowing down on this. Gain insights in this spectacular keynote on what the future will hold.',
  'Keynote room',
  '2020-12-07 10:00:00-05'
);

INSERT INTO sessions (name, description, room, dateTime)
VALUES (
  'Introducing Web Components',
  'With web components developers can embrace a true component based architecture, which utilizes core browser APIs. This makes them easily usable across any modern browser. Come and learn in this session what web components are all about, and how they can make your life easier.',
  'Breakout room A',
  '2020-12-07 11:00:00-05'
);

INSERT INTO sessions (name, description, room, dateTime)
VALUES (
  'Web Components Patterns and Best Practices',
  'You started developing your first web components, and now what? Join this interactive session and learn lessons from the field on how to build first class web component implementations.',
  'Breakout room B',
  '2020-12-07 11:00:00-05'
);

INSERT INTO sessions (name, description, room, dateTime)
VALUES (
  'Advanced Web Components Workshop',
  'Fully embrace the standards that web components are build on. Shadow DOM, custom elements, HTML imports and more. There is a lot to learn, and all of that will be covered.',
  'Theater',
  '2020-12-07 11:30:00-05'
);

INSERT INTO sessions_speakers (session_id, speaker_id) VALUES (1, 1);
INSERT INTO sessions_speakers (session_id, speaker_id) VALUES (1, 2);
INSERT INTO sessions_speakers (session_id, speaker_id) VALUES (2, 3);
INSERT INTO sessions_speakers (session_id, speaker_id) VALUES (3, 3);
INSERT INTO sessions_speakers (session_id, speaker_id) VALUES (3, 4);
INSERT INTO sessions_speakers (session_id, speaker_id) VALUES (4, 2);
INSERT INTO sessions_speakers (session_id, speaker_id) VALUES (4, 4);

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
GROUP BY t.id;