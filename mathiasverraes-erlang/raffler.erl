#!/usr/bin/env escript
main([File]) ->
    seed(),
    Winner = random(readlines(File)),
    io:format("~s", [Winner]);
main(_) ->
    io:format("Usage: raffler.erl FILENAME \n"),
    halt(1).

seed() ->
    {A1, A2, A3} = now(),
    random:seed(A1, A2, A3).
random(List) ->
    lists:nth(random:uniform(length(List)), List).

readlines(FileName) ->
    {ok, Device} = file:open(FileName, [read]),
    get_all_lines(Device, []).

get_all_lines(Device, Accum) ->
    case io:get_line(Device, "") of
        eof -> file:close(Device), Accum;
        Line -> get_all_lines(Device, Accum ++ [Line])
    end.