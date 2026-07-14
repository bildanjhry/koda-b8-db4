-- DROP TABLE "users";
-- DROP TABLE "user_details";

CREATE TABLE "users" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "email" VARCHAR(50) UNIQUE,
    "password" VARCHAR(50) NOT NULL,
    "created_at" TIMESTAMP DEFAULT NOW(),
    "upadated_at" TIMESTAMP DEFAULT NOW()
);
CREATE TABLE "user_details" (
    "id_user" INT REFERENCES "users"("id"),
    "name" VARCHAR(40),
    "email" VARCHAR(40) REFERENCES "users"("email"),
    "address" VARCHAR(255),
    "status" INT DEFAULT 1
);

----- REGISTER USER------
INSERT INTO "users" ("email", "password") VALUES
('billy@mail.com', '12345');
INSERT INTO "user_details" ("id_user", "name", "email") VALUES
((SELECT "id" FROM "users" WHERE email = 'billy@mail.com' ), 'Billy Baggins', 'billy@mail.com');

----- REGISTER ADMIN ------
INSERT INTO "users" ("email", "password") VALUES
('admin@mail.com', '12345');
INSERT INTO "user_details" ("id_user", "name", "email") VALUES
((SELECT "id" FROM "users" WHERE email = 'admin@mail.com'), 'Bildan Jauhary', 'admin@mail.com');
UPDATE "user_details" SET status = 2 WHERE email = 'admin@mail.com';

----- LOGIN ------
SELECT "email", "password" FROM "users" WHERE email = 'billy@mail.com' AND password = '12345';
UPDATE "user_details" SET status = 3 WHERE email = 'billy@mail.com';

---- LOGIN ADMIN -----
SELECT "email", "password" FROM "users" WHERE email = 'admin@mail.com' AND password = '12345';
UPDATE "user_details" SET status = 4 WHERE email = 'admin@mail.com';

---- LOGIN USERS ------
SELECT "users"."email", "user_details"."name", "user_details"."status" FROM "users"
JOIN "user_details" ON "user_details"."id_user" = "users"."id";

SELECT * FROM "user_details";
