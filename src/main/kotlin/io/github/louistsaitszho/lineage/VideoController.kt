package io.github.louistsaitszho.lineage

import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestHeader
import org.springframework.web.bind.annotation.RestController

@RestController
class VideoController {

//    val counter = AtomicLong()
//
//    @GetMapping("/greeting")
//    fun greeting(@RequestParam(value = "name", defaultValue = "World") name: String): Greeting {
//        return Greeting(counter.incrementAndGet(), "Hello, $name")
//    }

    @GetMapping("/rest/v1/videos")
    fun getVideos(@RequestHeader(value = "access_token") accessToken: String): Response<VideoAttributes> {
        return Response(
                listOf(
                        Data("1", "1", VideoAttributes("1", "1", "1")),
                        Data("1", "1", VideoAttributes("1", "1", "1")),
                        Data("1", "1", VideoAttributes("1", "1", "1")),
                        Data("1", "1", VideoAttributes("1", "1", "1")),
                        Data("1", "1", VideoAttributes("1", "1", "1"))
                ),
                null
        )
    }

    @GetMapping("/rest/v1/modules")
    fun getModules(@RequestHeader(value = "access_token") accessToken: String): Response<ModuleAttributes> {
        return Response(
                listOf(
                        Data("1", "1", ModuleAttributes("1")),
                        Data("1", "1", ModuleAttributes("1")),
                        Data("1", "1", ModuleAttributes("1")),
                        Data("1", "1", ModuleAttributes("1")),
                        Data("1", "1", ModuleAttributes("1"))
                ),
                null
        )
    }
}
