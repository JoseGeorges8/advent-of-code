import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';


// Advent of Code Day 05 - Jose Georges
//
void main() async {
  DateTime startTime = DateTime.now();

  print("Advent of Code Day 05!");
  final String file = await File('assets/input.txt').readAsString();
  
  List<String> lines = file.split("\n");
  List<StackInstruction> instructions = [];
  List<List<String>> stacks = [];

  for(String line in lines) {
    /// Fill in the instructions, else the stacks
    if(line.contains("move")){
      instructions.add(StackInstruction.fromInstruction(line));
    } else {
      /// Represents the current stack we are populating
      /// Gets reset at every line
      int stackNumber = 1;
      /// Stacks are built lile "[X] " so we iterate every 4 spaces
      /// We add the +1 because the last stack doesn't have a space
      for(int i = 4; i<=line.length+1;i+=4) {
        final crate = line[i-3];
        /// if this is the first time we set foot on this stack, instantiate it
        if(stacks.length < stackNumber)
            stacks.add([]);
        /// Only add it if is a letter
        if(!crate.trim().isEmpty && int.tryParse(crate) == null) {
          stacks[stackNumber-1].add(crate);
        }
        /// Go to the next stack
        stackNumber++;
      }
    }
  }

  /// Sort stacks so they have the top crate last
  for(int i=0; i<stacks.length;i++) {
    stacks[i] = List.from(stacks[i].reversed);
  }

  // Part 1 - After the rearrangement procedure completes, what crate ends up on top of each stack?
  _partOne(instructions, stacks);
  
  // Part 2 - After the rearrangement procedure completes, what crate ends up on top of each stack?
  // COMMENT OUT PART ONE FOR PART TWO 
  // _partTwo(instructions, stacks);

  DateTime finishedTime = DateTime.now();
  print("----------------------");
  print("Duration of code: ${finishedTime.difference(startTime).inMilliseconds} ms");
}

_partOne(
  List<StackInstruction> instructions,
  List<List<String>> stacks,
) {
  /// Interesting: Doing this still references the old lists.
  List<List<String>> stacksPartOne = List<List<String>>.from(stacks);
  print("----------------------");
  print("Part 1: ");
  for(StackInstruction instruction in instructions) {
    final fromStack = stacksPartOne[instruction.fromStack-1];
    final toStack = stacksPartOne[instruction.toStack-1];
    for(int i=0; i<instruction.moveCount;i++) {
      /// Grab the crate at the top of the "from" stack and move it to the "to" stack
      final temp = fromStack[fromStack.length-1];
      fromStack.removeLast(); 
      toStack.add(temp); 
    }
  }

  /// Get the result in a string with all top crates beside each other in order
  String result = "";
  for(List<String> stack in stacks) {
    result+=stack[stack.length-1];
  }
  print("Top crates: $result");
}

_partTwo(
  List<StackInstruction> instructions,
  List<List<String>> stacks,
) {
  List<List<String>> stacksPartTwo = List<List<String>>.from(stacks);
  print("----------------------");
  print("Part 2: ");
  for(StackInstruction instruction in instructions) {
    final fromStack = stacksPartTwo[instruction.fromStack-1];
    final toStack = stacksPartTwo[instruction.toStack-1];
    final firstIndex = fromStack.length-instruction.moveCount;
    final lastIndex = fromStack.length;
    /// Grab the crate at the top of the "from" stack and move it to the "to" stack
    final temp = fromStack.sublist(firstIndex, lastIndex);
    fromStack.removeRange(firstIndex, lastIndex); 
    toStack.addAll(temp); 
  }

  /// Get the result in a string with all top crates beside each other in order
  String result = "";
  for(List<String> stack in stacksPartTwo) {
    result+=stack[stack.length-1];
  }
  print("Top crates: $result");
}

/// A list of stacked crates
class CrateStack {
  final List<String> crates;
  final int number;

  CrateStack(this.crates, this.number);
}

/// An instruction that points the movement of [moveCount] amount of crates [fromStack] position [toStack] position
class StackInstruction {
  final int moveCount;
  final int fromStack;
  final int toStack;

  StackInstruction._(this.moveCount, this.fromStack, this.toStack);

  factory StackInstruction.fromInstruction(String instruction) {
    List<String> instructionSplit = instruction.split(" ");
    return StackInstruction._(
      int.parse(instructionSplit[1]),
      int.parse(instructionSplit[3]),
      int.parse(instructionSplit[5]),
    );
  }
}