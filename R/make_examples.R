plot_bitmap <- function(file_txt, font, combining_ucp) {
    txt <- readLines(file_txt)
    bm <- as_bm_bitmap(txt, font = font, pua_combining = combining_ucp)

    plot(bm, col = c("white", "black"))
}

make_examples <- function(mono_font, duo_font, combining_ucp) {

    file_4schess_txt <- "txt/four-seasons-chess_mono.txt"
    file_4schess_png <- "png/piecepack-four-seasons-chess_mono.png"

    file_dominoes_txt <- "txt/dominoes.txt"
    file_dominoes_png <- "png/dominoes_mono.png"

    file_go_txt <- "txt/go_mono.txt"
    file_go_png <- "png/go_mono.png"

    # dominoes
    df <- tibble(piece_side = "tile_face",
                 x=c(1, 2.5, 4, 5.5, 7.5, 9.5, 11),
                 y=2, suit = c(7, 7, 4, 4, 6, 3, 5),
                 rank = c(7, 4, 4, 6, 3, 5, 5),
                 angle = -c(0, 90, 0, 90, 90, 90, 0),
                 cfg = "dominoes")
    cat_piece(df, style = "game-bit-mono", file = file_dominoes_txt)


    png(file_dominoes_png, width=480, height=200)
    plot_bitmap(file_dominoes_txt, mono_font, combining_ucp)
    dev.off()

    # piecepack
    cat_piece(df_four_seasons_chess(), style = "game-bit-mono",
              file = file_4schess_txt)

    png(file_4schess_png)
    plot_bitmap(file_4schess_txt, mono_font, combining_ucp)
    dev.off()

    # go
    # txt created manually
    png(file_go_png, width=400, height = 400)
    plot_bitmap(file_go_txt, mono_font, combining_ucp)
    dev.off()

    c(file_dominoes_txt, file_dominoes_png,
      file_4schess_txt, file_4schess_png,
      file_go_png)
}
