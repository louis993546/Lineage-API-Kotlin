package io.github.louistsaitszho.lineage

import org.springframework.boot.SpringApplication
import org.springframework.boot.autoconfigure.SpringBootApplication
import java.sql.Connection
import java.sql.DriverManager

@SpringBootApplication
class Application

fun main(args: Array<String>) {
    SpringApplication.run(Application::class.java, *args)
}

object Database {
    fun getConnection(): Connection? {
        val dbUrl = "jdbc:postgresql://ec2-54-75-225-143.eu-west-1.compute.amazonaws.com:5432/d10bj9jcb3i405?sslmode=require"
        return DriverManager.getConnection(dbUrl, "kyjzsebscmyhuc", "64d902a525d27025195e065e333f51985235c3af4cf5649705f82a9a95488282")
    }
}