plot_bitmap <- function(file_txt, font, combining_ucp) {
    txt <- readLines(file_txt)
    bm <- as_bm_bitmap(txt, font = font, pua_combining = combining_ucp)

    plot(bm, col = c("white", "black"))
}

make_examples <- function(mono_font, duo_font, combining_ucp) {

    file_4schess_txt <- "txt/piecepack-four-seasons-chess_mono.txt"
    file_4schess_png <- "png/piecepack-four-seasons-chess_mono.png"

    file_bkgmn_txt <- "txt/piecepack-backgammon_duo.txt"
    file_bkgmn_png <- "png/piecepack-backgammon_duo.png"

    file_xiangqi_txt <- "txt/piecepack-xiangqi_duo.txt"
    file_xiangqi_png <- "png/piecepack-xiangqi_duo.png"

    file_dominoes_txt <- "txt/dominoes_mono.txt"
    file_dominoes_png <- "png/dominoes_mono.png"

    file_go_txt <- "txt/go_mono.txt"
    file_go_png <- "png/go_mono.png"

    # dominoes
    df <- tibble(piece_side = "tile_face",
                 x=c(0.5, 1.0, 1.5, 2.0, 2.5, 2.5, 3.5, 4.0, 4.0,
                     4.5, 5.5, 6.0, 7.5, 8.0),
                 y=c(5.0, 2.5, 1.0, 4.5, 6.0, 3.0, 1.0, 6.5, 2.5,
                     4.0, 6.0, 4.5, 4.0, 2.5),
                 rank = c(4, 2, 5, 4, 1, 1, 5, 1, 5, 6, 2, 6, 6, 4) + 1,
                 suit = c(4, 5, 0, 1, 1, 5, 4, 2, 5, 5, 6, 6, 4, 0) + 1,
                 angle = c(0, 90, 0, 90, 0, 0, 0, 90, 90, 0, 0, 90, 0, 90),
                 cfg = "dominoes_white")
    cat_piece(df, style = "game-bit-mono", file = file_dominoes_txt)

    png(file_dominoes_png, width=600, height=600)
    plot_bitmap(file_dominoes_txt, mono_font, combining_ucp)
    dev.off()

    # piecepack
    cat_piece(df_backgammon(), style = "game-bit-duo",
              file = file_bkgmn_txt)
    png(file_bkgmn_png, width=1200, height=320)
    plot_bitmap(file_bkgmn_txt, duo_font, combining_ucp)
    dev.off()

    cat_piece(df_four_seasons_chess(), style = "game-bit-mono",
              file = file_4schess_txt)
    png(file_4schess_png)
    plot_bitmap(file_4schess_txt, mono_font, combining_ucp)
    dev.off()

    cat_piece(df_xiangqi(), style = "game-bit-duo",
              file = file_xiangqi_txt)
    png(file_xiangqi_png, width=540, height=720)
    plot_bitmap(file_xiangqi_txt, duo_font, combining_ucp)
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
