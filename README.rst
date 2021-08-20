Game Bit Font
=============

.. image:: https://www.repostatus.org/badges/latest/wip.svg
   :alt: Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.
   :target: https://www.repostatus.org/#wip

**Warning:** This project is a **Work In Progress**.

The goal of this project is to create a fixed-width  `bitmap <https://en.wikipedia.org/wiki/Computer_font#BITMAP>`_ font specialized for making board game diagrams.  The `duospaced <https://en.wikipedia.org/wiki/Duospaced_font>`_ version is called **Game Bit Duo** while the square `monospaced <https://en.wikipedia.org/wiki/Monospaced_font>`_ version is called **Game Bit Mono**.

.. contents::

Font Files
----------

Game Bit Duo
~~~~~~~~~~~~

* `game-bit-duo.bdf <https://raw.githubusercontent.com/trevorld/game-bit-duo/main/game-bit-duo.bdf>`_
* `game-bit-duo.hex <https://raw.githubusercontent.com/trevorld/game-bit-duo/main/game-bit-duo.hex>`_
* `game-bit-duo.ttf <https://trevorldavis.com/share/fonts/game-bit-duo.ttf>`_

Game Bit Mono
~~~~~~~~~~~~~

* `game-bit-mono.bdf <https://raw.githubusercontent.com/trevorld/game-bit-mono/main/game-bit-mono.bdf>`_
* `game-bit-mono.hex <https://raw.githubusercontent.com/trevorld/game-bit-mono/main/game-bit-mono.hex>`_
* `game-bit-mono.ttf <https://trevorldavis.com/share/fonts/game-bit-mono.ttf>`_

Intended Features
-----------------

`My wishlist for a font that does not seem to exist yet <http://trevorldavis.com/piecepackr/unicode-piecepack-diagrams.html#piecepack-font-wishlist>`_:  

* A fixed-width duospaced font.
* Characters intended for use in diagrams will generally be square (aka "fullwidth").

  * Some blocks such as Basic Latin will be "halfwidth" to better support text rendering.

* Needs to have the important piecepack rank/suit Unicode symbols including support for all rotated versions of the glyphs. These symbols must still look nice when combining with Combining Diacritical Marks used as directional marks plus an enclosing circle, square, diamond, and/or triangle. 
* Would also be nice to include the relevant "rotated" Unicode 12.0 chess piece glyphs (useful as piecepack Crowns and pawns).
* Needs support for all the thin/thick box-drawing characters. These should combine well with the piecepack coins, dice, and pawns (i.e. enclosing circles, squares, etc.) so it looks like those pieces are truly on top of the tiles (so no lines going through the "edge" of the coins, dice, pawns or awkward gaps between lines and piece "edges").

Target game systems
-------------------

The font will aim to support making diagrams for every game system supported by the R function `ppgames::cat_piece() <https://trevorldavis.com/R/ppgames/dev/reference/cat_piece.html>`_ which generates Unicode plaintext game diagrams:

* [X] `checkers <https://en.wikipedia.org/wiki/English_draughts>`_

  + U+26C0 through U+26C3 are "standard" checkers/draughts pieces.
  + As an alternative U+25CF is "black circle" and U+25CB" is "white circle"
    while U+24C0 and U+1F15A are circled uppercase K's.

* [X] `chess <https://en.wikipedia.org/wiki/Chess>`_

  + U+2654 through U+265F are "standard" chess pieces
  + "Chess Symbols" block has Xiangqi and "fairy" chess pieces

* [X] `dice <https://en.wikipedia.org/wiki/Dice>`_

  + U+2680 through U+2685 are "standard" die faces
  + Can use U+20DE "Combining Enclosing Square" to make non-standard die faces

* [X] `dominoes <https://en.wikipedia.org/wiki/Dominoes>`_

  + "Domino Tiles" block is included but not recommended for diagrams.
    Instead make 3x5 or 5x3 glyph dominoes.  
    Adjacent dominoes will share "Box Drawing" outline glyphs.
    Use the following "Private Use Area" glyphs for pips:

    - 0 Pips: U+FCA00
    - 1 Pip:  U+FCA01
    - 2 Pips: U+FCA02 / U+FCA12
    - 3 Pips: U+FCA03 / U+FCA13
    - 4 Pips: U+FCA04
    - 5 Pips: U+FCA05
    - 6 Pips: U+FCA06 / U+FCA16
    - 7 Pips: U+FCA07 / U+FCA17
    - 8 Pips: U+FCA08
    - 9 Pips: U+FCA09

    .. image:: png/dominoes_mono.png

* [X] `go <https://en.wikipedia.org/wiki/Go_(game)>`_

  + U+25CF is "black circle" and U+25CB" is "white circle"
  + U+2686 through U+2689 are "Go markers"
  + Several circled numbers and letters in "Dingbats", "Enclosed Alphanumerics",
    and "Enclosed Alphanumeric Supplement" blocks that can be used for annotation.

    .. image:: png/go_mono.png

* [X] `Icehouse pieces <https://en.wikipedia.org/wiki/Icehouse_pieces>`_

  + One may crudely refer to Icehouse pieces by using smaller squares and triangles from "Geometric Shapes" block
    plus using a combining 1/2/3 dots beneath.

    + Square indicates standing pyramid.
    + Triangle laid down pyramid, where it points is where the pyramid points.
    + Number of dots beneath indicate number of pips on the pyramid.
    + This is enough to visualize certain abstracts like `Martian Chess <https://www.looneylabs.com/rules/martian-chess>`__ and `Pikemen <https://www.icehousegames.org/wiki/index.php?title=Pikemen>`__ but not enough to visualize games where you stack pyramids on one another.

* [ ] `piecepack <https://www.ludism.org/ppwiki>`_

  + [ ] playing cards expansion
  + [ ] dual piecepacks expansion
  + [ ] four seasons expansion?
  + [ ] elements expansion?
  + [ ] stackpack subpack?
  + [ ] piecepack matchsticks?
  + [ ] piecepack pyramids?

* [X] miscellaneous abstracts

  + Can use any of the above game pieces
  + "Geometric Shapes" block has a variety of shapes that can be used for abstracts

* [ ] others?

Font Coverage
-------------

8x16 "Halfwidth"
~~~~~~~~~~~~~~~~

In **Game Bit Duo** these are halfwidth and intended for writing text.  In **Game Bit Mono** they are padded with extra horizontal whitespace to force them into a square shape and hence are not great for writing text.:

* `Basic Latin <https://en.wikipedia.org/wiki/Basic_Latin_(Unicode_block)>`_ and `Latin-1 Supplement <https://en.wikipedia.org/wiki/Latin-1_Supplement_(Unicode_block)>`_

  + `View png of glyphs <png/00.png>`__
  + All non-control code points.

* `Latin Extended-A <https://en.wikipedia.org/wiki/Latin_Extended-A>`__

  + `View png of glyphs <png/01.png>`__
  + All code points.

* `Superscripts and Subscripts <https://en.wikipedia.org/wiki/Superscripts_and_Subscripts_(Unicode_block)>`_

  + `View png of glyphs <png/20.png>`__
  + All code points.

* `Domino Tiles <https://en.wikipedia.org/wiki/Domino_Tiles>`_

  + `View png of glyphs <png/1F0.png>`__
  + All code points but horizontal dominoes are actually fullwidth

16x16 "Fullwidth"
~~~~~~~~~~~~~~~~~

Intended for making game diagrams:

* `Combining Diacritical Marks <https://en.wikipedia.org/wiki/Combining_Diacritical_Marks>`_

  + `View png of glyphs <png/03.png>`__
  + 5 combining dot code points

* `Combining Diacritical Marks Supplement <https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_Supplement>`__

  + `View png of glyphs <png/1D.png>`__
  + 2 combining dot code points (1 proposed in the `Unicode Pipeline <https://unicode.org/alloc/Pipeline.html>`__)

* `General Punctuation <https://en.wikipedia.org/wiki/General_Punctuation>`_ and `Combining Diacritical Marks for Symbols <https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_for_Symbols>`_

  + `View png of glyphs <png/20.png>`__
  + 7 code points:

    - U+2059 "Five Dot Punctuation", U+20DB "Combining Three Dots Above", U+20E8 "Combining Triple Under Dot" for certain pips
    - U+20DE "Combining Enclosing Square" can be used to make new dice (or tiles)
    - U+20DD "Combining Enclosing Circle" can be used to make new circular pieces
    - U+20DF "Combining Enclosing Diamonds" and U+20E4 "Combinin Enclosing Triangle" can be used to make new pieces

* `Mathematical Operators <https://en.wikipedia.org/wiki/Mathematical_Operators_(Unicode_block)>`_

  + `View png of glyphs <png/22.png>`__
  + 3 code points:

    - U+22EF, U+22F0, and U+22F1 are various ellipses used for pips

* `Enclosed Alphanumerics <https://en.wikipedia.org/wiki/Enclosed_Alphanumerics>`__

  + `View png of glyphs <png/24.png>`__
  + 64 code points:

    - 12 circled numbers
    - 26 circled uppercase letters 
    - 26 circled lowercase letters

* `Box Drawing <https://en.wikipedia.org/wiki/Box_Drawing_(Unicode_block)>`_, `Block Elements <https://en.wikipedia.org/wiki/Block_Elements>`_, and `Geometric Shapes <https://en.wikipedia.org/wiki/Geometric_Shapes>`__

  + `View png of glyphs <png/25.png>`__
  + All "Box Drawing" and "Block Elements" code points.
  + All code points in "Geometric Shapes"

    - Shapes can be used for various abstracts.
    - In particular use "Black Circle" and "White Circle" for go stones in diagrams.

* `Miscellaneous Symbols <https://en.wikipedia.org/wiki/Miscellaneous_Symbols>`_

  + `View png of glyphs <png/26.png>`__
  + 26 code points:

    - The six standard die faces.
    - The four "go markers".
    - The twelve basic chess ranks.
    - The four checkers/draughts pieces.

* `Dingbats <https://en.wikipedia.org/wiki/Dingbat#Unicode>`_

  + `View png of glyphs <png/27.png>`__
  + 30 code points:

    - The "Dingbat circled digits"

* `Braille Patterns <https://en.wikipedia.org/wiki/Braille_Patterns>`_

  + `View png of glyphs <png/28.png>`_
  + Just the (complete) 6-dot cell range.
  + Dots spaced to also represent 2/4/6 pips on a die or domino.

* `CJK Symbols and Punctuation <https://en.wikipedia.org/wiki/CJK_Symbols_and_Punctuation>`_ and `Katakana <https://en.wikipedia.org/wiki/Katakana>`__

  + `View png of glyphs <png/30.png>`__
  + Four code points:

    - U+3000 "Ideographic Space" is the proper fullwidth space.
    - U+302E "Hangul Single Dot Tone Mark" is only combining left dot.
    - U+302F "Hangul Double Dot Tone Mark" is only combining left double dots.
    - U+30FB "Katakana Middle Dot" is the fullwidth middle dot.

* `Halfwidth and Fullwidth Forms <https://en.wikipedia.org/wiki/Halfwidth_and_Fullwidth_Forms_(Unicode_block)>`_

  + `View png of glyphs <png/FF.png>`__
  + Just the fullwidth versions of the ASCII characters.

* `Musical Symbols <https://en.wikipedia.org/wiki/Musical_Symbols_(Unicode_block)>`_

  + `View png of glyphs <png/1D1.png>`__
  + One code point:

    - U+1D16D "Musical Symbol Combining Augmentation Dot" is only combining right dot.

* `Mahjong Tiles <https://en.wikipedia.org/wiki/Mahjong_Tiles_(Unicode_block)>`__, `Domino Tiles <https://en.wikipedia.org/wiki/Domino_Tiles>`_, and `Playing Cards <https://en.wikipedia.org/wiki/Playing_cards_in_Unicode>`__

  + `View png of glyphs <png/1F0.png>`__
  + All code points but vertical dominoes are actually halfwidth

* `Enclosed Alphanumeric Supplement <https://en.wikipedia.org/wiki/Enclosed_Alphanumeric_Supplement>`__

  + `View png of glyphs <png/1F1.png>`__
  + 80 code points:

    - 26 squared uppercase letters
    - 26 negative circled uppercase letters
    - 26 negative squared uppercase letters
    - 2 circled zeroes

* `Chess Symbols <https://en.wikipedia.org/wiki/Chess_Symbols>`_

  + `View png of glyphs <png/1FA.png>`__
  + All code points.
  + Note this block is just "fairy" chess pieces and Xiangqi pieces

* Private Use Area: Box Drawing Domino Suits

  + `View png of glyphs <png/FCA.png>`__
  + Domino suits from zero to nine in four rotations (top, right, bottom, left).
  + Intended for use making domino tile diagrams with box drawing glyphs 
    where each domino is represented by 3x5 (or 5x3) glyphs
    with adjacent dominoes sharing their "border" glyphs.

Roadmap
-------

* [X] `Basic Latin <https://en.wikipedia.org/wiki/Basic_Latin_(Unicode_block)>`_

  + [X] `Latin-1 Supplement <https://en.wikipedia.org/wiki/Latin-1_Supplement_(Unicode_block)>`_
  + [X] `Halfwidth and Fullwidth Forms <https://en.wikipedia.org/wiki/Halfwidth_and_Fullwidth_Forms_(Unicode_block)>`_?

    - Just the Latin and Punctuation.

  + [X] `Superscripts and Subscripts <https://en.wikipedia.org/wiki/Superscripts_and_Subscripts_(Unicode_block)>`__
  + Include Other common scripts?

* [X] `Box Drawing <https://en.wikipedia.org/wiki/Box_Drawing_(Unicode_block)>`_
* [X] `Block Elements <https://en.wikipedia.org/wiki/Block_Elements>`_

* [X] `Combining Diacritical Marks <https://en.wikipedia.org/wiki/Combining_Diacritical_Marks>`_
  
  + [X] Piecepack directional marks
  + [X] Pips for Dominoes and Icehouse pieces

* [X] `Combining Diacritical Marks for Symbols <https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_for_Symbols>`_

  + [X] Combining circle, square, diamond for piecepack pieces
  + [X] Perhaps some of the combining dots for pips

* [ ] `Miscellaneous Symbols <https://en.wikipedia.org/wiki/Miscellaneous_Symbols>`_

  + [X] Basic chess pieces
  + [X] Checkers
  + [X] Dice
  + [X] Go
  + [ ] Piecepack/French Suits
  
* [X] `Chess Symbols <https://en.wikipedia.org/wiki/Chess_Symbols>`_

  + Note this block is just "fairy" chess pieces and Xiangqi pieces

* [X] `Geometric Shapes <https://en.wikipedia.org/wiki/Geometric_Shapes>`_

  + [X] Triangles and squares for Icehouse pieces
  + More symbols for generic abstracts?
  + More shapes from other blocks?

    - `Miscellaneous Symbols and Pictographs <https://en.wikipedia.org/wiki/Miscellaneous_Symbols_and_Pictographs>`_
    - `Geometric Shapes Extended <https://en.wikipedia.org/wiki/Geometric_Shapes_Extended>`_
    - `Miscellaneous Symbols and Arrows <https://en.wikipedia.org/wiki/Miscellaneous_Symbols_and_Arrows>`_

* [X] Various Enclosed Alphanumerics for Go annotation?

  + [X] `Dingbats <https://en.wikipedia.org/wiki/Dingbat#Unicode>`_
  + [X] `Enclosed Alphanumerics <https://en.wikipedia.org/wiki/Enclosed_Alphanumerics>`_
  + [ ] `Enclosed CJK Letters and Months <https://en.wikipedia.org/wiki/Enclosed_CJK_Letters_and_Months>`_
  + [X] `Enclosed Alphanumeric Supplement <https://en.wikipedia.org/wiki/Enclosed_Alphanumeric_Supplement>`_

* Miscellaneous others

  + [ ] `Cham <https://en.wikipedia.org/wiki/Cham_(Unicode_block)>`_ Punctuation Spiral?

* Private Use Area

  + Game bits in the PUA of fonts like `Quivira <http://www.quivira-font.com/>`_ or `Catrinity <http://catrinity-font.de/>`_?
  + [ ] Pre-composed piecepack pieces

    - Where should they go in the PUA?
    - How many should be pre-composed?
    - Should also have slots for semantic stuff Unicode will probably never directly support like "Piecepack Null Rank"
      that would make it easier for other future piecepack fonts to offer more customized piecepack diagram appearances?
    - Should whip up a proposal and then post in piecepack forums soliciting feedback.

* `A list of glyphs used by ppgames::cat_piece() <https://github.com/piecepackr/ppgames/blob/master/raw-data/sysdata.R>`_
* `A list of Unicode piecepack symbols <https://trevorldavis.com/piecepackr/unicode-piecepack-symbols.html>`_

To build output from scratch
----------------------------

In R_::

    targets::tar_make()

Build dependencies
~~~~~~~~~~~~~~~~~~

* `R <https://cran.r-project.org/>`_

  * Within R install R package dependencies::

      install.packages(c("glue", "remotes", "targets"))
      remotes::install_github("trevorld/bittermelon")
      remotes::install_github("trevorld/hexfont")

* `Perl <https://www.perl.org/>`_

  + Install the following modules with tools such as ``cpan``:

    - ``GD``

      + May need to install ``libgd-dev``

* `FontForge <https://fontforge.org/en-US/>`__

GNU Unifont
-----------

* This font is a derivative of `GNU Unifont <http://unifoundry.com/unifont/index.html>`_.
* It includes a subset of glyphs from GNU Unifont.
* See `ChangeLog.rst <ChangeLog.rst>`_ for a list of differences between the glyphs in this font and GNU Unifont.
* It also adapts the bdf/ttf font build chains from GNU Unifont.

Related Fonts of Interest
-------------------------

* `Catrinity <http://catrinity-font.de/>`__ and `Nishiki-teki <https://umihotaru.work/>`_ are two sans-serif fonts with a bunch of game pieces in their Private Use Areas.
* `Kreative Square <http://www.kreativekorp.com/software/fonts/ksquare.shtml>`__ is a fullwidth scalable monospace font designed specifically to support pseudographics, semigraphics, and private use characters.
