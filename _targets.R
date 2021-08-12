# https://books.ropensci.org/targets
# tar_make()
# unifont = tar_read("unifont")

library("targets")

if (packageVersion("bittermelon") < "0.1.0-39")
    tar_throw_validate("{bittermelon} too old.  Please upgrade.")

source("R/ttf.R")
tar_option_set(packages = c("bittermelon", "glue", "hexfont"))
list(
    tar_target(font_name, "Game Bit Mono"),
    tar_target(version, "0.1.0-3"),
    tar_target(copyright, "Copyright (C) 1998-2021 Trevor L Davis, Roman Czyborra, Paul Hardy, et al. License: SIL Open Font License version 1.1 and GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl.html> with the GNU Font Embedding Exception."),
    tar_target(unifont, hexfont::unifont()),
    tar_target(basic_latin, unifont[block2ucp("Basic Latin")]),
    tar_target(latin1_supplement, unifont[block2ucp("Latin-1 Supplement")]),
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
    tar_target( cjk_symbols_and_punctuation, unifont[c("U+3000", "U+302E", "U+302F")]),
    tar_target(
        halfwidth_and_fullwidth_forms,
        unifont[range2ucp("U+FF01..U+FF5E")]
    ),
    tar_target(chess_symbols, unifont[block2ucp("Chess Symbols")]),
    tar_target(
        font,
        c(basic_latin, # U+0020
          latin1_supplement, # U+00A0
          block_elements, # U+2580
          cjk_symbols_and_punctuation, # U+3000
          halfwidth_and_fullwidth_forms, # U+FF01
          chess_symbols # U+1FA00
        )
    ),
    tar_target(
        hex_file,
        {
            write_hex(font, "game-bit-mono.hex")
            "game-bit-mono.hex"
        },
        format = "file"
    ),
    tar_target(
        bdf_file,
        {
            bdf_file <- gsub(".hex$", ".bdf", hex_file)
            system2("perl",
                    c("bin/hex2bdf",
                      "-f", shQuote(font_name),
                      "-v", version,
                      "-c", shQuote(copyright)),
                    stdin = hex_file,
                    stdout = bdf_file)
            bdf_file
        },
        format = "file"
    ),
    tar_target(
        combining_file,
        {
            ucp <- names(font)
            ucp <- ucp[which(is_combining_character(ucp))]
            ucp <- ucp_sort(ucp)
            combining <- font[ucp]
            widths <- bm_widths(combining)
            txt <- paste0(substr(ucp, 3, nchar(ucp)), ":", -widths)
            writeLines(txt, "combining.txt")
            "combining.txt"
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
                        c("bin/unihex2png", "-i", hex_file,
                          "-p", pages[i],
                          "-o", png_files[i]))
            }
            png_files
        },
        format = "file"
    ),
    tar_target(
        sfd_file,
        fontforge_sfd(hex_file, combining_file, font_name, version, copyright),
        format = "file"
    ),
    # tar_target(
    #     ttf_sbit_file,
    #     fontforge_sbit_ttf(bdf_file, version),
    #     format = "file"
    # ),
    tar_target(
        ttf_file,
        fontforge_outline_ttf(sfd_file),
        format = "file"
    )
)
