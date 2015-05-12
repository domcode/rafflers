Elm Raffler
===========

Install Elm
-----------

Go to ``http://elm-lang.org/Install.elm`` to install Elm.

Update Names.elm
----------------

Elm has no built-in functionality to read text files, so the names are defined in the Names module.

You can import a list of names by running ``./import_names.sh``.

Run the Raffler using make
--------------------------

Run ``elm make Raffler.elm --output Raffler.html`` to make the Raffler. Open ``Raffler.html`` in your browser.

Run the Raffler using reactor
-----------------------------

Run ``elm reactor``. Open ``http://localhost:8000/`` in your browser and click ``Raffler.elm``.

Do the Raffle
-------------

If you run the raffle, you'll see all of the names flashing on the screen very quickly. Press space to stop the raffle, and you'll have a winner!

