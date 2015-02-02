var fs = require('fs');

var argv = process.argv;

if(argv.length < 3) {
    console.error("U should give me something to eat btw...");
    process.exit(1);
}

var filename = argv[2];

fs.readFile(filename, "utf8", function(err, data) {
    
    if(err)
        throw err;

    var lines = data.trim().split('\n');
    
    var randomLineNumber = Math.floor(Math.random() * lines.length);

    console.log(lines[randomLineNumber]);
});
