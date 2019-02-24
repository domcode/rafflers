import 'dart:io';
import "dart:math";

main (List<String> args) async {
  if (args.isEmpty) {
    throw Exception('No file supplied');
  }

  var file = File(args[0]);
  var names;
  final random = new Random();

  names = await file.readAsLines();
  names.removeWhere((value) => value.toString().isEmpty);

  var winner = names[random.nextInt(names.length)];
  print(winner);
}