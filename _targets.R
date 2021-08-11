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
        font,
        c(basic_latin)
    ),
    tar_target(
        font_file,
        {
            write_hex(font, "game-bit-mono.hex")
            "game-bit-mono.hex"
        },
        format = "file"
    )
)
