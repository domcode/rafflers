PHP7 raffle Extension
---------------------

Not well designed nor tested. Should be easy enough to make it compatible with PHP5.

Compile with (php7):

     phpize
     ./configure
     make

Enable in your php.ini and run test.php



Suppasecret cheat mode
----------------------

Configure with:

     ./configure --with-domcode-cheat="John doe"

which will always return the name "John doe" during raffling.
