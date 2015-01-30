(* sanity checks *)
let argc = Array.length Sys.argv;;

if argc < 2 then begin
	print_endline "Did you forgot something?!";
	exit 1;
end

let filename = Sys.argv.(1);;

let file_exists = Sys.file_exists filename;;

if file_exists = false then begin
	print_endline "Dazed and Confused...";
	exit 1;	
end

(* read the file `f' and store each line into a list *)
let read_file f = 
	let lines = ref [] in
		let chan = open_in f in
		try
		while true; do
			lines := input_line chan :: !lines
		done; []
		with End_of_file ->
			close_in chan;
			List.rev !lines;;

let names = read_file filename;;

(* get a random name *)

let _ = Random.self_init();;

let random_element l =
    List.nth l (Random.int (List.length l));;

let random_name = random_element names;;

(* and have fun! *)

print_endline random_name;;

(* that's all *)