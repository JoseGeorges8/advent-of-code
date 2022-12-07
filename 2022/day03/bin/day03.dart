import 'dart:io';
import 'dart:core';
import 'dart:math';

/* 
  Advent of Code Day 03 - Jose Georges

  - List of rucksacks with items (each line in the input file is a rucksack, and each character is an item)
  - Rucksacks have 2 compartments
  - First contains the first half of the items, second the second half
  - Each item has a priority:
    - Lowercase item types a through z have priorities 1 through 26.
    - Uppercase item types A through Z have priorities 27 through 52.
*/
void main(List<String> arguments) async {
  DateTime startTime = DateTime.now();

  print("Advent of Code Day 03!");
  final String file = await File('assets/input.txt').readAsString();
  List<String> rucksacks =  file.split("\n");
  
  // Part 1 - Find the item type that appears in both compartments of each rucksack. What is the sum of the priorities of those item types?
  int sum = 0;
  print("----------------------");
  print("Part 1: ");
  for(String rucksack in rucksacks) {
    List<String> items = rucksack.split("");
    final half = (items.length/2).floor();
    final compartment1 = items.sublist(0, half);
    final compartment2 = items.sublist(half, items.length);

    List<String> foundItems = [];
    for(String item in compartment1) {
      
      /// Found the common item
      if(compartment2.contains(item)) {
        sum+=_calculatePriority(item);
        foundItems.add(item);
        break;
      }
    }
  }
  print("Sum of equal priorities: $sum");

  // Part 2 - Find the item type that corresponds to the badges of each three-Elf group. What is the sum of the priorities of those item types?
  print("----------------------");
  print("Part 2: ");
  int sumBadges = 0;
  int groupSize = 3;
  List<List<String>> groups = [];
  for(int i=0;i<rucksacks.length;i+=groupSize) {
    groups.add(rucksacks.sublist(i, i+groupSize));
  }

  for(List<String> group in groups) {

    final firstRucksack = group[0];    
    List<String> items = firstRucksack.split("");
    List<String> foundItems = [];
    for(String item in items) {
      final count = group.where((rucksack) => rucksack.contains(item)).length;
      /// found in all the rucksacks - that's the badge.
      if(count == group.length && !foundItems.contains(item)) {
        sumBadges+=_calculatePriority(item);
        foundItems.add(item);
        break;
      }
    }
  }

  print("Sum of badges: $sumBadges");

  DateTime finishedTime = DateTime.now();

  print("----------------------");
  print("Duration of code: ${finishedTime.difference(startTime).inMilliseconds} ms");
}

int _calculatePriority(String item) {
  final int startForLowerCase = 96; // unicode for 'a' is 97
  final int startForUpperCase = 64; // unicode for 'A' is 65
  final int upperCaseOffSet = 26;
  final unicode = item.codeUnitAt(0);

  int priority = unicode > startForLowerCase ? (unicode - startForLowerCase) : (unicode - startForUpperCase) + upperCaseOffSet;
  return unicode > startForLowerCase ? (unicode - startForLowerCase) : (unicode - startForUpperCase) + upperCaseOffSet;
}
