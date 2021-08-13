create_miscellaneous_symbols <- function(unifont) {

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

    for (ucp in range2ucp("U+2654..U+265F")[-c(5, 11)])
        blm[[ucp]] <- bm_shift(blm[[ucp]], right = 1L)

    blm
}
