val people = java.io.File(args[0]).readLines()
println(people[java.util.Random().nextInt(people.size)])
