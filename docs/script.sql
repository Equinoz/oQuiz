BEGIN;

DROP TABLE IF EXISTS "user",
"quiz",
"question",
"answer",
"level",
"tag",
"_m2m_quiz_tag";

CREATE TABLE "user" (
  "id" integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "email" text NOT NULL,
  "password" text NOT NULL,
  "firstname" text,
  "lastname" text
);

CREATE TABLE "quiz" (
  "id" integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "title" text NOT NULL,
  "description" text,
  "user_id" integer NOT NULL REFERENCES "user" ("id")
);

CREATE TABLE "answer" (
  "id" integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "description" text NOT NULL,
  "question_id" integer NOT NULL
);

CREATE TABLE "level" (
  "id" integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" text NOT NULL
);

CREATE TABLE "question" (
  "id" integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "question" text NOT NULL,
  "anecdote" text,
  "wiki" text,
  "level_id" integer NOT NULL REFERENCES "level" ("id"),
  "answer_id" integer NOT NULL REFERENCES "answer" ("id"),
  "quiz_id" integer NOT NULL REFERENCES "quiz" ("id")
);

CREATE TABLE "tag" (
  "id" integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "name" text NOT NULL
);

CREATE TABLE "_m2m_quiz_tag" (
  "quiz_id" integer REFERENCES "quiz"("id"),
  "tag_id" integer REFERENCES "tag" ("id"),
  PRIMARY KEY ("quiz_id", "tag_id")
);

-- Adding foreign key after question table's creation
    ALTER TABLE "answer"
ADD FOREIGN KEY ("question_id") REFERENCES "question" ("id");

COMMIT;
