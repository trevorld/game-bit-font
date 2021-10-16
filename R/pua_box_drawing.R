create_pua_box_drawing <- function(box_drawing) {

    empty <- bm_bitmap(matrix(0L, nrow = 16L, ncol = 16L))

    ## matted-heavy, no inverted x 14
    # light line and one matted heavy
    vlalmh <- box_drawing[["U+2525"]]
    vlalmh[, 6:7] <- 0L
    umhahl <- bm_rotate(vlalmh,  90)
    vlarmh <- bm_rotate(vlalmh, 180)
    dmhahl <- bm_rotate(vlalmh, 270)

    # 3-light and one matted heavy
    lmharvl <- box_drawing[["U+253D"]]
    lmharvl[, 6:7] <- 0L
    umhadhl <- bm_rotate(lmharvl,  90)
    rmhalvl <- bm_rotate(lmharvl, 180)
    dmhauhl <- bm_rotate(lmharvl, 270)

    # 2-light (line), one heavy, and one matted heavy
    vllmharh <- box_drawing[["U+253F"]]
    vllmharh[, 6:7] <- 0L
    umhdhahl <- bm_rotate(vllmharh,  90)
    vllharmh <- bm_rotate(vllmharh, 180)
    uhdmhahl <- bm_rotate(vllmharh, 270)

    # 2-line (line), two heavy (line)
    vlahmh <- box_drawing[["U+253F"]]
    vlahmh[, c(6:7, 10:11)] <- 0L
    vmhahl <- bm_rotate(vlahmh,  90)

    ## matted-heavy, with inverted
    # inverted matted heavy, zero x 4
    vlalimh <- !vlalmh
    vlalimh[, 7:16] <- !vlalimh[, 7:16]
    vlalimh[, 6] <- 1L

    uimhahl <- bm_rotate(vlalimh,  90)
    vlarimh <- bm_rotate(vlalimh, 180)
    dimhahl <- bm_rotate(vlalimh, 270)

    # matted heavy, inverted zero x 4
    vilalmh <- vlalmh
    vilalmh[, 11:16] <- 1L
    umhahil <- bm_rotate(vilalmh,  90)
    vilarmh <- bm_rotate(vilalmh, 180)
    dmhahil <- bm_rotate(vilalmh, 270)

    # inverted matted heavy, two non x 4
    vrlalimh <- vlalimh
    vrlalimh[8:9, 10:16] <- 1L
    uimhahdl <- bm_rotate(vrlalimh,  90)
    vllarimh <- bm_rotate(vrlalimh, 180)
    dimhahul <- bm_rotate(vrlalimh, 270)

    # matted heavy, inverted, non x 4
    lmhin <- vilalmh
    lmhin[1:7, 10:16] <- 0L
    lmhin[8:9, 10:16] <- 1L
    lmhin[10, 10:16] <- 0L

    umhin <- bm_rotate(lmhin,  90)
    rmhin <- bm_rotate(lmhin, 180)
    dmhin <- bm_rotate(lmhin, 270)

    # inverted matted heavy, inverted, non x 4
    limhin <- lmhin
    limhin[, 1:6] <- !lmhin[, 1:6]
    limhin[7:10, 6] <- 1L

    uimhin <- bm_rotate(limhin,  90)
    rimhin <- bm_rotate(limhin, 180)
    dimhin <- bm_rotate(limhin, 270)

    # matted heavy, non, inverted x 4
    lmhni <- bm_flip(lmhin, "v")
    umhni <- bm_rotate(lmhni,  90)
    rmhni <- bm_rotate(lmhni, 180)
    dmhni <- bm_rotate(lmhni, 270)

    # inverted matted heavy, non, inverted x 4
    limhni <- cbind(limhin[, 1:8], lmhni[, 9:16])
    uimhni <- bm_rotate(limhni,  90)
    rimhni <- bm_rotate(limhni, 180)
    dimhni <- bm_rotate(limhni, 270)

    # inverted matted heavy, non matted heavy x 4
    vlrhalimh <- vrlalimh
    vlrhalimh[7:10, 10:16] <- 1L
    uimhdhahl <- bm_rotate(vlrhalimh,  90)
    vllharimh <- bm_rotate(vlrhalimh, 180)
    dimhuhahl <- bm_rotate(vlrhalimh, 270)

    # two inverted matted heavy x 2
    himhvl <- cbind(limhin[, 1:8],
                    bm_flip(limhin[, 1:8], "h"))
    hlvimh <- bm_rotate(himhvl, 90)

    ## inverted light line corner/half combos x (16 + 18 + 12 + 7)
    # 1 black x (4 + 12)
    ulc <- empty
    ulc[11:16, 1:6] <- 1L
    ulc[8:9, 1:9] <- 1L
    ulc[8:16, 8:9] <- 1L

    urc <- bm_rotate(ulc,  90)
    drc <- bm_rotate(ulc, 180)
    dlc <- bm_rotate(ulc, 270)

    ulc1 <- ulc
    ulc1[8:9, 10:16] <- 1L
    urc1 <- bm_rotate(ulc1,  90)
    drc1 <- bm_rotate(ulc1, 180)
    dlc1 <- bm_rotate(ulc1, 270)

    ulc1. <- ulc
    ulc1.[1:7, 8:9] <- 1L
    urc1. <- bm_rotate(ulc1.,  90)
    drc1. <- bm_rotate(ulc1., 180)
    dlc1. <- bm_rotate(ulc1., 270)

    ulc3 <- bm_overlay(ulc1, ulc1.)
    urc3 <- bm_rotate(ulc3,  90)
    drc3 <- bm_rotate(ulc3, 180)
    dlc3 <- bm_rotate(ulc3, 270)

    # 2 black x (4 + 4 + 4 + 4 + 2)
    lh <- empty
    lh[, c(1:6, 8:9)] <- 1L
    uh <- bm_rotate(lh,  90)
    rh <- bm_rotate(lh, 180)
    dh <- bm_rotate(lh, 270)

    lh2 <- lh
    lh2[8:9, 9:16] <- 1L
    uh2 <- bm_rotate(lh2,  90)
    rh2 <- bm_rotate(lh2, 180)
    dh2 <- bm_rotate(lh2, 270)

    lhc <- lh
    lhc[c(7, 10), 1:7] <- 0L
    lhc[8:9, 1:8] <- 1L
    uhc <- bm_rotate(lhc,  90)
    rhc <- bm_rotate(lhc, 180)
    dhc <- bm_rotate(lhc, 270)

    lhc2 <- lhc
    lhc2[8:9, 9:16] <- 1L
    uhc2 <- bm_rotate(lhc2,  90)
    rhc2 <- bm_rotate(lhc2, 180)
    dhc2 <- bm_rotate(lhc2, 270)

    dc <- bm_overlay(ulc, drc)
    oc <- bm_rotate(dc, 90)

    # 3 black x (4 + 4 + 4)
    ulc_i <- !empty
    ulc_i[10:16, 1:7] <- 0L
    ulc_i[7, 1:10] <- 0L
    ulc_i[7:16, 10] <- 0L
    ulc_i <- bm_flip(ulc_i, "b")
    urc_i <- bm_rotate(ulc_i,  90)
    drc_i <- bm_rotate(ulc_i, 180)
    dlc_i <- bm_rotate(ulc_i, 270)

    lhurc <- bm_overlay(lh, urc)
    uhdrc <- bm_rotate(lhurc,  90)
    rhdlc <- bm_rotate(lhurc, 180)
    dhulc <- bm_rotate(lhurc, 270)

    lhdrc <- bm_flip(lhurc, "v") |> bm_rotate(90)
    uhdlc <- bm_rotate(lhdrc,  90)
    rhulc <- bm_rotate(lhdrc, 180)
    dhurc <- bm_rotate(lhdrc, 270)

    lhcurc <- bm_overlay(lhc, urc)
    uhcdrc <- bm_rotate(lhcurc,  90)
    rhcdlc <- bm_rotate(lhcurc, 180)
    dhculc <- bm_rotate(lhcurc, 270)

    # 4 black x (2 + 4 + 1)
    lhrh <- bm_overlay(lh, rh)
    uhdh <- bm_rotate(lhrh, 90)

    iulc_i <- ulc
    iulc_i[1:6, ] <- 1L
    iulc_i[, 11:16] <- 1L
    iurc_i <- bm_rotate(iulc_i,  90)
    idrc_i <- bm_rotate(iulc_i, 180)
    idlc_i <- bm_rotate(iulc_i, 270)

    lhrhc <- bm_overlay(lh, rhc)
    uhdhc <- bm_rotate(lhrhc,  90)
    rhlhc <- bm_rotate(lhrhc, 180)
    uhuhc <- bm_rotate(lhrhc, 270)

    ac <- bm_overlay(dc, oc)

    # inverted heavy

    # one heavy line
    ihh <- !box_drawing[["U+2501"]]
    ivh <- bm_rotate(ihh, 90)

    # one heavy line one light line
    ilhh <- ihh
    ilhh[, c(7, 10:16)] <- 0L
    ilhh[, 8:9] <- 1L
    iuhh <- bm_rotate(ilhh,  90)
    irhh <- bm_rotate(ilhh, 180)
    idhh <- bm_rotate(ilhh, 270)

    lhhi <- ilhh
    lhhi[, 11:16] <- !lhhi[, 11:16]
    lhhi[, 1:7] <- !lhhi[, 1:7]
    uhhi <- bm_rotate(lhhi,  90)
    rhhi <- bm_rotate(lhhi, 180)
    dhhi <- bm_rotate(lhhi, 270)

    ilhhi <- ilhh
    ilhhi[, 11:16] <- 1L
    iuhhi <- bm_rotate(ilhhi,  90)
    irhhi <- bm_rotate(ilhhi, 180)
    idhhi <- bm_rotate(ilhhi, 270)

    # one heavy line two light line
    ihhur <- ihh
    ihhur[8:10, 8:16] <- 1L
    ihhur[10:16, 10:16] <- 0L
    ihhur[8:16, 8:9] <- 1L
    ihhur[1:7, 7:10] <- 1L
    ihhur[8:16, 7] <- 0L
    ihhur[7, 1:16] <- 0L
    ivhdr <- bm_rotate(ihhur,  90)
    ihhdl <- bm_rotate(ihhur, 180)
    ivhdr <- bm_rotate(ihhur, 270)

    ihhdr <- bm_flip(ihhur, "v")
    ivhdl <- bm_rotate(ihhdr,  90)
    ihhul <- bm_rotate(ihhdr, 180)
    ivhur <- bm_rotate(ihhdr, 270)

    hhuri <- box_drawing[["U+2535"]]
    hhuri[11:16, 11:16] <- 1L
    vhdri <- bm_rotate(hhuri,  90)
    hhdli <- bm_rotate(hhuri, 180)
    vhdri <- bm_rotate(hhuri, 270)

    hhdri <- bm_flip(hhuri, "v")
    vhdli <- bm_rotate(hhdri,  90)
    hhuli <- bm_rotate(hhdri, 180)
    vhuri <- bm_rotate(hhdri, 270)

    ihhuri <- ihhur
    ihhuri[11:16, 11:16] <- 1L
    ivhdri <- bm_rotate(ihhuri,  90)
    ihhdli <- bm_rotate(ihhuri, 180)
    ivhdri <- bm_rotate(ihhuri, 270)

    ihhdri <- bm_flip(ihhuri, "v")
    ivhdli <- bm_rotate(ihhdri,  90)
    ihhuli <- bm_rotate(ihhdri, 180)
    ivhuri <- bm_rotate(ihhdri, 270)

    # one heavy line three light lines
    ihl3l <- box_drawing[["U+253D"]]
    ihl3l[, 1:7] <- !ihl3l[, 1:7]
    ihl3l[, 7] <- 0L
    ihu3l <- bm_rotate(ihl3l,  90)
    ihr3l <- bm_rotate(ihl3l, 180)
    ihd3l <- bm_rotate(ihl3l, 270)

    hl3l.uri <- box_drawing[["U+253D"]]
    hl3l.uri[11:16, 11:16] <- 1L
    hu3l.dri <- bm_rotate(hl3l.uri,  90)
    hr3l.dli <- bm_rotate(hl3l.uri, 180)
    hd3l.uli <- bm_rotate(hl3l.uri, 270)

    hl3l.dri <- box_drawing[["U+253D"]]
    hl3l.dri[1:6, 11:16] <- 1L
    hu3l.dli <- bm_rotate(hl3l.dri,  90)
    hr3l.uli <- bm_rotate(hl3l.dri, 180)
    hd3l.uri <- bm_rotate(hl3l.dri, 270)

    ihl3l.uri <- ihl3l
    ihl3l.uri[11:16, 11:16] <- 1L
    ihu3l.dri <- bm_rotate(ihl3l.uri,  90)
    ihr3l.dli <- bm_rotate(ihl3l.uri, 180)
    ihd3l.uli <- bm_rotate(ihl3l.uri, 270)

    ihl3l.dri <- ihl3l
    ihl3l.dri[1:6, 11:16] <- 1L
    ihu3l.dli <- bm_rotate(ihl3l.dri,  90)
    ihr3l.uli <- bm_rotate(ihl3l.dri, 180)
    ihd3l.uri <- bm_rotate(ihl3l.dri, 270)

    hl3li <- box_drawing[["U+253D"]]
    hl3li[11:16, 11:16] <- 1L
    hl3li[1:6, 11:16] <- 1L
    hu3li <- bm_rotate(hl3li,  90)
    hr3li <- bm_rotate(hl3li, 180)
    hd3li <- bm_rotate(hl3li, 270)

    ihl3li <- hl3li
    ihl3li[, 1:7] <- !ihl3li[, 1:7]
    ihl3li[, 7] <- 0L
    ihu3li <- bm_rotate(ihl3li,  90)
    ihr3li <- bm_rotate(ihl3li, 180)
    ihd3li <- bm_rotate(ihl3li, 270)

    # two heavy lines
    ihvh <- !box_drawing[["U+254B"]]

    # intersecting heavy lines
    ihx.ur <- !box_drawing[["U+2543"]]
    ihx.ur[1:7, 10:16] <- 0L
    ihx.ur[8:9, 8:16] <- 1L
    ihx.ur[1:9, 8:9] <- 1L
    ihx.ur[10, 7:16] <- 0L
    ihx.ur[1:10, 7] <- 0L
    ihx.dr <- bm_rotate(ihx.ur,  90)
    ihx.dl <- bm_rotate(ihx.ur, 180)
    ihx.ul <- bm_rotate(ihx.ur, 270)

    hx.uri <- box_drawing[["U+2543"]]
    hx.uri[1:6, 11:16] <- 1L
    hx.uri[7, 10] <- 0L
    hx.dri <- bm_rotate(hx.uri,  90)
    hx.dli <- bm_rotate(hx.uri, 180)
    hx.uli <- bm_rotate(hx.uri, 270)

    ihx.uri <- ihx.ur
    ihx.uri[1:6, 11:16] <- 1L
    ihx.dri <- bm_rotate(ihx.uri,  90)
    ihx.dli <- bm_rotate(ihx.uri, 180)
    ihx.uli <- bm_rotate(ihx.uri, 270)

    bml <- bm_list(
                   # inverted light line corner/half combos
                   ulc, urc, drc, dlc,
                   ulc1, urc1, drc1, dlc1,
                   ulc1., urc1., drc1., dlc1.,
                   ulc3, urc3, drc3, dlc3,
                   lh, uh, rh, dh,
                   lh2, uh2, rh2, dh2,
                   lhc, uhc, rhc, dhc,
                   lhc2, uhc2, rhc2, dhc2,
                   dc, oc,

                   ulc_i, urc_i, drc_i, dlc_i,
                   lhurc, uhdrc, rhdlc, dhulc,
                   lhdrc, uhdlc, rhulc, dhurc,
                   lhcurc, uhcdrc, rhcdlc, dhculc,
                   lhrh, uhdh,
                   iulc_i, iurc_i, idrc_i, idlc_i,
                   lhrhc, uhdhc, rhlhc, uhuhc,
                   ac,

                   # heavy lines
                   ihh, ivh, ihvh,

                   ilhh, iuhh, irhh, idhh,
                   ilhhi, iuhhi, irhhi, idhhi,
                   lhhi, uhhi, rhhi, dhhi,

                   ihhur, ivhdr, ihhdl, ivhdr,
                   ihhdr, ivhdl, ihhul, ivhur,
                   hhuri, vhdri, hhdli, vhdri,

                   hhdri, vhdli, hhuli, vhuri,
                   ihhuri, ivhdri, ihhdli, ivhdri,
                   ihhdri, ivhdli, ihhuli, ivhuri,

                   # one heavy line three light lines
                   ihl3l, ihu3l, ihr3l, ihd3l,
                   hl3l.uri, hu3l.dri, hr3l.dli, hd3l.uli,
                   hl3l.dri, hu3l.dli, hr3l.uli, hd3l.uri,
                   ihl3l.uri, ihu3l.dri, ihr3l.dli, ihd3l.uli,
                   ihl3l.dri, ihu3l.dli, ihr3l.uli, ihd3l.uri,
                   hl3li, hu3li, hr3li, hd3li,
                   ihl3li, ihu3li, ihr3li, ihd3li,
                   ihx.ur, ihx.dr, ihx.dl, ihx.ul,
                   hx.uri, hx.dri, hx.dli, hx.uli,
                   ihx.uri, ihx.dri, ihx.dli, ihx.uli,

                   # matted heavy
                   vlalmh, umhahl, vlarmh, dmhahl,
                   lmharvl, umhadhl, rmhalvl, dmhauhl,
                   vllmharh, umhdhahl, vllharmh, uhdmhahl,
                   vlahmh, vmhahl,

                   # inverted matted heavy combinations
                   vlalimh, uimhahl, vlarimh, dimhahl,
                   vilalmh, umhahil, vilarmh, dmhahil,
                   vrlalimh, uimhahdl, vllarimh, dimhahul,
                   lmhin, umhin, rmhin, dmhin,
                   limhin, uimhin, rimhin, dimhin,
                   lmhni, umhni, rmhni, dmhni,
                   limhni, uimhni, rimhni, dimhni,
                   vlrhalimh, uimhdhahl, vllharimh, dimhuhahl,
                   himhvl, hlvimh
                   )

    ucp_start <- as.hexmode("FDD00")
    ucp_end <- ucp_start + length(bml) - 1L

    names(bml) <- int2ucp(ucp_start:ucp_end)
    bml
}
