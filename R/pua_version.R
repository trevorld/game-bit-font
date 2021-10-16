create_version_glyph <- function(version, fixed_4x6, mono = FALSE) {

    if (mono) {
        name <- as_bm_list("MONO", font = fixed_4x6) |>
            bm_call(cbind) |>
            bm_extend(width = 16L)
    } else {
        name <- as_bm_list("DUO", font = fixed_4x6) |>
            bm_call(cbind) |>
            bm_extend(width = 16L, hjust = "left")
    }

    v <- as_bm_list(version, font = fixed_4x6) |>
            bm_pad(left = 0L, right = 1L) |>
            bm_call(cbind) |>
            bm_extend(width = 16L, hjust = "left") |>
            bm_pad(top = 2L)

    version_glyph <- rbind(name, v) |> bm_extend(height = 16L)

    bm_list(`U+F800` = version_glyph)
}
