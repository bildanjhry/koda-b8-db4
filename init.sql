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
    "address" VARCHAR(255),
    "status" INT DEFAULT 9,
    "created_at" TIMESTAMP DEFAULT NOW(),
    "upadated_at" TIMESTAMP DEFAULT NOW()
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
UPDATE "user_details" SET status = 4 WHERE email = 'billy@mail.com';

---- LOGIN ADMIN -----
SELECT "email", "password" FROM "users" WHERE email = 'admin@mail.com' AND password = '12345';
UPDATE "user_details" SET status = 6 WHERE email = 'admin@mail.com';

--- LOGOUT ---
UPDATE "user_details" SET status = (SELECT "status" FROM "user_details" WHERE email = 'billy@mail.com')-3 WHERE email = 'billy@mail.com';

----- FORGOT PASSWORD ----
UPDATE "users" set password = '543212' WHERE email = (SELECT "email" FROM "user_details" WHERE email = 'billy@mail.com' AND status | 3 = 3);

---- LIST OF ALL USERS ------
SELECT "users"."email", "user_details"."name", "user_details"."status" FROM "users"
JOIN "user_details" ON "user_details"."id_user" = "users"."id";
