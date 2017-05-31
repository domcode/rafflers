def people = new java.io.File(args[0]).readLines()
println people[(new java.util.Random()).nextInt(people.size())]
