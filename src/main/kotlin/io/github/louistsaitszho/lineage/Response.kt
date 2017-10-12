package io.github.louistsaitszho.lineage

/**
 * Created by louistsai on 22.07.17.
 */
data class Response<out T> (val data : List<Data<T>>?, val errors : List<Error>?)