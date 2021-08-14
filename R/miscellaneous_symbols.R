create_miscellaneous_symbols <- function(unifont,
                                         general_punctuation, geometric_shapes,
                                         mathematical_operators,
                                         braille_patterns, misc_dots) {

    blm <- bm_list()

    # Chess Symbols
    blm[["U+2654"]] <- bm_rotate(unifont[["U+1FA1E"]], 180) # WK
    blm[["U+2655"]] <- bm_rotate(unifont[["U+1FA1F"]], 180) # WQ
    blm[["U+2656"]] <- bm_rotate(unifont[["U+1FA20"]], 180) # WR
    blm[["U+2657"]] <- bm_rotate(unifont[["U+1FA21"]], 180) # WB
    blm[["U+2658"]] <- bm_rotate(unifont[["U+1FA22"]], 180) # WN
    blm[["U+2659"]] <- bm_rotate(unifont[["U+1FA23"]], 180) # WP
    blm[["U+265A"]] <- bm_rotate(unifont[["U+1FA24"]], 180) # BK
    blm[["U+265B"]] <- bm_rotate(unifont[["U+1FA25"]], 180) # BQ
    blm[["U+265C"]] <- bm_rotate(unifont[["U+1FA26"]], 180) # BR
    blm[["U+265D"]] <- bm_rotate(unifont[["U+1FA27"]], 180) # BB
    blm[["U+265E"]] <- bm_rotate(unifont[["U+1FA28"]], 180) # BN
    blm[["U+265F"]] <- bm_rotate(unifont[["U+1FA29"]], 180) # BP

    for (ucp in range2ucp("U+2654..U+265F")[-c(5, 11)]) # Knights don't need to be shifted
        blm[[ucp]] <- bm_shift(blm[[ucp]], right = 1L)

    # Dice
    square <- geometric_shapes[["U+25A1"]]
    blm[["U+2680"]] <- bm_overlay(square, misc_dots[["U+30FB"]])
    blm[["U+2681"]] <- bm_overlay(square, braille_patterns[["U+280C"]])
    blm[["U+2682"]] <- bm_overlay(square, mathematical_operators[["U+22F0"]])
    blm[["U+2683"]] <- bm_overlay(square, braille_patterns[["U+282D"]])
    blm[["U+2684"]] <- bm_overlay(square, general_punctuation[["U+2059"]])
    blm[["U+2685"]] <- bm_overlay(square, braille_patterns[["U+283F"]])

    # Go Markers
    blm[["U+2686"]] <- bm_overlay(geometric_shapes[["U+25CB"]], misc_dots[["U+1D16D"]])
    blm[["U+2687"]] <- bm_overlay(geometric_shapes[["U+25CB"]], braille_patterns[["U+2812"]])
    blm[["U+2688"]] <- bm_mask(geometric_shapes[["U+25CF"]], misc_dots[["U+1D16D"]])
    blm[["U+2689"]] <- bm_mask(geometric_shapes[["U+25CF"]], braille_patterns[["U+2812"]])

    # Checkers
    # Fixed is a public domain font
    fixed_4x6 <- read_yaff(system.file("fonts/fixed/4x6.yaff.gz",
                                       package = "bittermelon"))
    K <- bm_extend(fixed_4x6[[str2ucp("K")]], left=6, right=6, bottom = 8, top = 2)
    K[c(10, 14), 9] <- 0L
    K[c(10, 14), 10] <- 1L

    angle <- seq(0, 2 * pi, length.out = 360)
    angle <- head(angle, -1L)
    x <- 0.5 + 0.5 * cos(angle)
    y <- 0.5 + 0.5 * sin(angle)
    oval_man <- as_bm_bitmap(polygonGrob(x = x, y = 0.75 * y), width = 16, height = 16)
    oval_man_white <- bm_outline(oval_man)
    white_checkers_man <- bm_overlay(bm_mask(oval_man_white, bm_shift(oval_man, top = 4L)),
                                     bm_shift(oval_man_white, top = 4L))
    white_checkers_man[10:11, 8:9] <- 1L

    oval_man <- as_bm_bitmap(polygonGrob(x = x, y = 0.60 * y), width = 16, height = 16)
    oval_man_white <- bm_outline(oval_man)
    white_checkers_king <- bm_overlay(bm_mask(oval_man_white, bm_shift(oval_man, top = 3L)),
                                     bm_shift(oval_man_white, top = 3L))
    white_checkers_king <- bm_overlay(bm_mask(white_checkers_king, bm_shift(oval_man, top = 6L)),
                                     bm_shift(oval_man_white, top = 6L)) |>
                           bm_overlay(K)

    oval_full <- bm_overlay(oval_man, bm_shift(oval_man, top = 3L)) |>
                    bm_overlay(bm_shift(oval_man, top = 6L))
    black_checkers_man_mask <- bm_mask(white_checkers_man, bm_outline(oval_full))
    black_checkers_man <- bm_mask(oval_full,
                                  black_checkers_man_mask)
    black_checkers_man[8, c(1, 16)] <- 0L

    black_checkers_king_mask <- bm_mask(white_checkers_king, bm_outline(oval_full))
    black_checkers_king <- bm_mask(oval_full,
                                   black_checkers_king_mask)
    black_checkers_king[c(7, 10), c(1, 16)] <- 0L
    black_checkers_king[c(5, 12), c(1, 16)] <- 1L

    blm[["U+26C0"]] <- white_checkers_man # White Checkers Man
    blm[["U+26C1"]] <- white_checkers_king  # White Checkers King
    blm[["U+26C2"]] <- black_checkers_man # Black Checkers Man
    blm[["U+26C3"]] <- black_checkers_king # Black Checkers King

    blm
}
