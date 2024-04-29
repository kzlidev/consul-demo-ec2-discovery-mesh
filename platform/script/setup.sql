CREATE TABLE sedemo (
   id serial PRIMARY KEY,
   name VARCHAR(50) UNIQUE NOT NULL,
   description VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO sedemo(id, name, description)
VALUES (1, 'terraform', 'infrastructure-as-code');
INSERT INTO sedemo(id, name, description)
VALUES (2, 'nomad', 'scheduler orchestrator');
INSERT INTO sedemo(id, name, description)
VALUES (3, 'vault', 'secrets');
INSERT INTO sedemo(id, name, description)
VALUES (4, 'consul', 'service mesh');

CREATE ROLE "readonly" NOINHERIT;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO "readonly";

CREATE ROLE "adminuser" NOINHERIT;
GRANT ALL ON ALL TABLES IN SCHEMA public TO "adminuser";
