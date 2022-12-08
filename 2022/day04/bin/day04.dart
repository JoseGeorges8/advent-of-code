import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

// Advent of Code Day 04 - Jose Georges
//
// List of sections covered by a pair of elfs
// each cover sections from X-Y where X < Y
// pairs are separated by a comma
void main() async {
  DateTime startTime = DateTime.now();

  print("Advent of Code Day 04!");
  final String file = await File('assets/input.txt').readAsString();
  List<String> lines =  file.split("\n");

  // Part 1 - In how many assignment pairs does one range fully contain the other?
  int sumOfContainedSections = 0;
  for(String line in lines) {
    List<String> pairStr =  line.split(",");
    final List<String> first = pairStr[0].split("-");
    final List<String> second = pairStr[1].split("-");

    final int firstStart = int.parse(first[0]);
    final int firstEnd = int.parse(first[1]);
    final int secondStart = int.parse(second[0]);
    final int secondEnd = int.parse(second[1]);

    final int diffFirst = firstEnd - firstStart;
    final int diffSecond = secondEnd - secondStart;
    
    if(diffFirst >= diffSecond) {
      if(firstStart <= secondStart && firstEnd >= secondEnd) {
        sumOfContainedSections++;
      }
    } else {
      if(secondStart <= firstStart && secondEnd >= firstEnd) {
        sumOfContainedSections++;
      }
    }
  }
  print("----------------------");
  print("Part 1: ");
  print("Fully contained sections: $sumOfContainedSections");

  
  // Part 2 - In how many assignment pairs do the ranges overlap?
  int sumOfOverlapedSections = 0;
  for(String line in lines) {
    List<String> pairStr =  line.split(",");
    final List<String> first = pairStr[0].split("-");
    final List<String> second = pairStr[1].split("-");

    final int firstStart = int.parse(first[0]);
    final int firstEnd = int.parse(first[1]);
    final int secondStart = int.parse(second[0]);
    final int secondEnd = int.parse(second[1]);

    final int diffFirst = firstEnd - firstStart;
    final int diffSecond = secondEnd - secondStart;
    
    if(firstStart <= secondEnd && firstEnd >= secondStart) {
      sumOfOverlapedSections++;
    }
  }
  print("----------------------");
  print("Part 2: ");
  print("Overlaped sections: $sumOfOverlapedSections");

  DateTime finishedTime = DateTime.now();
  print("----------------------");
  print("Duration of code: ${finishedTime.difference(startTime).inMilliseconds} ms");
}