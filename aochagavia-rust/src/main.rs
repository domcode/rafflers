extern crate rand;

use rand::Rng;
use std::env;
use std::fs::File;
use std::io::{BufRead, BufReader};

fn main() {
    let args: Vec<_> = env::args().collect();

    if args.len() < 2 {
        println!("Insufficient arguments given");
        return;
    }

    let file = File::open(&args[1]).expect("Failed to open file");
    let names = BufReader::new(file).lines()
                                    .collect::<Result<Vec<_>, _>>()
                                    .expect("Failed to read lines");

    let chosen_one = rand::thread_rng().choose(&names)
                                       .expect("The list of names is empty");

    println!("{}", chosen_one);
}
