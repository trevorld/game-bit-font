create_braille_patterns <- function() {
    bml <- bm_list()
    empty <- bm_bitmap(matrix(0, nrow=16L, ncol=16L))
    dot1 <- dot2 <- dot3 <- dot4 <- dot5 <- dot6 <- empty
    dot1[12:13, 4:5] <- 1L
    dot2[8:9, 4:5] <- 1L
    dot3[4:5, 4:5] <- 1L
    dot4[12:13, 12:13] <- 1L
    dot5[8:9, 12:13] <- 1L
    dot6[4:5, 12:13] <- 1L

    bml[["U+2800"]] <- empty
    bml[["U+2801"]] <- dot1
    bml[["U+2802"]] <- dot2
    bml[["U+2803"]] <- dot12 <- bm_overlay(dot1, dot2)
    bml[["U+2804"]] <- dot3
    bml[["U+2805"]] <- dot13 <- bm_overlay(dot1, dot3)
    bml[["U+2806"]] <- dot23 <- bm_overlay(dot2, dot3)
    bml[["U+2807"]] <- dot123 <- bm_overlay(dot12, dot3)
    bml[["U+2808"]] <- dot4
    bml[["U+2809"]] <- dot14 <- bm_overlay(dot1, dot4)
    bml[["U+280A"]] <- dot24 <- bm_overlay(dot2, dot4)
    bml[["U+280B"]] <- dot124 <- bm_overlay(dot12, dot4)
    bml[["U+280C"]] <- dot34 <- bm_overlay(dot3, dot4)
    bml[["U+280D"]] <- dot134 <- bm_overlay(dot13, dot4)
    bml[["U+280E"]] <- dot234 <- bm_overlay(dot23, dot4)
    bml[["U+280F"]] <- dot1234 <- bm_overlay(dot123, dot4)
    bml[["U+2810"]] <- dot5
    bml[["U+2811"]] <- dot15 <- bm_overlay(dot1, dot5)
    bml[["U+2812"]] <- dot25 <- bm_overlay(dot2, dot5)
    bml[["U+2813"]] <- dot125 <- bm_overlay(dot12, dot5)
    bml[["U+2814"]] <- dot35 <- bm_overlay(dot3, dot5)
    bml[["U+2815"]] <- dot135 <- bm_overlay(dot13, dot5)
    bml[["U+2816"]] <- dot235 <- bm_overlay(dot23, dot5)
    bml[["U+2817"]] <- dot1235 <- bm_overlay(dot123, dot5)
    bml[["U+2818"]] <- dot45 <- bm_overlay(dot4, dot5)
    bml[["U+2819"]] <- dot145 <- bm_overlay(dot14, dot5)
    bml[["U+281A"]] <- dot245 <- bm_overlay(dot24, dot5)
    bml[["U+281B"]] <- dot1245 <- bm_overlay(dot124, dot5)
    bml[["U+281C"]] <- dot345 <- bm_overlay(dot34, dot5)
    bml[["U+281D"]] <- dot1345 <- bm_overlay(dot134, dot5)
    bml[["U+281E"]] <- dot2345 <- bm_overlay(dot234, dot5)
    bml[["U+281F"]] <- dot12345 <- bm_overlay(dot1234, dot5)
    bml[["U+2820"]] <- dot6
    bml[["U+2821"]] <- dot16 <- bm_overlay(dot1, dot6)
    bml[["U+2822"]] <- dot26 <- bm_overlay(dot2, dot6)
    bml[["U+2823"]] <- dot126 <- bm_overlay(dot12, dot6)
    bml[["U+2824"]] <- dot36 <- bm_overlay(dot3, dot6)
    bml[["U+2825"]] <- dot136 <- bm_overlay(dot13, dot6)
    bml[["U+2826"]] <- dot236 <- bm_overlay(dot23, dot6)
    bml[["U+2827"]] <- dot1236 <- bm_overlay(dot123, dot6)
    bml[["U+2828"]] <- dot46 <- bm_overlay(dot4, dot6)
    bml[["U+2829"]] <- dot146 <- bm_overlay(dot14, dot6)
    bml[["U+282A"]] <- dot246 <- bm_overlay(dot24, dot6)
    bml[["U+282B"]] <- dot1246 <- bm_overlay(dot124, dot6)
    bml[["U+282C"]] <- dot346 <- bm_overlay(dot34, dot6)
    bml[["U+282D"]] <- dot1346 <- bm_overlay(dot134, dot6)
    bml[["U+282E"]] <- dot2346 <- bm_overlay(dot234, dot6)
    bml[["U+282F"]] <- dot12346 <- bm_overlay(dot1234, dot6)
    bml[["U+2830"]] <- dot56 <- bm_overlay(dot5, dot6)
    bml[["U+2831"]] <- dot156 <- bm_overlay(dot15, dot6)
    bml[["U+2832"]] <- dot256 <- bm_overlay(dot25, dot6)
    bml[["U+2833"]] <- dot1256 <- bm_overlay(dot125, dot6)
    bml[["U+2834"]] <- dot356 <- bm_overlay(dot35, dot6)
    bml[["U+2835"]] <- dot1356 <- bm_overlay(dot135, dot6)
    bml[["U+2836"]] <- dot2356 <- bm_overlay(dot235, dot6)
    bml[["U+2837"]] <- dot12356 <- bm_overlay(dot1235, dot6)
    bml[["U+2838"]] <- dot456 <- bm_overlay(dot45, dot6)
    bml[["U+2839"]] <- dot1456 <- bm_overlay(dot145, dot6)
    bml[["U+283A"]] <- dot2456 <- bm_overlay(dot245, dot6)
    bml[["U+283B"]] <- dot12456 <- bm_overlay(dot1245, dot6)
    bml[["U+283C"]] <- dot3456 <- bm_overlay(dot345, dot6)
    bml[["U+283D"]] <- dot13456 <- bm_overlay(dot1345, dot6)
    bml[["U+283E"]] <- dot23456 <- bm_overlay(dot2345, dot6)
    bml[["U+283F"]] <- dot123456 <- bm_overlay(dot12345, dot6)

    bml
}
