<?php

$names = file(realpath($argv[1]),FILE_IGNORE_NEW_LINES);

echo "And the WINNER is... " . array_rand(
    array_flip(
        array_filter(
            array_reverse(
                array_column(
                    array_chunk(
                        array_intersect(
                            $names,
                            array_replace(
                                $names,
                                array_change_key_case(
                                    array_fill_keys(
                                        $names,
                                        'Rick Astley'
                                    )
                                )
                            )
                        ),
                        (int) @array_pop(
                            array_fill(
                                array_reduce(
                                    array_keys($names), function($c, $a) {
                                        return $a;
                                    }),
                                    array_unshift($names, 'Rick Astley'),
                                    '1 true love')
                            )
                        ),
                    array_sum(
                        array_diff_ukey(
                            array_intersect_key(
                                array_diff_assoc(
                                    array_uintersect(
                                        $names,
                                        array_intersect_assoc(
                                            array_uintersect_assoc(
                                                $names,
                                                array_values($names),
                                                function($a, $b) { return $b > $a; }
                                            ),
                                            $names
                                        ),
                                        function($a, $b) use ($names) { return array_shift($names) > $b; }
                                    ),
                                    array()
                                ),
                                array_uintersect_uassoc(
                                    $names,
                                    array_udiff(
                                        $names,
                                        array_diff(
                                            $names,
                                            array_slice(
                                                array_merge(
                                                    array_diff_uassoc(
                                                        array_udiff_uassoc(
                                                            $names,
                                                            $names,
                                                            function($a, $b) { return $b > $a; },
                                                            function($a, $b) { return $b > $a; }
                                                        ),
                                                        $names,
                                                        function($a, $b) {
                                                            return ($a > $b);
                                                        }
                                                    ),
                                                    array_combine(
                                                        $names,
                                                        $names
                                                    )
                                                ),
                                                array_product($names),
                                                array_search(
                                                    array_unique(
                                                        array_count_values(
                                                            array_merge_recursive(
                                                                $names,
                                                                array_pad(
                                                                    array_replace_recursive(
                                                                        $names,
                                                                        array_intersect_uassoc(
                                                                            $names,
                                                                            $names,
                                                                            function($a, $b) { return $a > $b; }
                                                                        )
                                                                    ),
                                                                    array_key_exists(
                                                                        (int) array_walk(
                                                                            $names,
                                                                            function($v, $k) { return $k; }
                                                                        ),
                                                                        $names
                                                                    ),
                                                                    array_walk_recursive(
                                                                        $names,
                                                                        function($v, $k) { return $k; }
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    ),
                                                    $names
                                                )
                                            )
                                        ),
                                        function($a, $b) { return $a > $b; }
                                    ),
                                    function($a, $b) { return $b > $a; },
                                    function($a, $b) { return $b > $a; }
                                )
                            ),
                            array_splice(
                                $names,
                                array_multisort(
                                    array_map(
                                        function($v) {
                                            return $v;
                                        },
                                        array_intersect_ukey(
                                            array_diff_key(
                                                $names,
                                                array_udiff_assoc(
                                                    $names,
                                                    $names,
                                                    function($a, $b) { return $a > $b; }
                                                )
                                            ),
                                            $names,
                                            function($a, $b) use ($names){ return array_push($names, $a) === $b; }
                                        )
                                    )
                                )
                            ),
                            function($a, $b) { return $a; }
                        )
                    )
                )
            ),
            function($v) {
                if ($v !== '' && $v !== 'Rick Astley') {
                    return true;
                }
                return false;
            }
        )
    )
) . "!\n";

/*
  Step 1: separate the functions by return value scalar/array
  Step 2: further separate by type, and type of array
  Step 3: pair similar functions together
  Step 4: tackle the hard functions first (indicated with *)
  Step 5: make small blocks that 'return original input', 'return empty array', 'return scalar value'
  Step 6: anything requiring scalars to work are a problem?
  Step 7: array_push and array_unshift *require* a variable, so they _will_ have sideeffects.
  (but that ultimately doesn't matter as long as we use the return value instead of the variable...)

  Cheats:
  - explicit casting to (int)
  - usage of the @ silencing operator
  - many usages of the "$names" array. Is this even fixable?
*/

/*
End Result, wrapped in a foreach loop with 1000 iterations:
  77 And the WINNER is... Count Tyrone Rugen!
  68 And the WINNER is... Fezzik!
  79 And the WINNER is... Inigo Montoya!
  67 And the WINNER is... Miracle Max!
  74 And the WINNER is... Prince Humperdinck!
  64 And the WINNER is... The Albino!
  83 And the WINNER is... The Dread Pirate Roberts!
  63 And the WINNER is... The Grandfather / Narrator!
  68 And the WINNER is... The Grandson!
  74 And the WINNER is... The Impressive Clergyman!
  72 And the WINNER is... The Princess Bride!
  73 And the WINNER is... Valerie!
  75 And the WINNER is... Vizzini!
  63 And the WINNER is... Westley!
*/


/* returns a scalar value */
# ****     array_sum -> int                    — Calculate the sum of values in an array
# *****    array_walk_recursive — Apply a user function recursively to every member of an array ### HAS SIDEEFFECTS!
# **       array_multisort -> bool             — Sort multiple or multi-dimensional arrays
# **       array_key_exists — Checks if the given key or index exists in the array
# *****    array_push — Push one or more elements onto the end of array ### HAS SIDEEFFECTS!
# ******   array_shift — Shift an element off the beginning of array ### HAS SIDEEFFECTS!
# *****     array_unshift — Prepend one or more elements to the beginning of an array  ### HAS SIDEEFFECTS!
# *****    array_reduce                        — Iteratively reduce the array to a single value using a callback function
# ****     array_product -> int                — Calculate the product of values in an array
# ***      array_search — Searches the array for a given value and returns the corresponding key if successful
# **       array_count_values — Counts all the values of an array
# **       array_pop — Pop the element off the end of array
# **       array_walk — Apply a user supplied function to every member of an array
# *        array_rand — Pick one or more random entries out of an array

/* returns an array */
# ***      array_uintersect_uassoc <- array, array, callable    — Computes the intersection of arrays with additional index check, data/index by callback function
# *        array_flip <- array                      — Exchanges all keys with their associated values in an array
# ***      array_uintersect_assoc <- array, array, callable     — Computes the intersection of arrays with additional index check, data by callback function
# ***      array_uintersect <- array, array, callable           — Computes the intersection of arrays, compares data by a callback function
# ***      array_diff_uassoc <- array, array        — Computes the difference of arrays with additional index check by a callback function
# **       array_replace_recursive                  — Replaces elements from passed arrays into the first array recursively
# ***      array_intersect_uassoc <- array, array   — Computes the intersection of arrays with additional index check, compares indexes by a callback function

# *****    array_splice <- array                    — Remove a portion of the array and replace it with something else  ### HAS SIDEEFFECTS!
# ****     array_column <- multiarray, string       — Return the values from a single column in the input array
# ****     array_fill <- start, count, value        — Fill an array with values
# ***      array_change_key_case                    — Changes the case of all keys in an array
# *****    array_combine <- array, array            — Creates an array by using one array for keys and another for its values
# ***      array_diff_assoc <- array, array         — Computes the difference of arrays with additional index check
# ***      array_diff_key <- array, array           — Computes the difference of arrays using keys for comparison
# ***      array_diff_ukey <- array, array          — Computes the difference of arrays using a callback function on the keys for comparison
# ***      array_diff <- array, array               — Computes the difference of arrays
# ***      array_intersect_assoc <- array, array    — Computes the intersection of arrays with additional index check
# ***      array_intersect_key <- array, array      — Computes the intersection of arrays using keys for comparison
# ***      array_intersect_ukey <- array, array     — Computes the intersection of arrays using a callback function on the keys for comparison
# ***      array_intersect <- array, array          — Computes the intersection of arrays
# ***      array_udiff_assoc <- array, array, callable          — Computes the difference of arrays with additional index check, data by callback function
# ***      array_udiff_uassoc <- array, array, callable         — Computes the difference of arrays with additional index check, data/index by callback function
# ***      array_udiff <- array, array, callable                — Computes the difference of arrays by using a callback function for data comparison
# **       array_replace <- array, array                        — Replaces elements from passed arrays into the first array
# **       array_fill_keys <- array, value          — Fill an array with values, specifying keys
# **       array_merge_recursive <- array, array    — Merge two or more arrays recursively
# **       array_merge <- array, array              — Merge one or more arrays
# **       array_slice <- array                     — Extract a slice of the array
# *        array_map <- calllable, array            — Applies the callback to the elements of the given arrays
# *        array_keys <- array                      — Return all the keys or a subset of the keys of an array
# *        array_values <- array                    — Return all the values of an array
# *        array                                    — Create an array
# *        array_filter <- array, callack (optional) — Filters elements of an array using a callback function
# *        array_pad <- array                       — Pad array to the specified length with a value
# *        array_reverse <- array                   — Return an array with elements in reverse order
# *        array_unique <- array                    — Removes duplicate values from an array

/* returns an array of arrays */
# *****     array_chunk <— int                       - Split an array into chunks


