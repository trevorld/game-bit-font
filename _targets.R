# https://books.ropensci.org/targets
# tar_make()
# unifont = tar_read("unifont")

library("targets")
# tar_option_set(packages = c("bittermelon", "hexfont"),
#               debug = "unifont")
tar_option_set(packages = c("bittermelon", "hexfont"))
list(
    tar_target(
        unifont,
        hexfont::unifont()
    ),
    tar_target(
        basic_latin,
        unifont[block2ucp("Basic Latin")]
    ),
    tar_target(
        block_elements,
        {
            block <- bm_expand(unifont[block2ucp("Block Elements")], width = 2L)
            for (ucp in c("U+2591", "U+2592", "U+2593")) {
                block[[ucp]] <- cbind(unifont[[ucp]], unifont[[ucp]])
            }
            block
        }
    ),
    tar_target(
        cjk_symbols_and_punctuation,
        unifont[c("U+3000", "U+302E", "U+302F")]
    ),
    tar_target(
        halfwidth_and_fullwidth_forms,
        unifont[range2ucp("U+FF01..U+FF5E")]
    ),
    tar_target(
        chess_symbols,
        unifont[block2ucp("Chess Symbols")]
    ),
    tar_target(
        font,
        c(basic_latin, # U+0020
          block_elements, # U+2580
          cjk_symbols_and_punctuation, # U+3000
          halfwidth_and_fullwidth_forms, # U+FF01
          chess_symbols # U+1FA00
        )
    ),
    tar_target(
        font_file,
        {
            write_hex(font, "game-bit-mono.hex")
            "game-bit-mono.hex"
        },
        format = "file"
    ),
    tar_target(
        png_files,
        {
            ucp <- names(font) |> unique()
            pages <- substr(ucp, 3, nchar(ucp) - 2L) |> unique()
            png_files <- paste0("png/", pages, ".png")
            for (i in seq_along(pages)) {
                system2("perl",
                        c("bin/unihex2png", "-i", font_file,
                          "-p", pages[i],
                          "-o", png_files[i]))
            }
            png_files
        },
        format = "file"
    )
)
