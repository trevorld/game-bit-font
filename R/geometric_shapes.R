create_geometric_shapes <- function() {
    bml <- bm_list()
    empty <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))

    bml[["U+25A0"]] <- black_square <- bm_bitmap(matrix(1L, nrow = 16L, ncol = 16L))

    bml[["U+25A1"]] <- white_square <- bm_outline(black_square)

    gp_ol <- gpar(fill = NA, col = "black", lwd = 1L)
    bml[["U+25A2"]] <- as_bm_bitmap(roundrectGrob(r = unit(0.3, "snpc"), gp = gp_ol),
                                    width = 16L, height = 16L)

    medium_square <- empty
    medium_square[5:12, 5:12] <- 1L
    bml[["U+25A3"]] <- bm_overlay(white_square, medium_square)

    square_hf <- white_square
    square_hf[c(4, 7, 10, 13), ] <- 1L
    bml[["U+25A4"]] <- square_hf

    square_vf <- white_square
    square_vf[, c(4, 7, 10, 13)] <- 1L
    bml[["U+25A5"]] <- square_vf

    bml[["U+25A6"]] <- bm_overlay(square_hf, square_vf)

    diagonal <- bm_bitmap(diag(16))
    diagonal <- diagonal |>
                bm_overlay(bm_shift(diagonal, right = 5L)) |>
                # bm_overlay(bm_shift(diagonal, right = 6L)) |>
                bm_overlay(bm_shift(diagonal, right = 10L)) |>
                # bm_overlay(bm_shift(diagonal, right = 12L)) |>
                bm_overlay(bm_shift(diagonal, left = 5L)) |>
                # bm_overlay(bm_shift(diagonal, left = 6L)) |>
                bm_overlay(bm_shift(diagonal, left = 10L))
                # bm_overlay(bm_shift(diagonal, left = 12L))
    bml[["U+25A7"]] <- bm_overlay(white_square, diagonal)
    bml[["U+25A8"]] <- bm_overlay(white_square, bm_flip(diagonal, "horizontal"))
    # bml[["U+25A9"]] <- bm_overlay(bml[["U+25A7"]], bml[["U+25A8"]])

    black_diamond <- empty
    black_diamond[c(1, 16), 8:9] <- 1L
    black_diamond[c(2, 15), 7:10] <- 1L
    black_diamond[c(3, 14), 6:11] <- 1L
    black_diamond[c(4, 13), 5:12] <- 1L
    black_diamond[c(5, 12), 4:13] <- 1L
    black_diamond[c(6, 11), 3:14] <- 1L
    black_diamond[c(7, 10), 2:15] <- 1L
    black_diamond[c(8,  9), 1:16] <- 1L

    white_diamond <- bm_outline(black_diamond)

    medium_diamond <- bm_mask(black_diamond, white_diamond)
    for (i in seq(2)) {
        medium_outline <- bm_outline(medium_diamond)
        medium_diamond <- bm_mask(medium_diamond, medium_outline)
    }

    bml[["U+25C6"]] <- black_diamond
    bml[["U+25C7"]] <- white_diamond
    bml[["U+25C8"]] <- bm_overlay(white_diamond, medium_diamond)

    black_circle <- as_bm_bitmap(circleGrob(), width = 16L, height = 16L)
    dotted_circle <- white_circle <- bm_outline(black_circle)
    dotted_circle[c(5:6, 11:12), ] <- 0L
    dotted_circle[, c(5:6, 11:12)] <- 0L

    medium_black_circle <- as_bm_bitmap(circleGrob(r = 5/16), width = 16L, height = 16L)
    medium_white_circle <- bm_outline(medium_black_circle)

    bml[["U+25C9"]] <- bm_overlay(white_circle, medium_black_circle)

    bml[["U+25CB"]] <- white_circle
    bml[["U+25CC"]] <- dotted_circle
    bml[["U+25CD"]] <- bm_overlay(white_circle,
                                  bm_mask(black_circle, square_vf, mode = "alpha"))
    bml[["U+25CE"]] <- bm_overlay(white_circle, medium_white_circle)
    bml[["U+25CF"]] <- black_circle

    bml
}
