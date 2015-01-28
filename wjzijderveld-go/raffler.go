package main

import (
	"os"
	"io/ioutil"
	"math/rand"
	"strings"
	"fmt"
	"time"
)

func main() {
	args := os.Args[1:]
	rand.Seed(time.Now().UnixNano())

	if len(args) < 1 {
	  fmt.Println("No input file given")
	  os.Exit(1)
	}

	b, err := ioutil.ReadFile(args[0])

	if err != nil {
		fmt.Printf("Dumbass.. %s\n", err)
		os.Exit(2)
	}

	lines := strings.Split(string(b), "\n")
	winner := ""
	for winner == "" { // we wouldn't empty lines screwing with our raffle
		winner = lines[rand.Intn(len(lines))]
	}

	fmt.Printf("And the winner is.... %s\n", winner)
}
