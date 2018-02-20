include ! "vendor/scato/glitch/lib/stdlib.g";

main += args => {
    rem ! "shuffle the names in the file";
    * shuffled, names;
    shuffle ! (names, shuffled);
    file ! (args, names);

    rem ! "the first candidate wins";
    * candidates;
    take ! (candidates, "1", println);
    shuffled ! candidates;
};

