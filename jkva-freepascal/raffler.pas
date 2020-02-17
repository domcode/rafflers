program Raffler;

{$IFDEF FPC}
  {$MODE OBJFPC}
  {$I+}
{$ENDIF}

uses
    SysUtils;

var
    names : TextFile;
    winner: String;
    count : Integer = 0;
    i     : Integer = 0;
    rnd   : Integer = 0;

begin
    if (ParamCount = 0) then begin
        writeln('ERROR: No filename supplied.');
        halt;
    end;
    
    Assign(names, ParamStr(1));

    try
        reset(names);
        while not eof(names) do begin
            readln(names, winner);
            inc(count);
        end;
    except
        on E: EInOutError do begin
            writeln('ERROR: handling input: ', E.Message);
            halt;
        end;
    end;

    if (count = 0) then begin
        writeln('ERROR: No names in file.');
        halt;
    end;

    Randomize;
    rnd := Random(count);

    reset(names);

    while i <= rnd do begin
        readln(names, winner);
        inc(i);
    end;
 
    CloseFile(names);

    writeln('We have a winner: ', winner);
end.
