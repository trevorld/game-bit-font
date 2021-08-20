create_pua_domino_suits <- function() {
    dot_c <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))
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

    top <- names(bml)
    right <- range2ucp("U+FCA10..U+FCA19", omit_unnamed = FALSE)
    bottom <- range2ucp("U+FCA20..U+FCA29", omit_unnamed = FALSE)
    left <- range2ucp("U+FCA30..U+FCA39", omit_unnamed = FALSE)
    for (i in seq_along(top)) {
        bml[[right[i]]] <- bm_rotate(bml[[top[i]]], 90)
        bml[[bottom[i]]] <- bm_rotate(bml[[top[i]]], 180)
        bml[[left[i]]] <- bm_rotate(bml[[top[i]]], 270)
    }

    bml
}
