create_combining_diacritical_marks_for_symbols <- function(geometric_shapes) {
    blm <- bm_list()
    empty <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))

    three_dots_above <- empty
    three_dots_above[12:13, c(4:5, 8:9, 12:13)] <- 1L

    three_dots_below <- empty
    three_dots_below[4:5, c(4:5, 8:9, 12:13)] <- 1L

    blm[["U+20DB"]] <- three_dots_above
    blm[["U+20DD"]] <- geometric_shapes[["U+25CB"]] # enclosing circle
    blm[["U+20DE"]] <- geometric_shapes[["U+25A1"]] # enclosing square
    blm[["U+20DF"]] <- geometric_shapes[["U+25C7"]] # enclosing diamond
    blm[["U+20E8"]] <- three_dots_below
    blm
}
