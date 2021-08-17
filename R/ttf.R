# This is a derivative of the file `font/ttfsrc/Makefile` from the GNU Unifont Project
# http://unifoundry.com/unifont/index.html
# Original Makefile were written by Luis Alejandro Gonzalez Miranda (http://lgm.cl/)
# Paul Hardy, and Qianqian Fang

fontforge_sfd <- function(hex_file, combining_file, font_name, version, copyright) {
    sfd_file <- gsub(".hex$", ".sfd", hex_file)
    system2("perl", c("bin/hex2sfd", combining_file, version),
            stdin = hex_file,
            stdout = sfd_file)

    psname <- gsub(" ", "", font_name) # Postscript name of font inside TTF file
    ttf_lang <- "0x409" # American English
    website <- "https://github.com/trevorld/game-bit-font/"

    cmd <- glue::glue(
      'Open("{sfd_file}"); ',
      'SetFontNames("{psname}Regular", ',
          '"{font_name}", "{font_name}", "Regular", ',
          '"{copyright}"); ',
      'SetTTFName({ttf_lang},  2, "Regular"); ',
      'SetTTFName({ttf_lang},  5, "Version {version}"); ',
      'SetTTFName({ttf_lang}, 11, "{website}"); ',
      'SetTTFName({ttf_lang}, 13, "Dual license: SIL Open Font License version 1.1, and GNU GPL version 2 or later with the GNU Font Embedding Exception."); ',
      'SetTTFName({ttf_lang}, 14, "http://gnu.org/licenses/gpl.html"); ',
      'SelectAll(); ',
      'RemoveOverlap(); ',
      'Simplify(64,1); ',
      'Save("{sfd_file}");'
    )

    system2("fontforge", c("-lang=ff", "-c", shQuote(cmd)))
    sfd_file
}

fontforge_outline_ttf <- function(sfd_file) {
    ttf_file <- gsub(".sfd$", ".ttf", sfd_file)
    cmd <- glue::glue('Open("{sfd_file}"); Generate("{ttf_file}");')
    system2("fontforge",
            c("-lang=ff",
              "-c", shQuote(cmd),
              shQuote(sfd_file),
              shQuote(ttf_file)))
    ttf_file
}

# fontforge_sbit_ttf <- function(bdf_file, version) {
#     ttf_file <- gsub(".bdf$", "-sbit.ttf", bdf_file)
#
#     cmd <- glue::glue(
#        'New(); ',
#        'Import("{bdf_file}"); ',
#         'SetFontNames("","","","","","{version}"); ',
#         'Generate("{ttf_file}", "ttf"); ',
#         'Close()'
#     )
#
#     system2("fontforge",
#             c("-lang=ff",
#               "-c", shQuote(cmd),
#               shQuote(bdf_file),
#               shQuote(ttf_file)))
#     ttf_file
# }
