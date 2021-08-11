Game Bit Mono
=============

.. image:: https://www.repostatus.org/badges/latest/concept.svg
   :alt: Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.
   :target: https://www.repostatus.org/#concept

**Warning:** This project is at the **concept** level.  Little implementation has been done yet.

The goal of this project will be to create a `monospaced <https://en.wikipedia.org/wiki/Monospaced_font>`_ `bitmap <https://en.wikipedia.org/wiki/Computer_font#BITMAP>`_ font specialized for making board game diagrams.

.. contents::

Intended Features
-----------------

`My wishlist for a font that does not seem to exist yet <http://trevorldavis.com/piecepackr/unicode-piecepack-diagrams.html#piecepack-font-wishlist>`_:  

* A monoscale font.
* Characters intended for use in diagrams will generally be square (aka "fullwidth").

  * Some blocks such as Basic Latin will be "halfwidth" to better support text rendering.

* Needs to have the important piecepack rank/suit Unicode symbols including support for all rotated versions of the glyphs. These symbols must still look nice when combining with Combining Diacritical Marks used as directional marks plus an enclosing circle, square, diamond, and/or triangle. 
* Would also be nice to include the relevant "rotated" Unicode 12.0 chess piece glyphs (useful as piecapack Crowns and pawns).
* Needs support for all the thin/thick box-drawing characters. These should combine well with the piecepack coins, dice, and pawns (i.e. enclosing circles, squares, etc.) so it looks like those pieces are truly on top of the tiles (so no lines going through the "edge" of the coins, dice, pawns or awkward gaps between lines and piece "edges").

Target game systems
-------------------

The font will aim to support making diagrams for every game system supported by the R function `ppgames::cat_piece() <https://trevorldavis.com/R/ppgames/dev/reference/cat_piece.html>`_ which generates Unicode plaintext game diagrams:

* [ ] `checkers <https://en.wikipedia.org/wiki/English_draughts>`_
* [ ] `chess <https://en.wikipedia.org/wiki/Chess>`_
* [ ] `dice <https://en.wikipedia.org/wiki/Dice>`_ (standard six-sided)
* [ ] `dominoes <https://en.wikipedia.org/wiki/Dominoes>`_
* [ ] `go <https://en.wikipedia.org/wiki/Go_(game)>`_
* [ ] `Icehouse pieces <https://en.wikipedia.org/wiki/Icehouse_pieces>`_
* [ ] `piecepack <https://www.ludism.org/ppwiki>`_

  + [ ] playing cards expansion
  + [ ] dual piecepacks expansion
  + [ ] four seasons expansion?
  + [ ] elements expansion?
  + [ ] stackpack subpack?
  + [ ] piecepack matchsticks?
  + [ ] piecepack pyramids?

* [ ] others?

Font Coverage
-------------

8x16 "Halfwidth"
~~~~~~~~~~~~~~~~

* `Basic Latin <https://en.wikipedia.org/wiki/Basic_Latin_(Unicode_block)>`_

  + `View png of glyphs <png/00.png>`__
  + All non-control code points

16x16 "Fullwidth"
~~~~~~~~~~~~~~~~~

* `Block Elements <https://en.wikipedia.org/wiki/Block_Elements>`_

  + `View png of glyphs <png/25.png>`__
  + All code points.
  + Note you'll need to use the fullwidth "Ideographic Space" U+3000 
    instead of a normal "Space" U+0020 when building block element diagrams.

* `CJK Symbols and Punctuation <https://en.wikipedia.org/wiki/CJK_Symbols_and_Punctuation>`_

  + `View png of glyphs <png/30.png>`__
  + U+3000 "Ideographic Space" is the fullwidth space.
  + U+302E "Hangul Single Dot Tone Mark" is only combining left dot.
  + U+302F "Hangul Double Dot Tone Mark" is only combining left double dot.

* `Halfwidth and Fullwidth Forms <https://en.wikipedia.org/wiki/Halfwidth_and_Fullwidth_Forms_(Unicode_block)>`_

  + `View png of glyphs <png/FF.png>`__
  + Just the fullwidth versions of the ASCII characters.

* `Chess Symbols <https://en.wikipedia.org/wiki/Chess_Symbols>`_

  + `View png of glyphs <png/1FA.png>`__
  + All code points.
  + Note this block is just "fairy" chess pieces and Xiangqi pieces

Roadmap
-------

* [X] `Basic Latin <https://en.wikipedia.org/wiki/Basic_Latin_(Unicode_block)>`_

  + Include Other common scripts?
  + [X] `Halfwidth and Fullwidth Forms <https://en.wikipedia.org/wiki/Halfwidth_and_Fullwidth_Forms_(Unicode_block)>`_?

    - Just the Latin and Punctuation

  + [ ] Superscripts and Subscripts?

* [ ] `Box Drawing <https://en.wikipedia.org/wiki/Box_Drawing_(Unicode_block)>`_
* [X] `Block Elements <https://en.wikipedia.org/wiki/Block_Elements>`_

* [ ] `Combining Diacritical Marks <https://en.wikipedia.org/wiki/Combining_Diacritical_Marks>`_
  
  + [ ] Piecepack directional marks
  + [ ] Pips for Dominoes and Icehouse pieces

* [ ] `Combining Diacritical Marks for Symbols <https://en.wikipedia.org/wiki/Combining_Diacritical_Marks_for_Symbols>`_

  + [ ] Combining circle, square, diamond for piecepack pieces
  + [ ] Perhaps some of the combining dots for pips

* [ ] `Miscellaneous Symbols <https://en.wikipedia.org/wiki/Miscellaneous_Symbols>`_

  + [ ] Basic chess pieces
  + [ ] Checkers
  + [ ] Dice
  + [ ] Go
  + [ ] Piecepack/French Suits
  
* [X] `Chess Symbols <https://en.wikipedia.org/wiki/Chess_Symbols>`_

  + Note this block is just "fairy" chess pieces and Xiangqi pieces

* [ ] `Geometric Shapes <https://en.wikipedia.org/wiki/Geometric_Shapes>`_

  + [ ] Triangles and squares for Icehouse pieces
  + More symbols for generic abstracts?
  + More shapes in

    - `Miscellaneous Symbols and Pictographs <https://en.wikipedia.org/wiki/Miscellaneous_Symbols_and_Pictographs>`_
    - `Geometric Shapes Extended <https://en.wikipedia.org/wiki/Geometric_Shapes_Extended>`_
    - `Miscellaneous Symbols and Arrows <https://en.wikipedia.org/wiki/Miscellaneous_Symbols_and_Arrows>`_

* Various Enclosed Alphanumerics for Go annotation?

  + [ ] `Dingbats <https://en.wikipedia.org/wiki/Dingbat#Unicode>`_
  + [ ] `Enclosed Alphanumerics <https://en.wikipedia.org/wiki/Enclosed_Alphanumerics>`_
  + [ ] `Enclosed CJK Letters and Months <https://en.wikipedia.org/wiki/Enclosed_CJK_Letters_and_Months>`_
  + [ ] `Enclosed Alphanumeric Supplement <https://en.wikipedia.org/wiki/Enclosed_Alphanumeric_Supplement>`_

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


Build dependencies
------------------

* `R <https://cran.r-project.org/>`_

  * Within R install R package dependencies::

      install.packages(c("remotes", "targets"))
      remotes::install_github("trevorld/bittermelon")
      remotes::install_github("trevorld/hexfont")

* `Perl <https://www.perl.org/>`_

  + Install the following modules with tools such as `cpan`:

    - `GD`

      + May need to install `libgd-dev`

Build output from scratch
-------------------------

In R_::

    targets::tar_make()


Target build chain
------------------

* Write R code to generate 16x16 glyphs using `{bittermelon} <https://trevorld/bittermelon>`_ and `{hexfont} <https://trevorld/hexfont>`_ and save as "hex" font file
* Use/adapt GNU Unifont scripts to generate other font formats from "hex" font file

  * "bdf" via `hex2bdf`
  * "ttf" via a more complicated chain involving `FontForge <https://fontforge.org/en-US/>`_
