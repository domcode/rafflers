

raffler(Name) :-
    read_list(List),
    choose(List, Name).

choose([], _).
choose(List, Elt) :-
        length(List, Length),
        random(0, Length, Index),
        nth0(Index, List, Elt).

read_list(List) :-
    current_prolog_flag(argv, [File | _]),
    phrase_from_file(lines(List), File).


lines([])           --> call(eos), !.
lines([Line|Lines]) --> line(Codes), {atom_codes(Line, Codes)}, lines(Lines).

eos([], []).

line([])     --> ( "\n" ; call(eos) ), !.
line([L|Ls]) --> [L], line(Ls).

?- raffler(Name), write(Name), nl, halt(0).
