# https://books.ropensci.org/targets
# tar_make()
# unifont = tar_read("unifont")

library("targets")
if (packageVersion("bittermelon") < "0.2.0-12")
    tar_throw_validate("{bittermelon} too old.  Please upgrade.")
if (packageVersion("ppgames") < "0.6.2-20")
    tar_throw_validate("{ppgames} too old.  Please upgrade.")

source("R/box_drawing.R")
source("R/combining_diacritical_marks_for_symbols.R")
source("R/geometric_shapes.R")
source("R/make_examples.R")
source("R/misc_dots.R")
source("R/miscellaneous_symbols.R")
source("R/enclosed_alphanumerics.R")
source("R/braille_patterns.R")
source("R/pua_box_drawing.R")
source("R/pua_domino_suits.R")
source("R/pua_piecepack.R")
source("R/pua_version.R")
source("R/ttf.R")

# tar_option_set(debug = "enclosed_alphanumerics")
# tar_option_set(debug = "mono_hex_file")
tar_option_set(packages = c("bittermelon", "bracer", "glue", "grid", "hexfont",
                            "ppgames", "tibble", "withr"))
list(
    tar_target(version, "0.1.1"),
    tar_target(fixed_4x6, read_yaff(system.file("fonts/fixed/4x6.yaff.gz", package = "bittermelon"))),
    tar_target(fixed_5x8, read_yaff(system.file("fonts/fixed/5x8.yaff.gz", package = "bittermelon"))),
    tar_target(mono_font_name, "Game Bit Mono"),
    tar_target(duo_font_name, "Game Bit Duo"),
    tar_target(copyright, "Copyright (C) 1998-2021 Trevor L Davis, Roman Czyborra, Paul Hardy, et al. License: SIL Open Font License version 1.1 and GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl.html> with the GNU Font Embedding Exception."),
    tar_target(unifont, hexfont::unifont()),
    tar_target(basic_latin, unifont[block2ucp("Basic Latin")]),
    tar_target(latin1_supplement, unifont[block2ucp("Latin-1 Supplement")]),
    tar_target(latin_extended_a, unifont[block2ucp("Latin Extended-A")]),
    tar_target(general_punctuation, {
        blm <- bm_list()
        quincunx <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))
        quincunx[c(4:5, 12:13), 4:5] <- 1L
        quincunx[c(4:5, 12:13), 12:13] <- 1L
        quincunx[8:9, 8:9] <- 1L
        blm[["U+2059"]] <- quincunx
        blm
    }),
    tar_target(superscripts_and_subscripts, unifont[block2ucp("Superscripts and Subscripts")]),
    tar_target(combining_diacritical_marks_for_symbols,
               create_combining_diacritical_marks_for_symbols(geometric_shapes)),
    tar_target(box_drawing, create_box_drawing()),
    tar_target(geometric_shapes, create_geometric_shapes(block_elements)),
    tar_target(block_elements, {
        block <- bm_expand(unifont[block2ucp("Block Elements")], width = 2L)
        for (ucp in c("U+2591", "U+2592", "U+2593")) {
            block[[ucp]] <- cbind(unifont[[ucp]], unifont[[ucp]])
        }
        block
    }),
    tar_target(miscellaneous_symbols,
               create_miscellaneous_symbols(unifont,
                                            general_punctuation, geometric_shapes,
                                            braille_patterns, misc_dots)),
    tar_target(enclosed_alphanumerics,
               create_enclosed_alphanumerics(basic_latin,
                                             geometric_shapes,
                                             halfwidth_and_fullwidth_forms)),
    tar_target(braille_patterns, create_braille_patterns()),
    tar_target(misc_dots, create_misc_dots()),
    tar_target(
        halfwidth_and_fullwidth_forms,
        unifont[range2ucp("U+FF01..U+FF5E")]
    ),
    tar_target(mahjong_tiles, unifont[block2ucp("Mahjong Tiles")]),
    tar_target(domino_tiles, unifont[block2ucp("Domino Tiles")]),
    tar_target(playing_cards, unifont[block2ucp("Playing Cards")]),
    tar_target(chess_symbols, unifont[block2ucp("Chess Symbols")]),
    tar_target(pua_box_drawing, create_pua_box_drawing(box_drawing)),
    tar_target(pua_domino_suits, create_pua_domino_suits()),
    tar_target(pua_piecepack, create_pua_piecepack(unifont, fixed_5x8)),
    tar_target(duo_font, {
        duo_font <- c(basic_latin, # U+0020
                  latin1_supplement, # U+00A0
                  latin_extended_a, # U+0100
                  general_punctuation, # U+2000
                  superscripts_and_subscripts, # U+2070
                  combining_diacritical_marks_for_symbols, # U+20D0
                  misc_dots, # U+2200 U+3000, U+30A0, and U+1D16D
                  box_drawing, # U+2500
                  geometric_shapes, # U+25A0
                  block_elements, # U+2580
                  miscellaneous_symbols, # U+2600
                  enclosed_alphanumerics, # U+2700
                  braille_patterns, # U+2800
                  halfwidth_and_fullwidth_forms, # U+FF01
                  mahjong_tiles, # U+1F000
                  domino_tiles, # U+1F030
                  playing_cards, # U+1F0A0
                  chess_symbols, # U+1FA00
                  create_version_glyph(version, fixed_4x6), # U+F800
                  pua_domino_suits, # U+FCA00
                  pua_piecepack, # U+FCB00
                  pua_box_drawing # U+FDD00
        )
        duo_font <- duo_font[ucp_sort(names(duo_font))]
        duo_font
    }),
    tar_target(mono_font, {
        mono_font = bm_extend(duo_font, width = 16L)
        mono_font[["U+F800"]] <- create_version_glyph(version, fixed_4x6, TRUE)[["U+F800"]]
        mono_font
    }),
    tar_target(duo_hex_file, {
            write_hex(duo_font, "game-bit-duo.hex")
            "game-bit-duo.hex"
        },
        format = "file"
    ),
    tar_target(mono_hex_file, {
            write_hex(mono_font, "game-bit-mono.hex")
            "game-bit-mono.hex"
        },
        format = "file"
    ),
    tar_target(duo_bdf_file, {
            duo_bdf_file <- gsub(".hex$", ".bdf", duo_hex_file)
            system2("perl",
                    c("bin/hex2bdf",
                      "-f", shQuote(duo_font_name),
                      "-v", version,
                      "-c", shQuote(copyright)),
                    stdin = duo_hex_file,
                    stdout = duo_bdf_file)
            duo_bdf_file
        },
        format = "file"
    ),
    tar_target(mono_bdf_file, {
            mono_bdf_file <- gsub(".hex$", ".bdf", mono_hex_file)
            system2("perl",
                    c("bin/hex2bdf",
                      "-f", shQuote(mono_font_name),
                      "-v", version,
                      "-c", shQuote(copyright)),
                    stdin = mono_hex_file,
                    stdout = mono_bdf_file)
            mono_bdf_file
        },
        format = "file"
    ),
    tar_target(
        combining_file,
        {
            ucp <- names(duo_font)
            PUA_combining <- c("U+1DFA",
                               range2ucp("U+FCD10..U+FCDFF", FALSE),
                               range2ucp("U+FCE00..U+FCEDF", FALSE))
            ucp <- ucp[which(is_combining_character(ucp) | (ucp %in% PUA_combining))]
            ucp <- ucp_sort(ucp)
            combining <- duo_font[ucp]
            widths <- bm_widths(combining)
            txt <- paste0(substr(ucp, 3, nchar(ucp)), ":", -widths)
            writeLines(txt, "combining.txt")
            "combining.txt"
        },
        format = "file"
    ),
    tar_target(combining_ucp,
               {
                   df <- read.delim(combining_file, sep = ":", header = FALSE)
                   paste0("U+", df[, 1])
    }),
    tar_target(example_pngs,
               make_examples(mono_font, duo_font, combining_ucp),
               format = "file"),
    tar_target(
        code_chart_pngs,
        {
            ucp <- names(duo_font) |> unique()
            pages <- substr(ucp, 3, nchar(ucp) - 2L) |> unique()
            code_chart_pngs <- paste0("png/code_charts/", pages, ".png")
            for (i in seq_along(pages)) {
                system2("perl",
                        c("bin/unihex2png", "-i", duo_hex_file,
                          "-p", pages[i],
                          "-o", code_chart_pngs[i]))
            }
            code_chart_pngs
        },
        format = "file"
    ),
    tar_target(
        duo_sfd_file,
        fontforge_sfd(duo_hex_file, combining_file, duo_font_name, version, copyright),
        format = "file"
    ),
    tar_target(
        mono_sfd_file,
        fontforge_sfd(mono_hex_file, combining_file, mono_font_name, version, copyright),
        format = "file"
    ),
    # tar_target(
    #     ttf_sbit_file,
    #     fontforge_sbit_ttf(mono_bdf_file, version),
    #     format = "file"
    # ),
    tar_target(
        duo_ttf_file,
        fontforge_outline_ttf(duo_sfd_file),
        format = "file"
    ),
    tar_target(
        mono_ttf_file,
        fontforge_outline_ttf(mono_sfd_file),
        format = "file"
    )
)
