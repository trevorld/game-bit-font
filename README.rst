Game Bit Font
=============

.. image:: https://www.repostatus.org/badges/latest/wip.svg
   :alt: Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.
   :target: https://www.repostatus.org/#wip

**Warning:** This project is a **Work In Progress**.

This project provides a fixed-width  `bitmap <https://en.wikipedia.org/wiki/Computer_font#BITMAP>`_ font specialized for making board game diagrams.  The `duospaced <https://en.wikipedia.org/wiki/Duospaced_font>`_ version is called **Game Bit Duo** while the square `monospaced <https://en.wikipedia.org/wiki/Monospaced_font>`_ version is called **Game Bit Mono**.

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

PDF documentation
~~~~~~~~~~~~~~~~~

* `game-bit-code-charts.pdf <https://trevorldavis.com/share/fonts/game-bit-code-charts.pdf>`_
* `game-bit-private-use-area.pdf <https://trevorldavis.com/share/fonts/game-bit-private-use-area.pdf>`_

Features
---------

**Game Bit Duo** has the following features:

* A fixed-width `duospaced font <https://en.wikipedia.org/wiki/Duospaced_font>`__.
* "Fullwidth" Characters intended for use in diagrams are square whereas some blocks such as *Basic Latin* are "halfwidth" to better support text rendering.
* Has support for several public domain game systems both in Unicode proper and its Private Use Area.  In particular in its Private Use Area has the important piecepack rank/suit symbols including support for all rotated versions of the glyphs. These symbols must still look nice when combined with various combining/enclosing marks to create piecepack coins, dice, and pawns.
* Supports all *Box Drawing* and *Block Elements* characters. These combine well with the game bits so it looks like those pieces are truly on top of the tiles (i.e. no lines going through the "edge" of piecepack coins, dice, pawns or awkward gaps between lines and piece "edges").  Includes additional box-drawing characters in its Private Use Area.

**Game Bit Mono** is the same as **Game Bit Duo** except **all** characters are square.

Supported game systems
----------------------

The font will aim to support making diagrams for every game system supported by the R function `ppgames::cat_piece() <https://trevorldavis.com/R/ppgames/dev/reference/cat_piece.html>`_ which generates Unicode plaintext game diagrams:

Checkers
~~~~~~~~

+ U+26C0 through U+26C3 are "standard" checkers/draughts pieces.
+ As an alternative U+25CF is "black circle" and U+25CB" is "white circle"
  while U+24C0 and U+1F15A are circled uppercase K's.

Chess
~~~~~

+ U+2654 through U+265F are "standard" chess pieces
+ *Chess Symbols* block has Xiangqi and "fairy" chess pieces

Dice
~~~~

+ U+2680 through U+2685 are "standard" die faces
+ Can use U+20DE "Combining Enclosing Square" to make non-standard die faces
+ Additional (especially piecepack) dice support available in the Private Use Area.

Dominoes
~~~~~~~~

+ "Domino Tiles" block is included but not recommended for diagrams.
  Instead make 3x5 or 5x3 glyph dominoes.  
  Adjacent dominoes will share "Box Drawing" outline glyphs.
+ Includes "Private Use Area" glyphs for 0-9 pips.

  .. image:: png/dominoes_mono.png

Go
~~

+ U+25CF is "black circle" and U+25CB" is "white circle"
+ U+2686 through U+2689 are "Go markers"
+ Several circled numbers and letters in "Dingbats", "Enclosed Alphanumerics",
  and "Enclosed Alphanumeric Supplement" blocks that can be used for annotation.

  .. image:: png/go_mono.png

Piecepack
~~~~~~~~~

+ Several Private Use Area blocks of piecepack suits, ranks, and combining characters:

  - black/white piecepack suits, black/white french suits, four seasons suits and twelve piecepack ranks in big/small sizes
  - combining directional marks and enclosing pieces
  - supports normal/inverted pieces in four rotations
  - supports large/small components (i.e. a `piecepack stackpack <https://www.ludism.org/ppwiki/StackPack>`__).

  .. image:: png/piecepack-backgammon_duo.png
      :width: 90%
      :alt: Backgammon setup with a piecepack

  .. image:: png/piecepack-four-seasons-chess_mono.png
      :alt: Four seasons chess setup with a piecepack

  .. image:: png/piecepack-xiangqi_duo.png
      :alt: Xiangqi setup with a piecepack

Miscellaneous abstracts
~~~~~~~~~~~~~~~~~~~~~~~

+ Can use any of the above game pieces.
+ "Geometric Shapes" block has a variety of shapes that can be also be used for abstracts.

To re-build fonts/documentation from scratch
--------------------------------------------

In a (i.e. bash) shell::

    rake

Build dependencies
~~~~~~~~~~~~~~~~~~

* `R <https://cran.r-project.org/>`_

  * Within R install R package dependencies::

      install.packages(c("bracer", "glue", "remotes", "targets", "tibble", "withr"))
      remotes::install_github("trevorld/bittermelon")
      remotes::install_github("trevorld/hexfont")
      remotes::install_github("piecepackr/ppgames")

* `Perl <https://www.perl.org/>`_

  + Install the following modules with tools such as ``cpan``:

    - ``GD``

      + May need to install ``libgd-dev``

* `FontForge <https://fontforge.org/en-US/>`__
* `Rake <https://ruby.github.io/rake/>`__
* `Xetex <https://tug.org/xetex/>`__
* `Docutils <https://docutils.sourceforge.io/>`__

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
