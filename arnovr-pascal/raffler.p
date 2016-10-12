program ReadFile;

type
	arrayOfNames = array[0 .. 500] of String;

Var S : String;
	C : Char;
	F : TextFile;
	Names: arrayOfNames;
	i: Integer = 0;

begin
Randomize;
	Assign(F, ParamStr(1));
	Reset(F);

	while not eof(F) do
		begin
			readln(F, names[i]);
			inc(i);
		end;

	WriteLn(names[Random(i)]);
end.
