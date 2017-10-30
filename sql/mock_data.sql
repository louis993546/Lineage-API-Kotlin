INSERT INTO "public"."modules"("id", "name") VALUES('1', 'English (I)') RETURNING "id", "name";
INSERT INTO "public"."modules"("id", "name") VALUES('2', 'English (II)') RETURNING "id", "name";
INSERT INTO "public"."modules"("id", "name") VALUES('3', 'Deutsch (I)') RETURNING "id", "name";
INSERT INTO "public"."modules"("id", "name") VALUES('4', 'Deutsch (II)') RETURNING "id", "name";

INSERT INTO "public"."schools"("id", "name", "access_code") VALUES('1', 'School 1', '123') RETURNING "id", "name", "access_code";
INSERT INTO "public"."schools"("id", "name", "access_code") VALUES('2', 'School 2', '1234') RETURNING "id", "name", "access_code";
INSERT INTO "public"."schools"("id", "name", "access_code") VALUES('3', 'School 3', '12345') RETURNING "id", "name", "access_code";

INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('1', 'a', '123', 'youtube', '1');
INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('2', 'b', '234', 'youtube', '1');
INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('3', 'c', '345', 'gdrive', '3');
INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('4', 'd', '456', 'dropbox', '2');
INSERT INTO "public"."videos"("id", "title", "url", "host_on", "module_id") VALUES('5', 'e', '567', 'gdrive', '2');

INSERT INTO "public"."schools_modules"("id", "school_id", "module_id") VALUES('1', '1', '1') RETURNING "id", "school_id", "module_id";