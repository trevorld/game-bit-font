create_geometric_shapes <- function(block_elements) {
    bml <- bm_list()
    empty <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))

    # Squares
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
    diagonals <- diagonal |>
                bm_overlay(bm_shift(diagonal, right = 5L)) |>
                # bm_overlay(bm_shift(diagonal, right = 6L)) |>
                bm_overlay(bm_shift(diagonal, right = 10L)) |>
                # bm_overlay(bm_shift(diagonal, right = 12L)) |>
                bm_overlay(bm_shift(diagonal, left = 5L)) |>
                # bm_overlay(bm_shift(diagonal, left = 6L)) |>
                bm_overlay(bm_shift(diagonal, left = 10L))
                # bm_overlay(bm_shift(diagonal, left = 12L))
    bml[["U+25A7"]] <- bm_overlay(white_square, diagonals)
    bml[["U+25A8"]] <- bm_overlay(white_square, bm_flip(diagonals, "horizontal"))

    diagonals2 <- diagonal |>
                    bm_overlay(bm_shift(diagonal, right = 7L)) |>
                    bm_overlay(bm_shift(diagonal, left = 7L))
    bml[["U+25A9"]] <- bm_overlay(white_square, diagonals2) |>
                        bm_overlay(bm_flip(diagonals2, "horizontal"))

    # bml[["U+25A9"]] <- bm_overlay(bml[["U+25A7"]], bml[["U+25A8"]])

    black_med_square <- empty
    black_med_square[3:14, 3:14] <- 1L
    bml[["U+25FB"]] <- bm_outline(black_med_square)
    bml[["U+25FC"]] <- black_med_square
    black_med_small_square <- empty
    black_med_small_square[7:14, 5:12] <- 1L
    bml[["U+25FD"]] <- bm_outline(black_med_small_square) # White Medium Small Square
    bml[["U+25FE"]] <- black_med_small_square

    bml[["U+25E7"]] <- bm_overlay(bm_mask(black_square, block_elements[["U+258C"]], mode = "alpha"),
                                  white_square)
    bml[["U+25E8"]] <- bm_overlay(bm_mask(black_square, block_elements[["U+2590"]], mode = "alpha"),
                                  white_square)
    white_square_vbl <- white_square
    white_square_vbl[ , 8:9] <- 1L
    bml[["U+25EB"]] <- white_square_vbl

    bml[["U+25F0"]] <- bm_overlay(white_square, bm_outline(block_elements[["U+2598"]]))
    bml[["U+25F1"]] <- bm_overlay(white_square, bm_outline(block_elements[["U+2596"]]))
    bml[["U+25F2"]] <- bm_overlay(white_square, bm_outline(block_elements[["U+2597"]]))
    bml[["U+25F3"]] <- bm_overlay(white_square, bm_outline(block_elements[["U+259D"]]))

    black_sm_square <- empty
    black_sm_square[7:10, 7:10] <- 1L
    bml[["U+25AA"]] <- black_sm_square
    bml[["U+25AB"]] <- bm_outline(black_sm_square)

    black_rect <- empty
    black_rect[6:11, 3:14] <- 1L

    bml[["U+25AC"]] <- black_rect
    bml[["U+25AD"]] <- bm_outline(black_rect)
    bml[["U+25AE"]] <- bm_rotate(black_rect, 90)
    bml[["U+25AF"]] <- bm_rotate(bm_outline(black_rect), 90)

    parallelogram <- empty
    parallelogram[7, 3:11] <- 1L
    parallelogram[8, 4:12] <- 1L
    parallelogram[9, 5:13] <- 1L
    parallelogram[10, 6:14] <- 1L
    bml[["U+25B0"]] <- parallelogram
    bml[["U+25B1"]] <- bm_outline(parallelogram)

    # Triangles

    black_triangle <- empty
    black_triangle[1:4, 1:16] <- 1L
    black_triangle[4:6, 2:15] <- 1L
    black_triangle[7:7, 3:14] <- 1L
    black_triangle[8:9, 4:13] <- 1L
    black_triangle[10:11, 5:12] <- 1L
    black_triangle[12:13, 6:11] <- 1L
    black_triangle[14:15, 7:10] <- 1L
    black_triangle[16:16, 8:9] <- 1L
    bml[["U+25B2"]] <- black_triangle
    bml[["U+25B3"]] <- white_triangle <- bm_outline(black_triangle)



    bml[["U+25B6"]] <- bm_rotate(black_triangle, 90)
    bml[["U+25B7"]] <- bm_rotate(white_triangle, 90)

    bml[["U+25BC"]] <- bm_rotate(black_triangle, 180)
    bml[["U+25BD"]] <- bm_rotate(white_triangle, 180)

    bml[["U+25C0"]] <- bm_rotate(black_triangle, 270)
    bml[["U+25C1"]] <- bm_rotate(white_triangle, 270)

    triangle_dot <- white_triangle
    triangle_dot[5:6, 8:9] <- 1L
    bml[["U+25EC"]] <- triangle_dot

    bml[["U+25ED"]] <- bm_overlay(bm_mask(black_triangle, block_elements[["U+258C"]], mode = "alpha"),
                                  white_triangle)
    bml[["U+25EE"]] <- bm_overlay(bm_mask(black_triangle, block_elements[["U+2590"]], mode = "alpha"),
                                  white_triangle)

    black_pointer <- empty
    black_pointer[1:16, 8:9] <- 1L
    black_pointer[1:12, c(7, 10)] <- 1L
    black_pointer[1:08, c(6, 11)] <- 1L
    black_pointer[1:04, c(5, 12)] <- 1L
    white_pointer <- bm_outline(black_pointer)

    bml[["U+25BA"]] <- bm_rotate(black_pointer, 90)
    bml[["U+25BB"]] <- bm_rotate(white_pointer, 90)
    bml[["U+25C4"]] <- bm_rotate(black_pointer, 270)
    bml[["U+25C5"]] <- bm_rotate(white_pointer, 270)

    black_small_triangle <- empty
    black_small_triangle[7:8, 5:12] <- 1L
    black_small_triangle[9:10, 6:11] <- 1L
    black_small_triangle[11:12, 7:10] <- 1L
    black_small_triangle[13:14, 8:9] <- 1L
    bml[["U+25B4"]] <- black_small_triangle
    bml[["U+25B5"]] <- white_small_triangle <- bm_outline(black_small_triangle)

    bml[["U+25B8"]] <- bm_pad(black_small_triangle, sides = 0L) |>
                            bm_rotate(90) |>
                            bm_extend(top = 2L, height = 16L, width = 16L)
    bml[["U+25B9"]] <- bm_outline(bml[["U+25B8"]])

    bml[["U+25BE"]] <- bm_flip(black_small_triangle, "both", in_place = TRUE)
    bml[["U+25BF"]] <- bm_outline(bml[["U+25BE"]])

    bml[["U+25C2"]] <- bm_flip(bml[["U+25B8"]], "horizontal")
    bml[["U+25C3"]] <- bm_outline(bml[["U+25C2"]])

    black_triangle_lr <- empty
    for (i in 1:16) {
        for (j in 1:16) {
            if (i <= j)
                black_triangle_lr[i, j] <- 1L
        }
    }
    bml[["U+25E2"]] <- black_triangle_lr
    bml[["U+25E3"]] <- bm_flip(black_triangle_lr, "horizontal")
    bml[["U+25E4"]] <- bm_flip(black_triangle_lr, "both")
    bml[["U+25E5"]] <- bm_flip(black_triangle_lr, "vertical")

    bml[["U+25F8"]] <- bm_outline(bml[["U+25E4"]])
    bml[["U+25F9"]] <- bm_outline(bml[["U+25E5"]])
    bml[["U+25FA"]] <- bm_outline(bml[["U+25E3"]])
    bml[["U+25FF"]] <- bm_outline(bml[["U+25E2"]])

    # Diamonds
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

    lozenge <- empty
    lozenge[c(1:2, 15:16), 8:9] <- 1L
    lozenge[c(3:4, 13:14), 7:10] <- 1L
    lozenge[c(5:6, 11:12), 6:11] <- 1L
    lozenge[c(7:8, 9:10), 5:12] <- 1L

    bml[["U+25CA"]] <- bm_outline(lozenge)

    # Circles
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

    bml[["U+25D0"]] <- bm_overlay(bm_mask(black_circle, block_elements[["U+258C"]], mode = "alpha"),
                                  white_circle)
    bml[["U+25D1"]] <- bm_overlay(bm_mask(black_circle, block_elements[["U+2590"]], mode = "alpha"),
                                  white_circle)
    bml[["U+25D2"]] <- bm_overlay(bm_mask(black_circle, block_elements[["U+2584"]], mode = "alpha"),
                                  white_circle)
    bml[["U+25D3"]] <- bm_overlay(bm_mask(black_circle, block_elements[["U+2580"]], mode = "alpha"),
                                  white_circle)
    bml[["U+25D4"]] <- bm_overlay(bm_mask(black_circle, block_elements[["U+259D"]], mode = "alpha"),
                                  white_circle)
    bml[["U+25D5"]] <- bm_overlay(bm_mask(black_circle, block_elements[["U+259F"]], mode = "alpha"),
                                  white_circle)
    bml[["U+25D6"]] <- bm_mask(black_circle, block_elements[["U+258C"]], mode = "alpha")
    bml[["U+25D7"]] <- bm_mask(black_circle, block_elements[["U+2590"]], mode = "alpha")

    bml[["U+25DC"]] <- bm_mask(white_circle, block_elements[["U+2598"]], mode = "alpha")
    bml[["U+25DD"]] <- bm_mask(white_circle, block_elements[["U+259D"]], mode = "alpha")
    bml[["U+25DE"]] <- bm_mask(white_circle, block_elements[["U+2597"]], mode = "alpha")
    bml[["U+25DF"]] <- bm_mask(white_circle, block_elements[["U+2596"]], mode = "alpha")
    bml[["U+25E0"]] <- bm_mask(white_circle, block_elements[["U+2580"]], mode = "alpha")
    bml[["U+25E1"]] <- bm_mask(white_circle, block_elements[["U+2584"]], mode = "alpha")

    bml[["U+25F4"]] <- bm_overlay(white_circle,
                                  bm_outline(bm_mask(block_elements[["U+2598"]], black_circle, mode = "alpha")))
    bml[["U+25F5"]] <- bm_overlay(white_circle,
                                  bm_outline(bm_mask(block_elements[["U+2596"]], black_circle, mode = "alpha")))
    bml[["U+25F6"]] <- bm_overlay(white_circle,
                                  bm_outline(bm_mask(block_elements[["U+2597"]], black_circle, mode = "alpha")))
    bml[["U+25F7"]] <- bm_overlay(white_circle,
                                  bm_outline(bm_mask(block_elements[["U+259D"]], black_circle, mode = "alpha")))

    white_bullet <- empty
    white_bullet[c(7, 10), 8:9] <- 1L
    white_bullet[8:9, c(7, 10)] <- 1L
    bml[["U+25E6"]] <- white_bullet

    bml[["U+25EF"]] <- white_circle

    bml[["U+25E9"]] <- bm_overlay(white_square, bml[["U+25E4"]])
    bml[["U+25EA"]] <- bm_overlay(white_square, bml[["U+25E2"]])

    bml[["U+25D8"]] <- bm_mask(black_square,
                               bm_mask(medium_black_circle, medium_white_circle))
    bml[["U+25D9"]] <- bm_mask(black_square,
                               bm_mask(black_circle, white_circle) |> bm_outline())
    bml[["U+25DA"]] <- bm_mask(bml[["U+25D9"]], block_elements[["U+2580"]], mode = "alpha")
    bml[["U+25DB"]] <- bm_mask(bml[["U+25D9"]], block_elements[["U+2580"]])

    bml
}
