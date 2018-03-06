package main

import (
	"bufio"
	"flag"
	"fmt"
	"github.com/arbovm/levenshtein"
	"math/rand"
	"os"
	"runtime"
	"strings"
	"sync"
	"time"
)

var wg sync.WaitGroup

/**
 * Generate two random indices and a random number.
 * If the levenshtein distance between the names found at
 * index1 and index2 is the same as the random number,
 * one of index1 and index2 will be chosen at random to
 * be our winner.
 */
func raffle(names []string, winnerChannel chan string) {
	defer wg.Done()
	var index1, index2, n, d int
	var winner string
	for {
		index1 = rand.Int() % len(names)
		index2 = rand.Int() % len(names)
		n = 3 + rand.Int()%100
		d = levenshtein.Distance(names[index1], names[index2])
		if d == n {
			if rand.Int()%2 == 1 {
				winner = names[index1]
			} else {
				winner = names[index2]
			}
			winnerChannel <- winner
			return
		}
	}
}

func main() {
	// Use *ALL* the CPUs
	runtime.GOMAXPROCS(runtime.NumCPU())

	// Initialise command line params
	var routines int
	rand.Seed(time.Now().UTC().UnixNano())
	flag.IntVar(&routines, "n", 1000, "Number of goroutines to start.")
	flag.Parse()

	if flag.Arg(0) == "" {
		fmt.Fprintf(os.Stderr, "Usage: %s -n <goroutines> <filename>\n", os.Args[0])
		fmt.Fprintf(os.Stderr, "Defaults:\n")
		flag.PrintDefaults()
		os.Exit(1)
	}

	// Open file
	fp, err := os.Open(flag.Arg(0))
	defer fp.Close()

	if err != nil {
		fmt.Printf("Unable to open file: %s\n", err)
		os.Exit(1)
	}

	// Read names from file
	var names []string
	scanner := bufio.NewScanner(fp)
	var name string
	for scanner.Scan() {
		name = strings.Trim(scanner.Text(), " ")
		if name != "" {
			names = append(names, name)
		}
	}

	// Nobody there
	if len(names) == 0 {
		fmt.Println("No names found in file.")
		os.Exit(1)
	}

	// Lucky person
	if len(names) == 1 {
		fmt.Printf("Just one name in file. Winner by default: %s\n", names[0])
		os.Exit(1)
	}

	// Spawn goroutines
	winnerChannel := make(chan string, routines)
	for i := 0; i < routines; i++ {
		wg.Add(1)
		go raffle(names, winnerChannel)
	}

	// Wait for goroutines to do their jobs
	wg.Wait()

	// We're done, close the channel
	close(winnerChannel)

	// See who won and tally
	max := -1
	tally := make(map[string]int)
	for winner := range winnerChannel {
		tally[winner]++
		if tally[winner] > max {
			max = tally[winner]
		}
	}

	// See which people won the most
	var winners []string
	for name, timesWon := range tally {
		if timesWon == max {
			winners = append(winners, name)
		}
	}

	// Pick a random person from the winners
	fmt.Println(winners[rand.Int()%len(winners)])
}
