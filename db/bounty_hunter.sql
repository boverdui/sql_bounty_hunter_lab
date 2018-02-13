DROP TABLE IF EXISTS bounty;

CREATE TABLE bounty (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  bounty_value INT2,
  danger_level VARCHAR(255),
  favourite_weapon VARCHAR(255)
);
