use std::io::BufferedReader;
use std::io::File;
use std::io::fs::PathExtensions;
use std::rand::distributions::{IndependentSample, Range};

fn main() {
    let args = std::os::args();

    if (args.len() < 2) {
        panic!("Not enough arguments supplied.");
    }

    let path = Path::new(&args[1]);

    if path.exists() != true {
        panic!("The file {:?} does not exist.", path);
    }

    let mut file = BufferedReader::new(File::open(&path));
    let names: Vec<String> = file.lines().map(|x| x.unwrap()).collect();
    let index_range = Range::new(0, names.len() - 1);
    let mut rng = std::rand::thread_rng();
    let random_index = index_range.ind_sample(&mut rng);
    println!("{}", names[random_index]);
}
