add_suits <- function(bml, suit, start) {
    u_char <- Unicode::as.u_char(start)
    bml[[hex2ucp(u_char + 0)]] <- suit
    bml[[hex2ucp(u_char + 4)]] <- bm_rotate(suit, angle=90)
    bml[[hex2ucp(u_char + 8)]] <- bm_rotate(suit, angle=180)
    bml[[hex2ucp(u_char + 12)]] <- bm_rotate(suit, angle=270)
    bml
}

create_pua_piecepack <- function(unifont, fixed_5x8) {

    withr::local_options(bracer.engine = "R")

    bml <- bm_list()

    empty <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))

    square <- bm_bitmap(matrix(1L, nrow = 16L, ncol = 16L))
    circle <- as_bm_bitmap(circleGrob(r=0.5), height = 16L, width = 16L)
    pawn <- !square
    pawn[1, ] <- 1L
    pawn[c(1:10, 13:14), c(1:16)] <- 1L
    pawn[10L, c(1:16)] <- 1L
    pawn[11L, c(3:14)] <- 1L
    pawn[12L, c(2:15)] <- 1L
    pawn[15, c(2:15)] <- 1L
    pawn[16L, 4:13] <- 1L

    enclosing_pawn <- pawn_w <- bm_outline(pawn)
    pawn_w[10, c(3, 14)] <- 1L

    pawn_1 <- bm_mask(pawn, pawn_w)
    pawn_1_w <- bm_outline(pawn_1)

    circle_1 <- bm_mask(circle, bm_outline(circle))
    circle_2 <- bm_mask(circle_1, bm_outline(circle_1))
    circle_3 <- bm_mask(circle_2, bm_outline(circle_2))
    circle_4 <- bm_mask(circle_3, bm_outline(circle_3))

    square_1 <- bm_mask(square, bm_outline(square))

    # Combining
    #   Enclosing
    bml[["U+FCDD0"]] <- enclosing_tile <- bm_outline(square) # combining enclosing tile
    bml[["U+FCDD1"]] <- enclosing_coin <- bm_outline(circle) # combining enclosing coin
    bml[["U+FCDD2"]] <- enclosing_die <- bm_outline(square) # combining enclosing die
    enclosing_saucer <- bm_overlay(bm_outline(circle), bm_outline(circle_2))
    bml[["U+FCDD3"]] <- enclosing_saucer
    bml[["U+FCDD4"]] <- circle_background <- bm_mask(!empty, circle)

    bml[["U+FCDD8"]] <- enclosing_tile_small <- bm_outline(square) # combining enclosing small tile
    bml[["U+FCDD9"]] <- enclosing_coin_small <- bm_outline(circle_1) # combining enclosing small coin
    bml[["U+FCDDA"]] <- bm_outline(square_1) # combining enclosing small die
    enclosing_saucer_small <- bm_overlay(bm_outline(circle_1), bm_outline(circle_3))
    bml[["U+FCDDB"]] <- enclosing_saucer_small
    #### combining inverted coin small background

    bml <- add_suits(bml, pawn_w,  "U+FCDE0")
    bml <- add_suits(bml, pawn_1_w,  "U+FCDE1")
    pawn_background <- bm_mask(!empty, pawn)
    bml <- add_suits(bml, pawn_background, "U+FCDE2")
    #### combining inverted pawn small background

    #   DM
    dm <- empty
    dm[13:14, 8:9] <- 1L

    bdl <- empty
    bdl[16, 8:9] <- 1L

    bdh <- empty
    bdh[16, 7:10] <- 1L

    bml <- add_suits(bml, dm, "U+FCD20")

    bml <- add_suits(bml, bdl, "U+FCD21")
    bml <- add_suits(bml, bdh, "U+FCD22")
    #### inverted square, inverted box drawing?

    # Suits/Ranks
    gridlines <- empty
    gridlines[3:14, 8:9] <- 1L
    gridlines[8:9, 3:14] <- 1L
    bml[["U+FCD00"]] <- gridlines

    # 9 x Suits
    # 3. Black Piecepack
    # 4. White Piecepack
    sun_black <- as_bm_bitmap(circleGrob(), width=6, height=6) |>
            bm_extend(width=16, height=16)

    sun_white <- bm_outline(sun_black)
    # sun_white[8:9, 8:9] <- 1L

    sun_black_small <- as_bm_bitmap(circleGrob(), width=4, height=4) |>
            bm_extend(width=16, height=16) |>
            bm_shift(left = 4, top = 4)

    sun_white_small <- bm_outline(sun_black_small)

    moon_black <- sun_black
    moon_black[, 1:8] <- 0L
    moon_black[c(6, 11), 8] <- 1L
    moon_black[c(8, 9), 9] <- 0L

    moon_white <- sun_black
    moon_white[, 1:8] <- 0L
    moon_white[c(6, 11), 8] <- 1L
    moon_white <- bm_outline(moon_white)

    moon_black_small <- sun_black_small
    moon_black_small[12:13, 3:4] <- 0L

    moon_white_small <- sun_black_small
    moon_white_small[12:13, c(3, 5)] <- 0L

    crown_black <- empty
    crown_black[6, 7:10] <- 1L
    crown_black[7, 7:10] <- 1L
    crown_black[8, 6:11] <- 1L
    crown_black[9, 6:11] <- 1L
    crown_black[10, c(6, 8:9, 11)] <- 1L

    crown_black_small <- empty
    crown_black_small[12:14, 3:7] <- 1L
    crown_black_small[14, c(4, 6)] <- 0L

    crown_white <- bm_outline(crown_black)
    crown_white_small <- bm_outline(crown_black_small)

    arm_black <- empty
    arm_black[6:11, 8:9] <- 1L
    arm_black[6, c(7, 10)] <- 1L
    arm_black[9, 6:11] <- 1L
    arm_black[8, c(6, 11)] <- 1L

    arm_white <- bm_outline(arm_black)

    arm_black_small <- empty
    arm_black_small[7:11 + 3, 8 - 3] <- 1L
    # arm_black_small[7 + 3, c(7, 10) - 3] <- 1L
    arm_black_small[10 + 3, 6:10 - 3] <- 1L
    arm_black_small[9 + 3, c(6, 10) - 3] <- 1L

    arm_white_small <- bm_outline(arm_black_small)

    heart_black <- empty
    heart_black[6, 8:9] <- 1L
    heart_black[7, 7:10] <- 1L
    heart_black[8:9, 6:11] <- 1L
    heart_black[10, c(7, 10)] <- 1L

    heart_white <- bm_outline(heart_black)

    heart_black_small <- empty
    heart_black_small[11, 5] <- 1L
    heart_black_small[12, 4:6] <- 1L
    heart_black_small[13, 3:7] <- 1L
    heart_black_small[14, c(4, 6)] <- 1L

    heart_white_small <- bm_outline(heart_black_small)

    spade_black <- bm_flip(heart_black, "both", in_place = TRUE) |> bm_shift(top=1L)
    spade_black[6, 6:11] <- 1L
    spade_black[7, 8:9] <- 1L
    spade_white <- bm_outline(spade_black)
    spade_black_small <- bm_flip(heart_black_small, "both", in_place = TRUE)
    spade_white_small <- bm_flip(heart_white_small, "both", in_place = TRUE)

    club_black <- empty
    club_black[6:11, 8:9] <- 1L
    club_black[c(6, 8:9), 6:11] <- 1L
    club_white <- bm_outline(club_black)
    club_black_small <- empty
    club_black_small[14:11, 4] <- 1L
    club_black_small[c(13, 11), 3:5] <- 1L
    club_white_small <- bm_outline(club_black_small)

    diamond_black <- empty
    diamond_black[6, 8:9] <- 1L
    diamond_black[7, 7:10] <- 1L
    diamond_black[8, 6:11] <- 1L
    diamond_black[9, 7:10] <- 1L
    diamond_black[10, 8:9] <- 1L

    diamond_white <- bm_outline(diamond_black)

    diamond_black_small <- empty
    diamond_black_small[10, 5] <- 1L
    diamond_black_small[11, 4:6] <- 1L
    diamond_black_small[12, 3:7] <- 1L
    diamond_black_small[13, 4:6] <- 1L
    diamond_black_small[14, 5] <- 1L

    diamond_white_small <- bm_outline(diamond_black_small)

    summer <- empty # purple fishie
    summer[c(6, 9), 6] <- 1L
    summer[6:9, c(8:9)] <- 1L
    summer[7:8, c(7, 10)] <- 1L

    winter <- empty # white snowflake
    winter[8, 8:11] <- 1L
    winter[c(7, 9), c(7)] <- 1L
    winter[c(6, 10), c(6)] <- 1L

    fall <- empty # orange leaf
    fall[c(6:7, 9, 11), 8:9] <- 1L
    fall[c(8, 10), c(7, 10)] <- 1L

    spring <- empty # blue flower
    spring[c(6:8, 11), 8:9] <- 1L
    spring[c(9:10), c(7, 10)] <- 1L

    summer_small <- empty # purple fishie
    summer_small[c(12, 14), 3] <- 1L
    summer_small[12:14, 5:6] <- 1L
    summer_small[13, c(4, 7)] <- 1L

    winter_small <- empty # white snowflake
    winter_small[13, 5:6] <- 1L
    winter_small[c(12, 14), c(4)] <- 1L

    fall_small <- empty # orange leaf
    fall_small[c(14, 12, 10:9), 4] <- 1L
    fall_small[c(13, 11), c(3, 5)] <- 1L

    spring_small <- empty # blue flower
    spring_small[c(14, 12), 4] <- 1L
    spring_small[c(13), c(3,5)] <- 1L
    spring_small[10:11, 4] <- 1L

    bml <- add_suits(bml, sun_black_small,   "U+FCD30")
    bml <- add_suits(bml, moon_black_small,  "U+FCD31")
    bml <- add_suits(bml, crown_black_small, "U+FCD32")
    bml <- add_suits(bml, arm_black_small,   "U+FCD33")

    bml <- add_suits(bml, sun_white_small,   "U+FCD40")
    bml <- add_suits(bml, moon_white_small,  "U+FCD41")
    bml <- add_suits(bml, crown_white_small, "U+FCD42")
    bml <- add_suits(bml, arm_white_small,   "U+FCD43")

    bml <- add_suits(bml, heart_black_small,   "U+FCD50")
    bml <- add_suits(bml, spade_black_small,   "U+FCD51")
    bml <- add_suits(bml, club_black_small,    "U+FCD52")
    bml <- add_suits(bml, diamond_black_small, "U+FCD53")

    bml <- add_suits(bml, heart_white_small,   "U+FCD60")
    bml <- add_suits(bml, spade_white_small,   "U+FCD61")
    bml <- add_suits(bml, club_white_small,    "U+FCD62")
    bml <- add_suits(bml, diamond_white_small, "U+FCD63")

    bml <- add_suits(bml, summer_small, "U+FCD70")
    bml <- add_suits(bml, winter_small, "U+FCD71")
    bml <- add_suits(bml, fall_small,   "U+FCD72")
    bml <- add_suits(bml, spring_small, "U+FCD73")

    bml <- add_suits(bml, sun_black, "U+FCC00")
    bml <- add_suits(bml, moon_black, "U+FCC01")
    bml <- add_suits(bml, crown_black, "U+FCC02")
    bml <- add_suits(bml, arm_black, "U+FCC03")

    bml <- add_suits(bml, sun_white, "U+FCC10")
    bml <- add_suits(bml, moon_white, "U+FCC11")
    bml <- add_suits(bml, crown_white, "U+FCC12")
    bml <- add_suits(bml, arm_white, "U+FCC13")

    bml <- add_suits(bml, heart_black, "U+FCC20")
    bml <- add_suits(bml, spade_black, "U+FCC21")
    bml <- add_suits(bml, club_black, "U+FCC22")
    bml <- add_suits(bml, diamond_black, "U+FCC23")

    bml <- add_suits(bml, heart_white, "U+FCC30")
    bml <- add_suits(bml, spade_white, "U+FCC31")
    bml <- add_suits(bml, club_white, "U+FCC32")
    bml <- add_suits(bml, diamond_white, "U+FCC33")

    bml <- add_suits(bml, summer, "U+FCC40")
    bml <- add_suits(bml, winter, "U+FCC41")
    bml <- add_suits(bml, fall, "U+FCC42")
    bml <- add_suits(bml, spring, "U+FCC43")

    # 3 x Ranks
    ranks <- as_bm_list(" n23456789XE", font = fixed_5x8) |>
                bm_extend(height = 16L, width = 16L,
                          hjust = "center-right",
                          vjust = "center-bottom") |>
                bm_shift(right = 0L)
    ranks[[11]] <- bm_flip(ranks[[3]], "both", in_place = TRUE)
    ranks[[12]] <- bm_flip(ranks[[4]], "both", in_place = TRUE)

    # spiral <- as_bm_bitmap("\uaa5c", font = unifont) |> bm_shift(right = 1L)
    # spiral[c(7, 9), 10] <- 1L
    # spiral[8, 11] <- 1L
    spiral <- empty
    spiral[9, 9] <- 1L
    spiral[8, 10] <- 1L
    spiral[7, 8:9] <- 1L
    spiral[8, 7] <- 1L
    spiral[9, 6] <- 1L
    spiral[10, 7] <- 1L
    spiral[11, 8:10] <- 1L
    spiral[10, 11] <- 1L
    spiral[7:9, 12] <- 1L
    spiral[6, 11] <- 1L
    spiral[5, 7:10] <- 1L
    spiral[6, 6] <- 1L
    spiral[7, 5] <- 1L
    ranks[[2]] <- spiral

    ucp_t <- range2ucp("U+FCC50..U+FCC5B", FALSE)
    ucp_r <- range2ucp("U+FCC5C..U+FCC67", FALSE)
    ucp_b <- range2ucp("U+FCC68..U+FCC73", FALSE)
    ucp_l <- range2ucp("U+FCC74..U+FCC7F", FALSE)

    ranks_r <- bm_rotate(ranks, 90)
    ranks_b <- bm_rotate(ranks, 180)
    ranks_l <- bm_rotate(ranks, 270)

    for (i in seq_along(ranks)) {
        bml[[ucp_t[i]]] <- ranks[[i]]
        bml[[ucp_r[i]]] <- ranks_r[[i]]
        bml[[ucp_b[i]]] <- ranks_b[[i]]
        bml[[ucp_l[i]]] <- ranks_l[[i]]
    }

    # inverted combining suit symbols
    inv_cs <- empty
    inv_cs[10:14, 3:7] <- 1L

    inverted_background <- empty
    inverted_background[6:10, 4:13] <- 1L
    inverted_background[4:13, 7:11] <- 1L
    inverted_background[13, 8:9] <- 0L

    inverted_coin <- bm_mask(circle, inverted_background) |>
            bm_mask(bm_outline(circle)) |>
            bm_mask(bm_outline(circle_1)) |>
            bm_mask(dm)

    inverted_die <- empty
    inverted_die[3:14, 3:14] <- 1L
    inverted_die <- bm_mask(inverted_die, inverted_background)
    inverted_tile <- bm_mask(inverted_die, inv_cs)

    inverted_pawn <- bm_mask(pawn_1, inverted_background)

    bml <- add_suits(bml, inverted_tile, "U+FCDF0")
    bml <- add_suits(bml, inverted_coin, "U+FCDF1")
    bml <- add_suits(bml, inverted_die,  "U+FCDF2")
    bml <- add_suits(bml, inverted_pawn, "U+FCDF3")

    ucp_sr <- expand_braces(c("U+FCC{0..4}{0..3}", "U+FCC5{{0..9},A,B}"))
    ucp_sr_inverted <- expand_braces(c("U+FCC{8,9,A,B,C}{0..3}", "U+FCCD{{0..9},A,B}"))
    for (i in seq_along(ucp_sr)) {
        bml[[ucp_sr_inverted[i]]] <- bm_mask(inverted_background,
                                             bml[[ucp_sr[i]]])
        # bml[[ucp_sr_inverted[i]]] <- bm_overlay(bml[[ucp_sr_inverted[i]]], inv_circ)
    }
    ucp_sr_inverted_90 <- expand_braces(c("U+FCC{8,9,A,B,C}{4..7}", "U+FCCD{C..F}", "U+FCCE{0..7}"))
    for (i in seq_along(ucp_sr)) {
        bml[[ucp_sr_inverted_90[i]]] <- bm_rotate(bml[[ucp_sr_inverted[i]]], 90)
    }
    ucp_sr_inverted_180 <- expand_braces(c("U+FCC{8,9,A,B,C}{8,9,A,B}", "U+FCCE{8,9,{A..F}}", "U+FCCF{0..4}"))
    for (i in seq_along(ucp_sr)) {
        bml[[ucp_sr_inverted_180[i]]] <- bm_rotate(bml[[ucp_sr_inverted[i]]], 180)
    }
    ucp_sr_inverted_270 <- expand_braces(c("U+FCC{8,9,A,B,C}{C..F}", "U+FCCF{{4..9},{A..F}}"))
    for (i in seq_along(ucp_sr)) {
        bml[[ucp_sr_inverted_270[i]]] <- bm_rotate(bml[[ucp_sr_inverted[i]]], 270)
    }

    ucp_cs <- expand_braces("U+FCD{3..7}{0..3}")
    ucp_cs_inverted <- expand_braces("U+FCD{8,9,A,B,C}{0..3}")
    for (i in seq_along(ucp_cs)) {
        bml[[ucp_cs_inverted[i]]] <- bm_mask(inv_cs, bml[[ucp_cs[i]]])
    }
    ucp_cs_inverted_90 <- expand_braces("U+FCD{8,9,A,B,C}{4..7}")
    for (i in seq_along(ucp_cs)) {
        bml[[ucp_cs_inverted_90[i]]] <- bm_rotate(bml[[ucp_cs_inverted[i]]], 90)
    }
    ucp_cs_inverted_180 <- expand_braces("U+FCD{8,9,A,B,C}{8,9,A,B}")
    for (i in seq_along(ucp_cs)) {
        bml[[ucp_cs_inverted_180[i]]] <- bm_rotate(bml[[ucp_cs_inverted[i]]], 180)
    }
    ucp_cs_inverted_270 <- expand_braces("U+FCD{8,9,A,B,C}{C..F}")
    for (i in seq_along(ucp_cs)) {
        bml[[ucp_cs_inverted_270[i]]] <- bm_rotate(bml[[ucp_cs_inverted[i]]], 270)
    }

    #   Pre-combined Ranks
    ucp_pcr <- range2ucp("U+FCEE0..U+FCEE5", FALSE)
    ucp_pcr_inv <- range2ucp("U+FCEF0..U+FCEF6", FALSE)
    ranks_pcr <- bm_overlay(ranks, enclosing_coin) |> bm_overlay(dm)
    ranks_pcr_inv <- bm_mask(ranks, base = inverted_background) |>
                        bm_overlay(inverted_coin) |>
                        bm_overlay(enclosing_coin)
    for (i in seq_along(ucp_pcr)) {
        bml[[ucp_pcr[i]]] <- ranks_pcr[[i]]
        bml[[ucp_pcr_inv[i]]] <- ranks_pcr_inv[[i]]
    }
    bml[["U+FCEEC"]] <- bm_overlay(enclosing_tile, gridlines)
    bml[["U+FCEED"]] <- bm_overlay(enclosing_saucer, dm)

    gridlines_inverted <- bm_mask(!empty, gridlines)
    gridlines_inverted[c(1:2, 15:16), 1:16] <- 0L
    gridlines_inverted[1:16, c(1:2, 15:16)] <- 0L
    bml[["U+FCD01"]] <- gridlines_inverted
    bml[["U+FCEFC"]] <- bm_overlay(gridlines_inverted, enclosing_tile)
    # bml[["U+FCEFF"]] <- bm_mask(circle, dm) |> bm_mask(bm_outline(circle_4))

    # Pre-composed Game Pieces
    l_suits <- list("U+FCF00" = sun_black,
                    "U+FCF10" = moon_black,
                    "U+FCF20" = crown_black,
                    "U+FCF30" = arm_black,
                    "U+FCF40" = heart_black,
                    "U+FCF50" = spade_black,
                    "U+FCF60" = club_black,
                    "U+FCF70" = diamond_black,
                    "U+FCF80" = heart_white,
                    "U+FCF90" = spade_white,
                    "U+FCFA0" = club_white,
                    "U+FCFB0" = diamond_white,
                    "U+FCFC0" = summer,
                    "U+FCFD0" = winter,
                    "U+FCFE0" = fall,
                    "U+FCFF0" = spring)
    l_suits_small <- list("U+FCF00" = sun_black_small,
                          "U+FCF10" = moon_black_small,
                          "U+FCF20" = crown_black_small,
                          "U+FCF30" = arm_black_small,
                          "U+FCF40" = heart_black_small,
                          "U+FCF50" = spade_black_small,
                          "U+FCF60" = club_black_small,
                          "U+FCF70" = diamond_black_small,
                          "U+FCF80" = heart_white_small,
                          "U+FCF90" = spade_white_small,
                          "U+FCFA0" = club_white_small,
                          "U+FCFB0" = diamond_white_small,
                          "U+FCFC0" = summer_small,
                          "U+FCFD0" = winter_small,
                          "U+FCFE0" = fall_small,
                          "U+FCFF0" = spring_small)

    starts <- names(l_suits)

    make_tile <- function(rank, suit) {
        bm_overlay(bm_shift(rank, right = 0), enclosing_tile) |>
            bm_overlay(suit)
    }

    make_die <- function(rank) {
        bm_overlay(bm_shift(rank, top = 0),
                   enclosing_die)
    }

    for (start in names(l_suits)) {

        u_char <- Unicode::as.u_char(start)
        suit <- l_suits[[start]]
        suit_small <- l_suits_small[[start]]
        suit_inverted <- bm_mask(inverted_background, suit)

        bml[[hex2ucp(u_char + 0)]] <- make_tile(ranks[[1]], suit_small)
        bml[[hex2ucp(u_char + 1)]] <- make_tile(suit, suit_small)
        bml[[hex2ucp(u_char + 2)]] <- make_tile(ranks[[3]], suit_small)
        bml[[hex2ucp(u_char + 3)]] <- make_tile(ranks[[4]], suit_small)
        bml[[hex2ucp(u_char + 4)]] <- make_tile(ranks[[5]], suit_small)
        bml[[hex2ucp(u_char + 5)]] <- make_tile(ranks[[6]], suit_small)

        bml[[hex2ucp(u_char + 6)]] <- make_die(ranks[[1]])
        bml[[hex2ucp(u_char + 7)]] <- make_die(suit)
        bml[[hex2ucp(u_char + 8)]] <- make_die(ranks[[3]])
        bml[[hex2ucp(u_char + 9)]] <- make_die(ranks[[4]])
        bml[[hex2ucp(u_char + 10)]] <- make_die(ranks[[5]])
        bml[[hex2ucp(u_char + 11)]] <- make_die(ranks[[6]])

        bml[[hex2ucp(u_char + 12)]] <- bm_overlay(suit, enclosing_coin) |> bm_overlay(dm)
        bml[[hex2ucp(u_char + 13)]] <- bm_overlay(suit, pawn_w)
        bml[[hex2ucp(u_char + 14)]] <- bm_overlay(suit, enclosing_saucer) |> bm_overlay(dm)
        bml[[hex2ucp(u_char + 15)]] <- bm_overlay(suit_inverted, enclosing_coin) |> bm_overlay(inverted_coin)

    }

    ## Pre-composed piecepack combining characters
    pre_enclosing_tiles <- range2ucp("U+FCE00..U+FCE4F", FALSE)
    combining_suits <- range2ucp("U+FCD30..U+FCD7F", FALSE)
    for (i in seq_along(pre_enclosing_tiles)) {
        bml[[pre_enclosing_tiles[i]]] <- bm_overlay(bml[[combining_suits[i]]], enclosing_tile)
    }

    bml <- add_suits(bml, bm_overlay(enclosing_coin, dm), "U+FCE50")
    bml <- add_suits(bml, bm_overlay(enclosing_saucer, dm), "U+FCE51")
    bml <- add_suits(bml, bm_overlay(enclosing_coin_small, dm), "U+FCE52")
    bml <- add_suits(bml, bm_overlay(enclosing_saucer_small, dm), "U+FCE53")

    ## white pieces on black background
    bml <- add_suits(bml, Reduce(bm_overlay, list(enclosing_coin, dm, circle_background)), "U+FCE60")
    bml <- add_suits(bml, bm_overlay(enclosing_pawn, pawn_background), "U+FCE61")

    pre_enclosing_tiles <- expand_braces("U+FCE{7,8,9,A,B}{0..3}")
    combining_suits <- expand_braces("U+FCD{8,9,A,B,C}{0..3}")
    for (i in seq_along(pre_enclosing_tiles)) {
        bml[[pre_enclosing_tiles[i]]] <- bm_overlay(bml[[combining_suits[i]]], enclosing_tile) |>
                                            bm_overlay(inverted_tile)
    }
    pre_enclosing_tiles <- expand_braces("U+FCE{7,8,9,A,B}{4..7}")
    combining_suits <- expand_braces("U+FCD{8,9,A,B,C}{4..7}")
    for (i in seq_along(pre_enclosing_tiles)) {
        bml[[pre_enclosing_tiles[i]]] <- bm_overlay(bml[[combining_suits[i]]], enclosing_tile) |>
                                            bm_overlay(bm_rotate(inverted_tile, 90))
    }
    pre_enclosing_tiles <- expand_braces("U+FCE{7,8,9,A,B}{8,9,A,B}")
    combining_suits <- expand_braces("U+FCD{8,9,A,B,C}{8,9,A,B}")
    for (i in seq_along(pre_enclosing_tiles)) {
        bml[[pre_enclosing_tiles[i]]] <- bm_overlay(bml[[combining_suits[i]]], enclosing_tile) |>
                                            bm_overlay(bm_rotate(inverted_tile, 180))
    }
    pre_enclosing_tiles <- expand_braces("U+FCE{7,8,9,A,B}{C..F}")
    combining_suits <- expand_braces("U+FCD{8,9,A,B,C}{C..F}")
    for (i in seq_along(pre_enclosing_tiles)) {
        bml[[pre_enclosing_tiles[i]]] <- bm_overlay(bml[[combining_suits[i]]], enclosing_tile) |>
                                            bm_overlay(bm_rotate(inverted_tile, 270))
    }

    bml <- add_suits(bml, bm_overlay(enclosing_coin, inverted_coin), "U+FCEC0")
    bml <- add_suits(bml, bm_overlay(enclosing_die, inverted_die), "U+FCEC1")
    bml <- add_suits(bml, bm_overlay(enclosing_pawn, inverted_die), "U+FCEC2")

    ## black pieces on black background
    bml <- add_suits(bml, Reduce(bm_overlay, list(enclosing_coin, inverted_coin, circle_background)), "U+FCED0")
    bml <- add_suits(bml, Reduce(bm_overlay, list(enclosing_pawn, inverted_die, pawn_background)), "U+FCED1")

    ## Larger Piecepack Suits/Ranks
    small_ucp <- range2ucp("U+FCC00..U+FCC7F", FALSE)
    large_ucp <- range2ucp("U+FCB00..U+FCB7F", FALSE)
    large_ucp_inverted <- range2ucp("U+FCB80..U+FCBFF", FALSE)
    for (i in seq_along(small_ucp)) {
        glyph <- bml[[small_ucp[i]]] |> bm_pad(sides = 0L) |>
                    bm_expand(width=2L, height=2L) |>
                    bm_extend(width=16L, height=16L, hjust="center-right", vjust="center-bottom")
        bml[[large_ucp[i]]] <- glyph
        bml[[large_ucp_inverted[i]]] <- bm_mask(!empty, glyph)
    }

    bml
}
