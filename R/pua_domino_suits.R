create_pua_domino_suits <- function() {
    empty <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))
    dot_c <- empty
    dot_c[8:9, 7:10] <- 1L
    dot_c[7:10, 8:9] <- 1L

    dot_l <- bm_shift(dot_c, left = 6L)
    dot_r <- bm_shift(dot_c, right = 6L)
    dot_t <- bm_shift(dot_c, top = 6L)
    dot_b <- bm_shift(dot_c, bottom = 6L)

    dot_tl <- bm_shift(dot_t, left = 6L)
    dot_tr <- bm_shift(dot_t, right = 6L)
    dot_bl <- bm_shift(dot_b, left = 6L)
    dot_br <- bm_shift(dot_b, right = 6L)

    bml <- bm_list()
    bml[["U+FCA00"]] <- zero <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))
    bml[["U+FCA01"]] <- one <- dot_c
    bml[["U+FCA02"]] <- two <- bm_overlay(dot_bl, dot_tr)
    bml[["U+FCA03"]] <- three <- bm_overlay(two, dot_c)
    bml[["U+FCA04"]] <- four <- two |> bm_overlay(dot_tl) |> bm_overlay(dot_br)
    bml[["U+FCA05"]] <- five <- bm_overlay(four, dot_c)
    bml[["U+FCA06"]] <- six <- four |> bm_overlay(dot_l) |> bm_overlay(dot_r)
    bml[["U+FCA07"]] <- seven <- bm_overlay(six, dot_c)
    bml[["U+FCA08"]] <- eight <- six |> bm_overlay(dot_t) |> bm_overlay(dot_b)
    bml[["U+FCA09"]] <- nine <- bm_overlay(eight, dot_c)

    left_four <- empty
    left_four[c(2:3, 6:7, 10:11, 14:15), c(2:3)] <- 1L

    ten <- bm_overlay(left_four, bm_flip(left_four, "h"))
    ten[c(2:3, 14:15), c(8:9)] <- 1L

    eleven <- ten
    eleven[8:9, 8:9] <- 1L

    twelve <- Reduce(bm_overlay, list(left_four,
                                      bm_flip(left_four, "h"),
                                      bm_shift(left_four, right = 6L)))

    bottom_four <- bm_rotate(left_four, 270)
    bottom_twelve <- Reduce(bm_overlay, list(bottom_four,
                                             bm_shift(bottom_four, top = 4L),
                                             bm_shift(bottom_four, top = 8L)))
    thirteen <- fourteen <- bottom_twelve
    thirteen[14:15, 8:9] <- 1L
    fourteen[14:15, c(4:5, 12:13)] <- 1L
    fifteen <- bm_overlay(thirteen, fourteen)

    sixteen <- bm_overlay(bottom_twelve, bm_shift(bottom_four, top = 12L))

    sixteen_split <- Reduce(bm_overlay, list(left_four,
                                             bm_shift(left_four, right = 3L),
                                             bm_shift(left_four, right = 9L),
                                             bm_shift(left_four, right = 12L)))
    seventeen <- eighteen <- sixteen_split
    seventeen[8:9, 8:9] <- 1L
    eighteen[c(4:5, 12:13), 8:9] <- 1L

    bml[["U+FCA0A"]] <- ten
    bml[["U+FCA0B"]] <- eleven
    bml[["U+FCA0C"]] <- twelve
    bml[["U+FCA0D"]] <- thirteen
    bml[["U+FCA0E"]] <- fourteen
    bml[["U+FCA0F"]] <- fifteen
    bml[["U+FCA10"]] <- sixteen
    bml[["U+FCA11"]] <- seventeen
    bml[["U+FCA12"]] <- eighteen

    top <- names(bml)
    right <- range2ucp("U+FCA13..U+FCA25", omit_unnamed = FALSE)
    bottom <- range2ucp("U+FCA26..U+FCA38", omit_unnamed = FALSE)
    left <- range2ucp("U+FCA39..U+FCA4B", omit_unnamed = FALSE)
    for (i in seq_along(top)) {
        bml[[right[i]]] <- bm_rotate(bml[[top[i]]], 90)
        bml[[bottom[i]]] <- bm_rotate(bml[[top[i]]], 180)
        bml[[left[i]]] <- bm_rotate(bml[[top[i]]], 270)
    }
    ucp_normal <- range2ucp("U+FCA00..U+FCA4B", omit_unnamed = FALSE)
    ucp_inverted <- range2ucp("U+FCA4C..U+FCA97", omit_unnamed = FALSE)
    black <- bm_bitmap(matrix(1L, nrow = 16L, ncol = 16L))
    for (i in seq_along(ucp_normal)) {
        bml[[ucp_inverted[i]]] <- bm_mask(black, bml[[ucp_normal[i]]])
    }

    bml
}
