create_misc_dots <- function() {

        empty <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))

        # Combining Diacritical Marks
        cda <- empty
        cda[12:13, 8:9] <- 1L

        cdda <- empty
        cdda[12:13, c(6:7, 10:11)] <- 1L

        cdb <- empty
        cdb[4:5, 8:9] <- 1L

        cddb <- empty
        cddb[4:5, c(6:7, 10:11)] <- 1L

        cdar <- empty
        cdar[12:13, 12:13] <- 1L

        # Combining Diacritical Marks Supplement
        cdal <- empty
        cdal[12:13, 4:5] <- 1L

        cdbl <- empty  # Draft Candidate for Unicode 14.0
        cdbl[4:5, 4:5] <- 1L

        # Mathematical Operators
        mh... <- ur... <- dr... <- empty
        mh...[8:9, c(4:5, 8:9, 12:13)] <- 1L
        ur...[4:5, 4:5] <- 1L
        ur...[8:9, 8:9] <- 1L
        ur...[12:13, 12:13] <- 1L
        dr...[4:5, 12:13] <- 1L
        dr...[8:9, 8:9] <- 1L
        dr...[12:13, 4:5] <- 1L

        # CJK Symbols and Punctuation
        space <- left_dot <- left_2dots <- bm_bitmap(matrix(0L, 16L, 16L))
        left_dot[8:9, 4:5] <- 1L
        left_2dots[c(6:7, 10:11), 4:5] <- 1L

        # Katakana
        middle_dot <- bm_bitmap(matrix(0L, 16L, 16L))
        middle_dot[8:9, 8:9] <- 1L

        # Musical Symbols
        right_dot <- bm_bitmap(matrix(0L, 16L, 16L))
        right_dot[8:9, 12:13] <- 1L
        blm <- bm_list(`U+0307` = cda, `U+0308` = cdda,
                       `U+0323` = cdb, `U+0324` = cddb,
                       `U+0358` = cdar, `U+1DF8` = cdal, `U+1DFA` = cdbl,
                       `U+22EF` = mh..., `U+22F0` = ur..., `U+22F1` = dr...,
                       `U+3000` = space, `U+302E` = left_dot,
                       `U+302F` = left_2dots,
                       `U+30FB` = middle_dot, `U+1D16D` = right_dot)
        blm
}
