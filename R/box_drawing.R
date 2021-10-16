# thin lines will be middle two
# thick lines will be middle four
# double lines will be middle six with middle two blank
create_box_drawing <- function() {

    empty <- bm_bitmap(matrix(0L, ncol = 16L, nrow = 16L))
    bm_66 <- bm_26 <- bm_62 <- bm_44 <- bm_42 <- bm_24 <- bm_22 <- empty
    bm_22[8:9, 8:9] <- 1L
    bm_24[7:10, 8:9] <- 1L
    bm_26[6:11, 8:9] <- 1L
    bm_42[8:9, 7:10] <- 1L
    bm_44[7:10, 7:10] <- 1L
    bm_62[8:9, 6:11] <- 1L
    bm_66[6:11, 6:11] <- 1L

    ucp <- block2ucp("Box Drawing")
    bml <- lapply(ucp, function(x) empty)
    names(bml) <- ucp
    bml <- as_bm_list(bml)

    # Lines
    lh <- empty
    lh[8:9, ] <- 1L
    hh <- empty
    hh[7:10, ] <- 1L

    bml[["U+2500"]] <- lh
    bml[["U+2501"]] <- hh
    bml[["U+2502"]] <- lv <- bm_rotate(lh, 90)
    bml[["U+2503"]] <- hv <- bm_rotate(hh, 90)

    # Half
    hl <- ll <- empty
    ll[8:9, 1:8] <- 1L
    bml[["U+2574"]] <- ll
    bml[["U+2575"]] <- lu <- bm_rotate(ll, 90)
    bml[["U+2576"]] <- lr <- bm_rotate(lu, 90)
    bml[["U+2577"]] <- ld <- bm_rotate(lr, 90)
    hl[7:10, 1:8] <- 1L
    bml[["U+2578"]] <- hl
    bml[["U+2579"]] <- hu <- bm_rotate(hl, 90)
    bml[["U+257A"]] <- hr <- bm_rotate(hu, 90)
    bml[["U+257B"]] <- hd <- bm_rotate(hr, 90)

    # Mixed halves
    bml[["U+257C"]] <- bm_overlay(ll, hr)
    bml[["U+257D"]] <- bm_overlay(lu, hd)
    bml[["U+257E"]] <- bm_overlay(lr, hl)
    bml[["U+257F"]] <- bm_overlay(ld, hu)

    # Corners
    bml[["U+250C"]] <- Reduce(bm_overlay, list(ld, lr, bm_22))
    bml[["U+250D"]] <- Reduce(bm_overlay, list(ld, hr, bm_24))
    bml[["U+250E"]] <- Reduce(bm_overlay, list(hd, lr, bm_42))
    bml[["U+250F"]] <- Reduce(bm_overlay, list(hd, hr, bm_44))

    bml[["U+2510"]] <- bm_flip(bml[["U+250C"]], "h")
    bml[["U+2511"]] <- bm_flip(bml[["U+250D"]], "h")
    bml[["U+2512"]] <- bm_flip(bml[["U+250E"]], "h")
    bml[["U+2513"]] <- bm_flip(bml[["U+250F"]], "h")

    bml[["U+2514"]] <- bm_flip(bml[["U+250C"]], "v")
    bml[["U+2515"]] <- bm_flip(bml[["U+250D"]], "v")
    bml[["U+2516"]] <- bm_flip(bml[["U+250E"]], "v")
    bml[["U+2517"]] <- bm_flip(bml[["U+250F"]], "v")

    bml[["U+2518"]] <- bm_flip(bml[["U+250C"]], "b")
    bml[["U+2519"]] <- bm_flip(bml[["U+250D"]], "b")
    bml[["U+251A"]] <- bm_flip(bml[["U+250E"]], "b")
    bml[["U+251B"]] <- bm_flip(bml[["U+250F"]], "b")

    # Three-way
    bml[["U+251C"]] <- bm_overlay(lv, lr)
    bml[["U+251D"]] <- bm_overlay(lv, hr)
    bd251e <- bm_overlay(hv, lr)
    bd251e[1:7, c(7, 10)] <- 0L
    bml[["U+251E"]] <- bd251e
    bml[["U+251F"]] <- bm_flip(bd251e, "v")
    bml[["U+2520"]] <- bm_overlay(hv, lr)
    bml[["U+2521"]] <- bd2521 <- bm_overlay(bml[["U+2517"]], ld)
    bml[["U+2522"]] <- bm_flip(bd2521, "v")
    bml[["U+2523"]] <- bm_overlay(hv, hr)

    bml[["U+2524"]] <- bm_flip(bml[["U+251C"]], "h")
    bml[["U+2525"]] <- bm_flip(bml[["U+251D"]], "h")
    bml[["U+2526"]] <- bm_flip(bml[["U+251E"]], "h")
    bml[["U+2527"]] <- bm_flip(bml[["U+251F"]], "h")
    bml[["U+2528"]] <- bm_flip(bml[["U+2520"]], "h")
    bml[["U+2529"]] <- bm_flip(bml[["U+2521"]], "h")
    bml[["U+252A"]] <- bm_flip(bml[["U+2522"]], "h")
    bml[["U+252B"]] <- bm_flip(bml[["U+2523"]], "h")

    bml[["U+252C"]] <- bm_overlay(bml[["U+2500"]], ld)
    bml[["U+252D"]] <- bm_rotate(bd251e, 90) |> bm_flip("h")
    bml[["U+252E"]] <- bm_flip(bml[["U+252D"]], "h")
    bml[["U+252F"]] <- bm_overlay(bml[["U+2501"]], ld)
    bml[["U+2530"]] <- bm_overlay(bml[["U+2500"]], hd)
    bml[["U+2531"]] <- Reduce(bm_overlay, list(bml[["U+257E"]], hd, bm_44))
    bml[["U+2532"]] <- Reduce(bm_overlay, list(bml[["U+257C"]], hd, bm_44))
    bml[["U+2533"]] <- bm_overlay(bml[["U+2501"]], hd)

    bml[["U+2534"]] <- bm_flip(bml[["U+252C"]], "v")
    bml[["U+2535"]] <- bm_flip(bml[["U+252D"]], "v")
    bml[["U+2536"]] <- bm_flip(bml[["U+252E"]], "v")
    bml[["U+2537"]] <- bm_flip(bml[["U+252F"]], "v")
    bml[["U+2538"]] <- bm_flip(bml[["U+2530"]], "v")
    bml[["U+2539"]] <- bm_flip(bml[["U+2531"]], "v")
    bml[["U+253A"]] <- bm_flip(bml[["U+2532"]], "v")
    bml[["U+253B"]] <- bm_flip(bml[["U+2533"]], "v")

    # Four-way
    bml[["U+253C"]] <- bm_overlay(bml[["U+2500"]], lv)
    bml[["U+253D"]] <- bm_overlay(bml[["U+257E"]], lv)
    bml[["U+253E"]] <- bm_overlay(bml[["U+257C"]], lv)
    bml[["U+253F"]] <- bm_overlay(bml[["U+2501"]], lv)

    bml[["U+2540"]] <- bm_overlay(bml[["U+257F"]], bml[["U+2500"]])
    bml[["U+2541"]] <- bm_overlay(bml[["U+257D"]], bml[["U+2500"]])
    bml[["U+2542"]] <- bm_overlay(hv, bml[["U+2500"]])

    bml[["U+2543"]] <- bm_overlay(bml[["U+251B"]], bml[["U+250C"]])
    bml[["U+2544"]] <- bm_overlay(bml[["U+2517"]], bml[["U+2510"]])
    bml[["U+2545"]] <- bm_overlay(bml[["U+2513"]], bml[["U+2514"]])
    bml[["U+2546"]] <- bm_overlay(bml[["U+2518"]], bml[["U+250F"]])
    bml[["U+2547"]] <- bm_overlay(bml[["U+251B"]], bml[["U+250D"]])
    bml[["U+2548"]] <- bm_overlay(bml[["U+2513"]], bml[["U+2515"]])
    bml[["U+2549"]] <- bm_overlay(bml[["U+2513"]], bml[["U+2516"]])
    bml[["U+254A"]] <- bm_overlay(bml[["U+2512"]], bml[["U+2517"]])

    bml[["U+254B"]] <- bm_overlay(bml[["U+2501"]], hv)

    # Triple Dashes
    bml[["U+2504"]][7:8, c(2:4, 7:10, 13:15)] <- 1L
    bml[["U+2505"]][6:9, c(2:4, 7:10, 13:15)] <- 1L
    bml[["U+2506"]][c(2:4, 7:10, 13:15), 7:8] <- 1L
    bml[["U+2507"]][c(2:4, 7:10, 13:15), 6:9] <- 1L

    # Quadruple Dashes
    bml[["U+2508"]][7:8, c(2:3, 6:7, 10:11, 14:15)] <- 1L
    bml[["U+2509"]][6:9, c(2:3, 6:7, 10:11, 14:15)] <- 1L
    bml[["U+250A"]][c(2:3, 6:7, 10:11, 14:15), 7:8] <- 1L
    bml[["U+250B"]][c(2:3, 6:7, 10:11, 14:15), 6:9] <- 1L

    # Double Dashes
    bml[["U+254C"]][7:8, c(2:7, 10:15)] <- 1L
    bml[["U+254D"]][6:9, c(2:7, 10:15)] <- 1L
    bml[["U+254E"]][c(2:7, 10:15), 7:8] <- 1L
    bml[["U+254F"]][c(2:7, 10:15), 6:9] <- 1L

    bml[["U+2550"]][c(6:7, 10:11), ] <- 1L
    bml[["U+2551"]][, c(6:7, 10:11)] <- 1L

    # Doubles
    double_right <- bml[["U+2550"]]
    double_right[, 1:8] <- 0L

    double_left <- bml[["U+2550"]]
    double_left[, 9:16] <- 0L

    double_top <- bml[["U+2551"]]
    double_top[1:8, ] <- 0L

    double_bottom <- bml[["U+2551"]]
    double_bottom[9:16, ] <- 0L

    right_mask <- left_mask <- top_mask <- bottom_mask <- empty
    right_mask[8:9, 8:16] <- 1L
    left_mask[8:9, 1:9] <- 1L
    top_mask[8:16, 8:9] <- 1L
    bottom_mask[1:9, 8:9] <- 1L
    vertical_mask <- bm_overlay(top_mask, bottom_mask)
    horizontal_mask <- bm_overlay(left_mask, right_mask)

    bml[["U+2552"]] <- bm_overlay(double_right, ld) |> bm_overlay(bm_26)
    bml[["U+2553"]] <- bm_overlay(double_bottom, lr) |> bm_overlay(bm_62)
    bml[["U+2554"]] <- bm_overlay(double_right, double_bottom) |>
                            bm_overlay(bm_66) |> bm_mask(right_mask) |> bm_mask(bottom_mask)
    bml[["U+2555"]] <- bm_overlay(double_left, ld) |> bm_overlay(bm_26)
    bml[["U+2556"]] <- bm_overlay(double_bottom, ll) |> bm_overlay(bm_62)
    bml[["U+2557"]] <- bm_overlay(double_left, double_bottom) |>
                            bm_overlay(bm_66) |> bm_mask(left_mask) |> bm_mask(bottom_mask)
    bml[["U+2558"]] <- bm_overlay(double_right, lu) |> bm_overlay(bm_26)
    bml[["U+2559"]] <- bm_overlay(double_top, lr) |> bm_overlay(bm_62)
    bml[["U+255A"]] <- bm_overlay(double_right, double_top) |>
                            bm_overlay(bm_66) |> bm_mask(right_mask) |> bm_mask(top_mask)
    bml[["U+255B"]] <- bm_overlay(double_left, lu) |> bm_overlay(bm_26)
    bml[["U+255C"]] <- bm_overlay(double_top, ll) |> bm_overlay(bm_62)
    bml[["U+255D"]] <- bm_overlay(double_left, double_top) |>
                            bm_overlay(bm_66) |> bm_mask(left_mask) |> bm_mask(top_mask)
    bml[["U+255E"]] <- bm_overlay(double_right, lv)
    bml[["U+255F"]] <- bm_overlay(bml[["U+2551"]], lr) |> bm_mask(top_mask)
    bml[["U+2560"]] <- bm_overlay(bml[["U+2551"]], double_right) |>
                            bm_mask(vertical_mask) |> bm_mask(right_mask)
    bml[["U+2561"]] <- bm_overlay(double_left, lv)
    bml[["U+2562"]] <- bm_overlay(bml[["U+2551"]], ll) |> bm_mask(top_mask)
    bml[["U+2563"]] <- bm_overlay(bml[["U+2551"]], double_left) |>
                            bm_mask(vertical_mask) |> bm_mask(left_mask)
    bml[["U+2564"]] <- bm_overlay(bml[["U+2550"]], ld) |> bm_mask(left_mask)
    bml[["U+2565"]] <- bm_overlay(double_bottom, bml[["U+2500"]])
    bml[["U+2566"]] <- bm_overlay(bml[["U+2550"]], double_bottom) |>
                            bm_mask(bottom_mask) |> bm_mask(horizontal_mask)
    bml[["U+2567"]] <- bm_overlay(bml[["U+2550"]], lu) |> bm_mask(left_mask)
    bml[["U+2568"]] <- bm_overlay(double_top, bml[["U+2500"]])
    bml[["U+2569"]] <- bm_overlay(bml[["U+2550"]], double_top) |>
                            bm_mask(top_mask) |> bm_mask(horizontal_mask)
    bml[["U+256A"]] <- bm_overlay(bml[["U+2550"]], lv)
    bml[["U+256B"]] <- bm_overlay(bml[["U+2551"]], bml[["U+2500"]])
    bml[["U+256C"]] <- bm_overlay(bml[["U+2550"]], bml[["U+2551"]]) |>
                            bm_mask(vertical_mask) |> bm_mask(horizontal_mask)

    # Four curved corners
    gp <- gpar(fill = NA, col = "black", lwd = 2)
    r <- unit(0.2, "snpc")
    bml[["U+256D"]] <- as_bm_bitmap(roundrectGrob(x=1, y=0, r=r, gp=gp), width=16, height=16)
    bml[["U+256E"]] <- as_bm_bitmap(roundrectGrob(x=0, y=0, r=r, gp=gp), width=16, height=16)
    bml[["U+256F"]] <- as_bm_bitmap(roundrectGrob(x=0, y=1, r=r, gp=gp), width=16, height=16)
    bml[["U+2570"]] <- as_bm_bitmap(roundrectGrob(x=1, y=1, r=r, gp=gp), width=16, height=16)

    # Diagonals
    bml[["U+2571"]] <- bm_bitmap(diag(16))
    bml[["U+2571"]] <- bm_overlay(bml[["U+2571"]], bm_shift(bml[["U+2571"]], top = 1L))
    bml[["U+2571"]] <- bm_overlay(bml[["U+2571"]], bm_shift(bml[["U+2571"]], bottom = 1L))
    bml[["U+2572"]] <- bm_flip(bml[["U+2571"]], "horizontal")
    bml[["U+2573"]] <- bm_overlay(bml[["U+2571"]], bml[["U+2572"]])

    bml
}
