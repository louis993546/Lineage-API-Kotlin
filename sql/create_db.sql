CREATE TABLE schools (id text, name text, access_code text);
CREATE TABLE modules (id text, name text);
CREATE TYPE host AS ENUM ('gdrive', 'youtube', 'dropbox');
CREATE TABLE videos (id text, title text, url text, host_on host, module_id text);

ALTER TABLE "public"."modules" ADD PRIMARY KEY ("id");
ALTER TABLE "public"."schools" ADD PRIMARY KEY ("id");
ALTER TABLE "public"."videos" ADD PRIMARY KEY ("id");

ALTER TABLE videos ADD CONSTRAINT fk_module_of_video FOREIGN KEY (module_id) REFERENCES modules(id);

CREATE TABLE schools_modules (id text, school_id text, module_id text);
ALTER TABLE schools_modules ADD PRIMARY KEY ("id");
ALTER TABLE schools_modules ADD CONSTRAINT fk_school_id FOREIGN KEY (school_id) REFERENCES schools(id);
ALTER TABLE schools_modules ADD CONSTRAINT fk_module_id FOREIGN KEY (module_id) REFERENCES modules(id);

ALTER TABLE "public"."schools" ADD UNIQUE ("access_code");