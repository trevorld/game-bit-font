# https://books.ropensci.org/targets
# tar_make()
# unifont = tar_read("unifont")

library("targets")

if (packageVersion("bittermelon") < "0.1.0-39")
    tar_throw_validate("{bittermelon} too old.  Please upgrade.")

source("R/combining_diacritical_marks_for_symbols.R")
source("R/miscellaneous_symbols.R")
source("R/box_drawing.R")
source("R/braille_patterns.R")
source("R/ttf.R")

tar_option_set(packages = c("bittermelon", "glue", "grid", "hexfont"))
# tar_option_set(debug = "font")
list(
    tar_target(version, "0.1.0-7"),
    tar_target(font_name, "Game Bit Mono"),
    tar_target(copyright, "Copyright (C) 1998-2021 Trevor L Davis, Roman Czyborra, Paul Hardy, et al. License: SIL Open Font License version 1.1 and GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl.html> with the GNU Font Embedding Exception."),
    tar_target(unifont, hexfont::unifont()),
    tar_target(basic_latin, unifont[block2ucp("Basic Latin")]),
    tar_target(latin1_supplement, unifont[block2ucp("Latin-1 Supplement")]),
    tar_target(general_punctuation, {
        blm <- bm_list()
        quincunx <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))
        quincunx[c(4:5, 12:13), 4:5] <- 1L
        quincunx[c(4:5, 12:13), 12:13] <- 1L
        quincunx[8:9, 8:9] <- 1L
        blm[["U+2059"]] <- quincunx
        blm
    }),
    tar_target(combining_diacritical_marks_for_symbols, create_combining_diacritical_marks_for_symbols()),
    tar_target(mathematical_operators, {
        blm <- bm_list()
        mh... <- ur... <- dr... <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))
        mh...[8:9, c(4:5, 8:9, 12:13)] <- 1L
        ur...[4:5, 4:5] <- 1L
        ur...[8:9, 8:9] <- 1L
        ur...[12:13, 12:13] <- 1L
        dr...[4:5, 12:13] <- 1L
        dr...[8:9, 8:9] <- 1L
        dr...[12:13, 4:5] <- 1L
        blm[["U+22EF"]] <- mh...
        blm[["U+22F0"]] <- ur...
        blm[["U+22F1"]] <- dr...
        blm
    }),
    tar_target(box_drawing, create_box_drawing()),
    tar_target(miscellaneous_symbols,
               create_miscellaneous_symbols(unifont,
                                            general_punctuation, combining_diacritical_marks_for_symbols,
                                            mathematical_operators,
                                            braille_patterns, katakana)),
    tar_target(block_elements, {
        block <- bm_expand(unifont[block2ucp("Block Elements")], width = 2L)
        for (ucp in c("U+2591", "U+2592", "U+2593")) {
            block[[ucp]] <- cbind(unifont[[ucp]], unifont[[ucp]])
        }
        block
    }),
    tar_target(braille_patterns, create_braille_patterns()),
    tar_target(cjk_symbols_and_punctuation, {
        space <- left_dot <- bm_bitmap(matrix(0L, 16L, 16L))
        left_dot[8:9, 4:5] <- 1L
        bm_list(`U+3000` = space, `U+302E` = left_dot)
    }),
    tar_target(katakana, {
        middle_dot <- bm_bitmap(matrix(0L, 16L, 16L))
        middle_dot[8:9, 8:9] <- 1L
        bm_list(`U+30FB` = middle_dot)
    }),
    tar_target(
        halfwidth_and_fullwidth_forms,
        unifont[range2ucp("U+FF01..U+FF5E")]
    ),
    tar_target(musical_symbols, {
        right_dot <- bm_bitmap(matrix(0L, 16L, 16L))
        right_dot[8:9, 12:13] <- 1L
        bm_list(`U+1D16D` = right_dot)
    }),
    tar_target(domino_tiles, unifont[block2ucp("Domino Tiles")]),
    tar_target(chess_symbols, unifont[block2ucp("Chess Symbols")]),
    tar_target(font, {
        font <- c(basic_latin, # U+0020
                  latin1_supplement, # U+00A0
                  general_punctuation, #U+2000
                  combining_diacritical_marks_for_symbols, # U+20D0
                  mathematical_operators, # U+2200
                  box_drawing, # U+2500
                  block_elements, # U+2580
                  miscellaneous_symbols, # U+2600
                  braille_patterns, # U+2800
                  cjk_symbols_and_punctuation, # U+3000
                  katakana, # U+30A0
                  halfwidth_and_fullwidth_forms, # U+FF01
                  musical_symbols, # U+1D16D
                  domino_tiles, # U+1F030
                  chess_symbols # U+1FA00
        )
        font <- font[ucp_sort(names(font))]
        font
    }),
    tar_target(hex_file, {
        write_hex(font, "game-bit-mono.hex")
        "game-bit-mono.hex"
    },
    format = "file"
    ),
    tar_target(bdf_file, {
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
