use std::io::{File, Open, Read};
use std::os;
use std::rand;

fn main() {
    let args = os::args();

    if args.len() < 2 {
        // No filename passed.
        println!("Usage: raffler <file_with_names>");
        os::set_exit_status(1);
        return;
    }

    let ref path = args[1];

    let mut file = match File::open_mode(&Path::new(path), Open, Read) {
        Ok(f) => f,
        Err(e) => panic!("Error reading file '{}': {}", path, e),
    };

    let names = match file.read_to_string() {
        Ok(names) => names,
        Err(e) => panic!("Error reading file '{}' to a string: {}", path, e),
    };

    let random: f32 = rand::random();
    let names_vector: Vec<&str> = names.split_str("\n").filter(|v: &&str| v.len() > 0).collect();
    let name_count = names_vector.len();
    let winner_index = (random * name_count as f32) as usize;
    let winner = names_vector[winner_index];

    println!("{}", winner);
}
