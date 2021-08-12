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
    bml[["U+2500"]][8:9, ] <- 1L
    bml[["U+2501"]][7:10, ] <- 1L
    bml[["U+2502"]][, 8:9] <- 1L
    bml[["U+2503"]][, 7:10] <- 1L

    # Half
    bml[["U+2574"]][8:9, 1:8] <- 1L
    bml[["U+2575"]][9:16, 8:9] <- 1L
    bml[["U+2576"]][8:9, 9:16] <- 1L
    bml[["U+2577"]][1:8, 8:9] <- 1L
    bml[["U+2578"]][7:10, 1:8] <- 1L
    bml[["U+2579"]][9:16, 7:10] <- 1L
    bml[["U+257A"]][7:10, 9:16] <- 1L
    bml[["U+257B"]][1:8, 7:10] <- 1L

    # Mixed halves
    bml[["U+257C"]] <- bm_overlay(bml[["U+2574"]], bml[["U+257A"]])
    bml[["U+257D"]] <- bm_overlay(bml[["U+2575"]], bml[["U+257B"]])
    bml[["U+257E"]] <- bm_overlay(bml[["U+2576"]], bml[["U+2578"]])
    bml[["U+257F"]] <- bm_overlay(bml[["U+2577"]], bml[["U+2579"]])

    # Corners
    bml[["U+250C"]] <- bm_overlay(bml[["U+2576"]], bml[["U+2577"]]) |> bm_overlay(bm_22)
    bml[["U+250D"]] <- bm_overlay(bml[["U+257A"]], bml[["U+2577"]]) |> bm_overlay(bm_24)
    bml[["U+250E"]] <- bm_overlay(bml[["U+2576"]], bml[["U+257B"]]) |> bm_overlay(bm_42)
    bml[["U+250F"]] <- bm_overlay(bml[["U+257A"]], bml[["U+257B"]]) |> bm_overlay(bm_44)

    bml[["U+2510"]] <- bm_overlay(bml[["U+2577"]], bml[["U+2574"]]) |> bm_overlay(bm_22)
    bml[["U+2511"]] <- bm_overlay(bml[["U+2577"]], bml[["U+2578"]]) |> bm_overlay(bm_24)
    bml[["U+2512"]] <- bm_overlay(bml[["U+257B"]], bml[["U+2574"]]) |> bm_overlay(bm_42)
    bml[["U+2513"]] <- bm_overlay(bml[["U+257B"]], bml[["U+2578"]]) |> bm_overlay(bm_44)

    bml[["U+2514"]] <- bm_overlay(bml[["U+2575"]], bml[["U+2576"]]) |> bm_overlay(bm_22)
    bml[["U+2515"]] <- bm_overlay(bml[["U+2575"]], bml[["U+257A"]]) |> bm_overlay(bm_24)
    bml[["U+2516"]] <- bm_overlay(bml[["U+2579"]], bml[["U+2576"]]) |> bm_overlay(bm_42)
    bml[["U+2517"]] <- bm_overlay(bml[["U+2579"]], bml[["U+257A"]]) |> bm_overlay(bm_44)

    bml[["U+2518"]] <- bm_overlay(bml[["U+2575"]], bml[["U+2574"]]) |> bm_overlay(bm_22)
    bml[["U+2519"]] <- bm_overlay(bml[["U+2575"]], bml[["U+2578"]]) |> bm_overlay(bm_24)
    bml[["U+251A"]] <- bm_overlay(bml[["U+2579"]], bml[["U+2574"]]) |> bm_overlay(bm_42)
    bml[["U+251B"]] <- bm_overlay(bml[["U+2579"]], bml[["U+2578"]]) |> bm_overlay(bm_44)

    # Three-way
    bml[["U+251C"]] <- bm_overlay(bml[["U+2502"]], bml[["U+2576"]])
    bml[["U+251D"]] <- bm_overlay(bml[["U+2502"]], bml[["U+257A"]])

    bml[["U+251E"]] <- bm_overlay(bml[["U+250C"]], bml[["U+2579"]]) |> bm_overlay(bm_42)
    bml[["U+251F"]] <- bm_overlay(bml[["U+2514"]], bml[["U+257B"]]) |> bm_overlay(bm_42)

    bml[["U+2520"]] <- bm_overlay(bml[["U+2503"]], bml[["U+2576"]])
    bml[["U+2521"]] <- bm_overlay(bml[["U+2517"]], bml[["U+2577"]])
    bml[["U+2522"]] <- bm_overlay(bml[["U+250F"]], bml[["U+2575"]])
    bml[["U+2523"]] <- bm_overlay(bml[["U+2503"]], bml[["U+257A"]])

    bml[["U+2524"]] <- bm_overlay(bml[["U+2502"]], bml[["U+2574"]])
    bml[["U+2525"]] <- bm_overlay(bml[["U+2502"]], bml[["U+2578"]])
    bml[["U+2526"]] <- bm_overlay(bml[["U+251A"]], bml[["U+2577"]])
    bml[["U+2527"]] <- bm_overlay(bml[["U+2518"]], bml[["U+257B"]])

    bml[["U+2528"]] <- bm_overlay(bml[["U+2503"]], bml[["U+2574"]])
    bml[["U+2529"]] <- bm_overlay(bml[["U+251B"]], bml[["U+2577"]])
    bml[["U+252A"]] <- bm_overlay(bml[["U+2513"]], bml[["U+2575"]])
    bml[["U+252B"]] <- bm_overlay(bml[["U+2503"]], bml[["U+2578"]])

    bml[["U+252C"]] <- bm_overlay(bml[["U+2500"]], bml[["U+2577"]])
    bml[["U+252D"]] <- bm_overlay(bml[["U+257E"]], bml[["U+2577"]]) |> bm_overlay(bm_24)
    bml[["U+252E"]] <- bm_overlay(bml[["U+257C"]], bml[["U+2577"]]) |> bm_overlay(bm_24)
    bml[["U+252F"]] <- bm_overlay(bml[["U+2501"]], bml[["U+2577"]])

    bml[["U+2530"]] <- bm_overlay(bml[["U+2500"]], bml[["U+257B"]])
    bml[["U+2531"]] <- bm_overlay(bml[["U+257E"]], bml[["U+257B"]]) |> bm_overlay(bm_44)
    bml[["U+2532"]] <- bm_overlay(bml[["U+257C"]], bml[["U+257B"]]) |> bm_overlay(bm_44)
    bml[["U+2533"]] <- bm_overlay(bml[["U+2501"]], bml[["U+257B"]])

    bml[["U+2534"]] <- bm_overlay(bml[["U+2500"]], bml[["U+2575"]])
    bml[["U+2535"]] <- bm_overlay(bml[["U+257E"]], bml[["U+2575"]]) |> bm_overlay(bm_24)
    bml[["U+2536"]] <- bm_overlay(bml[["U+257C"]], bml[["U+2575"]]) |> bm_overlay(bm_24)
    bml[["U+2537"]] <- bm_overlay(bml[["U+2501"]], bml[["U+2575"]])

    bml[["U+2538"]] <- bm_overlay(bml[["U+2500"]], bml[["U+2579"]])
    bml[["U+2539"]] <- bm_overlay(bml[["U+257E"]], bml[["U+2579"]]) |> bm_overlay(bm_44)
    bml[["U+253A"]] <- bm_overlay(bml[["U+257C"]], bml[["U+2579"]]) |> bm_overlay(bm_44)
    bml[["U+253B"]] <- bm_overlay(bml[["U+2501"]], bml[["U+2579"]])

    # Four-way
    bml[["U+253C"]] <- bm_overlay(bml[["U+2500"]], bml[["U+2502"]])
    bml[["U+253D"]] <- bm_overlay(bml[["U+257E"]], bml[["U+2502"]])
    bml[["U+253E"]] <- bm_overlay(bml[["U+257C"]], bml[["U+2502"]])
    bml[["U+253F"]] <- bm_overlay(bml[["U+2501"]], bml[["U+2502"]])

    bml[["U+2540"]] <- bm_overlay(bml[["U+257F"]], bml[["U+2500"]])
    bml[["U+2541"]] <- bm_overlay(bml[["U+257D"]], bml[["U+2500"]])
    bml[["U+2542"]] <- bm_overlay(bml[["U+2503"]], bml[["U+2500"]])

    bml[["U+2543"]] <- bm_overlay(bml[["U+251B"]], bml[["U+250C"]])
    bml[["U+2544"]] <- bm_overlay(bml[["U+2517"]], bml[["U+2510"]])
    bml[["U+2545"]] <- bm_overlay(bml[["U+2513"]], bml[["U+2514"]])
    bml[["U+2546"]] <- bm_overlay(bml[["U+2518"]], bml[["U+250F"]])
    bml[["U+2547"]] <- bm_overlay(bml[["U+251B"]], bml[["U+250D"]])
    bml[["U+2548"]] <- bm_overlay(bml[["U+2513"]], bml[["U+2515"]])
    bml[["U+2549"]] <- bm_overlay(bml[["U+2513"]], bml[["U+2516"]])
    bml[["U+254A"]] <- bm_overlay(bml[["U+2512"]], bml[["U+2517"]])

    bml[["U+254B"]] <- bm_overlay(bml[["U+2501"]], bml[["U+2503"]])

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

    bml[["U+2552"]] <- bm_overlay(double_right, bml[["U+2577"]]) |> bm_overlay(bm_26)
    bml[["U+2553"]] <- bm_overlay(double_bottom, bml[["U+2576"]]) |> bm_overlay(bm_62)
    bml[["U+2554"]] <- bm_overlay(double_right, double_bottom) |>
                            bm_overlay(bm_66) |> bm_mask(right_mask) |> bm_mask(bottom_mask)
    bml[["U+2555"]] <- bm_overlay(double_left, bml[["U+2577"]]) |> bm_overlay(bm_26)
    bml[["U+2556"]] <- bm_overlay(double_bottom, bml[["U+2574"]]) |> bm_overlay(bm_62)
    bml[["U+2557"]] <- bm_overlay(double_left, double_bottom) |>
                            bm_overlay(bm_66) |> bm_mask(left_mask) |> bm_mask(bottom_mask)
    bml[["U+2558"]] <- bm_overlay(double_right, bml[["U+2575"]]) |> bm_overlay(bm_26)
    bml[["U+2559"]] <- bm_overlay(double_top, bml[["U+2576"]]) |> bm_overlay(bm_62)
    bml[["U+255A"]] <- bm_overlay(double_right, double_top) |>
                            bm_overlay(bm_66) |> bm_mask(right_mask) |> bm_mask(top_mask)
    bml[["U+255B"]] <- bm_overlay(double_left, bml[["U+2575"]]) |> bm_overlay(bm_26)
    bml[["U+255C"]] <- bm_overlay(double_top, bml[["U+2574"]]) |> bm_overlay(bm_62)
    bml[["U+255D"]] <- bm_overlay(double_left, double_top) |>
                            bm_overlay(bm_66) |> bm_mask(left_mask) |> bm_mask(top_mask)
    bml[["U+255E"]] <- bm_overlay(double_right, bml[["U+2502"]])
    bml[["U+255F"]] <- bm_overlay(bml[["U+2551"]], bml[["U+2576"]]) |> bm_mask(top_mask)
    bml[["U+2560"]] <- bm_overlay(bml[["U+2551"]], double_right) |>
                            bm_mask(vertical_mask) |> bm_mask(right_mask)
    bml[["U+2561"]] <- bm_overlay(double_left, bml[["U+2502"]])
    bml[["U+2562"]] <- bm_overlay(bml[["U+2551"]], bml[["U+2574"]]) |> bm_mask(top_mask)
    bml[["U+2563"]] <- bm_overlay(bml[["U+2551"]], double_left) |>
                            bm_mask(vertical_mask) |> bm_mask(left_mask)
    bml[["U+2564"]] <- bm_overlay(bml[["U+2550"]], bml[["U+2577"]]) |> bm_mask(left_mask)
    bml[["U+2565"]] <- bm_overlay(double_bottom, bml[["U+2500"]])
    bml[["U+2566"]] <- bm_overlay(bml[["U+2550"]], double_bottom) |>
                            bm_mask(bottom_mask) |> bm_mask(horizontal_mask)
    bml[["U+2567"]] <- bm_overlay(bml[["U+2550"]], bml[["U+2575"]]) |> bm_mask(left_mask)
    bml[["U+2568"]] <- bm_overlay(double_top, bml[["U+2500"]])
    bml[["U+2569"]] <- bm_overlay(bml[["U+2550"]], double_top) |>
                            bm_mask(top_mask) |> bm_mask(horizontal_mask)
    bml[["U+256A"]] <- bm_overlay(bml[["U+2550"]], bml[["U+2502"]])
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
