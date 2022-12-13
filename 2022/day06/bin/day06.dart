import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

// Advent of Code Day 06 - Jose Georges
//
void main() async {
  DateTime startTime = DateTime.now();

  print("Advent of Code Day 06!");
  final String file = await File('assets/input.txt').readAsString();

  // Part 1 - How many characters need to be processed before the first start-of-packet marker is detected?
  print("----------------------");
  print("Part 1: ");
  print("characters processed: ${_getProccessedCharacterCount(file, 4)}");
  
  // Part 2 - How many characters need to be processed before the first start-of-message marker is detected?
  print("----------------------");
  print("Part 2: ");
  print("characters processed: ${_getProccessedCharacterCount(file, 14)}");

  DateTime finishedTime = DateTime.now();
  print("----------------------");
  print("Duration of code: ${finishedTime.difference(startTime).inMilliseconds} ms");
}

_getProccessedCharacterCount(String input, int markerLength) {
  Set <String> marker = {};
  for(int i=0;i<input.length;i++) {
    for(int j = i; j < i+markerLength;j++) {
      final letter = input[j];
      if(marker.contains(letter)) {
        marker.clear();
        break;
      } else {
        marker.add(letter);
      }
    }
    if(marker.length == markerLength){
      return i+markerLength; // we processed "i" numbers + the ones inside the inner for-loop
    }
  }
}