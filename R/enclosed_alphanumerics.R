create_enclosed_alphanumerics <- function(basic_latin,
                                          geometric_shapes,
                                          halfwidth_and_fullwidth_forms) {

    white_circle <- geometric_shapes[["U+25CB"]]
    black_circle <- geometric_shapes[["U+25CF"]]
    white_square <- geometric_shapes[["U+25A1"]]
    black_square <- geometric_shapes[["U+25A0"]]
    # hw_19 <- halfwidth_and_fullwidth_forms[range2ucp("U+FF11..U+FF19")]
    bl_19 <- basic_latin[str2ucp(as.character(1:9))] |>
        bm_pad(sides = 0L) |> bm_extend(width=16, height=16)
    bl_19[[1]] <- bm_shift(bl_19[[1]], right = 1L)
    zero <- basic_latin[[str2ucp("0")]] |> bm_pad(sides = 0L)
    one <- basic_latin[[str2ucp("1")]] |> bm_pad(sides = 0L)
    ten <- cbind(one, zero) |> bm_extend(width=16, height=16) |> bm_shift(right = 1L)
    # ten <- bm_overlay(bm_extend(one, width=14, hjust="left"),
    #                   bm_extend(zero, width=14, hjust="right")) |>
    #         bm_extend(width=16, height=16) |> bm_shift(top = 1L)

    circled <- circled_sans <- bm_overlay(bl_19, white_circle)
    negative <- negative_sans <- bm_mask(bl_19, base = black_circle)
    names(circled) <- range2ucp("U+2460..U+2468")
    names(circled_sans) <- range2ucp("U+2780..U+2788")
    names(negative) <- range2ucp("U+2776..U+277E")
    names(negative_sans) <- range2ucp("U+278A..U+2792")

    # circled
    bl_alpha <- basic_latin[str2ucp(c(LETTERS, letters))] |> bm_shift(top = 1L)
    names(bl_alpha) <- range2ucp("U+24B6..U+24E9")
    bl_alpha[["U+24D6"]] <- bm_shift(bl_alpha[["U+24D6"]], top = 1L)
    bl_alpha[["U+24DF"]] <- bm_shift(bl_alpha[["U+24DF"]], top = 1L)
    bl_alpha[["U+24E0"]] <- bm_shift(bl_alpha[["U+24E0"]], top = 1L)
    bl_alpha[["U+24E8"]] <- bm_shift(bl_alpha[["U+24E8"]], top = 1L)
    circled_alpha <- bm_overlay(bl_alpha, white_circle)
    names(circled_alpha) <- range2ucp("U+24B6..U+24E9")

    bl_upper <- bl_alpha[1:26]
    squared_upper <- bm_overlay(bl_upper, white_square)
    names(squared_upper) <- range2ucp("U+1F130..U+1F149")
    negative_circled_upper <- bm_mask(bl_upper, base = black_circle)
    names(negative_circled_upper) <- range2ucp("U+1F150..U+1F169")
    negative_squared_upper <- bm_mask(bl_upper, base = black_square)
    names(negative_squared_upper) <- range2ucp("U+1F170..U+1F189")

    blm <- c(circled, circled_alpha, negative, circled_sans, negative_sans,
             squared_upper, negative_circled_upper, negative_squared_upper)
    blm[["U+2789"]] <- blm[["U+2469"]] <- bm_overlay(white_circle, ten)
    blm[["U+277F"]] <- blm[["U+2793"]] <-  bm_mask(black_circle, ten)
    blm[["U+24EA"]] <- blm[["U+1F10B"]] <- bm_overlay(white_circle, zero)
    blm[["U+24FF"]] <- blm[["U+1F10C"]] <- bm_mask(black_circle, zero)

    blm
}
