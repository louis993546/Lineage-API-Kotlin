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

INSERT INTO "public"."modules"("id", "name") VALUES('1', 'English (I)') RETURNING "id", "name";
INSERT INTO "public"."modules"("id", "name") VALUES('2', 'English (II)') RETURNING "id", "name";
INSERT INTO "public"."modules"("id", "name") VALUES('3', 'Deutsch (I)') RETURNING "id", "name";
INSERT INTO "public"."modules"("id", "name") VALUES('4', 'Deutsch (II)') RETURNING "id", "name";

INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('1', 'a', '123', 'youtube', '1');
INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('2', 'b', '234', 'youtube', '1');
INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('3', 'c', '345', 'gdrive', '3');
INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('4', 'd', '456', 'dropbox', '2');
INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('5', 'e', '567', 'gdrive', '2');

INSERT INTO "public"."schools_modules"("id", "school_id", "module_id") VALUES('1', '1', '1') RETURNING "id", "school_id", "module_id";

-- get list of videos that user with access code '123' have access to in a particular module
SELECT
	array_to_json(array_agg(row_to_json(w)))
FROM
	(
		SELECT
			v.id AS id,
    		'video' AS type,
			json_build_object('title', u.title, 'link', u.url, 'host', u.host_on, 'module_id', u.module_id) AS attributes
		FROM
			videos AS v,
			schools AS s,
			schools_modules AS sm,
			(
				SELECT
					v.id,
					v.title,
					v.url,
					v.host_on,
					v.module_id
				FROM
					videos AS v,
					schools AS s,
					schools_modules AS sm
				WHERE
					s.access_code = '123' AND
					s.id = sm.school_id AND
					v.module_id = sm.module_id AND
					v.module_id = '1'
			) u
		WHERE
			s.access_code = '123' AND
			s.id = sm.school_id AND
			v.module_id = sm.module_id AND
			v.module_id = '1' AND
			v.id = u.id
	) w;

-- get list of modules that user with access code '123' have access to
SELECT
	array_to_json(array_agg(row_to_json(results)))
FROM
	(
		SELECT
			m.id AS id,
			'module' AS type,
			json_build_object('name', attr.name) AS attributes
		FROM
			schools AS s,
			schools_modules AS sm,
			modules AS m,
			(
				SELECT
					m.id,
					m.name
				FROM
					schools AS s,
					schools_modules AS sm,
					modules AS m
				WHERE
					s.access_code = '123' AND
					s.id = sm.school_id AND
					m.id = sm.module_id
			) attr
			WHERE
				s.access_code = '123' AND
				s.id = sm.school_id AND
				m.id = sm.module_id and
				m.id = attr.id
	) results;