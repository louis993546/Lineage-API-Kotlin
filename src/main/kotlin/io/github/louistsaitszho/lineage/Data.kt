package io.github.louistsaitszho.lineage

/**
 * Created by louistsai on 22.07.17.
 */
data class Data<out T>(val id : String, val type : String, val attributes : T)