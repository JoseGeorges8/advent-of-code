import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

// Advent of Code Day 01 - Jose Georges
//
// List of integers in input.txt file
// each 'group' separated by a space
// the sum of each group is the amount of calories carried by each Elf
void main() async {

  print("Advent of Code Day 01!");

  final file = File('assets/input.txt');
  Stream<String> lines = file.openRead()
    .transform(utf8.decoder)       // Decode bytes to UTF-8.
    .transform(LineSplitter());    // Convert stream to individual lines.
  
  List<int> caloriesPerElf = [];
  int calories = 0;
  await for (String line in lines) {
    if(line.length != 0) {
      calories+=int.tryParse(line) ?? 0;
    } else {
      caloriesPerElf.add(calories);
      calories = 0;
    }
  }
  // Part 1 - Get the elf carrying the most calories
  print("----------------------");
  print("Part 1: ");
  print("Total max calories: ${caloriesPerElf.reduce(max)}");
  
  // Part 2 - Get the sum of calories of the top 3 elfs
  print("----------------------");
  print("Part 2: ");
  caloriesPerElf.sort();
  int length = caloriesPerElf.length;
  if(length < 3) {
    print("There aren't at least 3 elves in this list! You need some more backup!!");
  }
  int totalCals = caloriesPerElf[length-1] + caloriesPerElf[length-2] + caloriesPerElf[length-3];
  print("Total calories of the top three elfs: $totalCals");
}