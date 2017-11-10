package io.github.louistsaitszho.lineage

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController

@RestController
class VideoController {
    val connection = Database.getConnection()

//    val counter = AtomicLong()
//
//    @GetMapping("/greeting")
//    fun greeting(@RequestParam(value = "name", defaultValue = "World") name: String): Greeting {
//        return Greeting(counter.incrementAndGet(), "Hello, $name")
//    }

    //todo ask for module id in param
    @GetMapping("/rest/v1/videos")
    fun getVideos(
            @RequestHeader(name = "access_token") accessToken: String,
            @RequestParam(name = "module_id") moduleId: String
    ) : Response<VideoAttributes> {
        val statement = connection?.createStatement()
        val rs = statement?.executeQuery("SELECT v.id AS id, 'video' AS type, u.title AS title, u.url AS url, u.host_on AS host FROM videos AS v, schools AS s, schools_modules AS sm,( SELECT v.id, v.title, v.url, v.host_on, v.module_id FROM videos AS v, schools AS s, schools_modules AS sm WHERE s.access_code = '123' AND s.id = sm.school_id AND v.module_id = sm.module_id AND v.module_id = '1') u WHERE s.access_code = '123' AND s.id = sm.school_id AND v.module_id = sm.module_id AND v.module_id = '1' AND v.id = u.id;")
        val dataList = mutableListOf<Data<VideoAttributes>>()
        while (rs?.next() == true) {
            val id = rs.getString("id")
            val type = rs.getString("type")
            val title = rs.getString("title")
            val link = rs.getString("url")
            val host = rs.getString("host")
            dataList.add(Data(id, type, VideoAttributes(title, link, host)))
        }
        return Response(dataList, null)
    }

    @GetMapping("/rest/v1/modules")
    fun getModules(@RequestHeader(value = "access_token") accessToken: String): Response<ModuleAttributes> {
        val statement = connection?.createStatement()
        val rs = statement?.executeQuery("SELECT m.id AS id, 'module' AS type, attr.name AS name FROM schools AS s, schools_modules AS sm, modules AS m,( SELECT m.id, m.name FROM schools AS s, schools_modules AS sm, modules AS m WHERE s.access_code = '123' AND s.id = sm.school_id AND m.id = sm.module_id) attr WHERE s.access_code = '123' AND s.id = sm.school_id AND m.id = sm.module_id and m.id = attr.id;")
        val dataList = mutableListOf<Data<ModuleAttributes>>()
        while (rs?.next() == true) {
            val id = rs.getString("id")
            val type = rs.getString("type")
            val name = rs.getString("name")
            dataList.add(Data(id, type, ModuleAttributes(name)))
        }
        return Response(dataList, null)
    }
}
