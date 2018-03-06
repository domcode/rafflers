#include <iostream>
#include <fstream>
#include <algorithm>
#include <iterator>
#include <chrono>

int main(int argc, char **argv)
{
    if (argc < 2)
    {
        std::cout << "You forgot the filename!";
        return 0;
    }
    // Get the number of participants
    std::ifstream raffle(argv[1]);
    size_t names = std::count(std::istreambuf_iterator<char>(raffle),
         std::istreambuf_iterator<char>(), '\n');

    // Random stuff
    std::mt19937 generator(std::chrono::system_clock::now().time_since_epoch().count());;
    std::uniform_int_distribution<size_t> distribution(0, names);

    size_t winner_id = distribution(generator);
    std::string winner;

    //skip the first N names
    raffle.seekg(std::ios::beg);
    for(size_t idx = 0; idx <= winner_id; ++idx)
       std::getline(raffle, winner);

    std::cout << "And the winner is.. " << winner << "!\n";
}