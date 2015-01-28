var fs = require('fs')

// Get the first argument from the command line
var file = process.argv[2]

// If there is no argument given throw an error
if(! file)
	return console.error('Please provide a file path argument')

// If the file doesn't exist or it's not a file throw an error
if(! fs.existsSync(file) || ! fs.lstatSync(file).isFile())
	return console.error('The argument you provided is not a file')

// Open the file and split on newlines
var names = fs.readFileSync(process.argv[2], 'utf8').split('\n')

// Return a random name
return console.log('The winner is: ' + names[Math.floor(Math.random() * names.length)]);