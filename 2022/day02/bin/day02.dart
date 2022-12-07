import 'dart:io';

/* 
  Advent of Code Day 02 - Jose Georges

  List of Rock, Paper, Scissors rounds in input.txt file
  each round shows the opponents play and your play

  --------------
 |Strategy guide
  --------------
  
  Opponent:
  --------
  A -> Rock
  B -> Paper
  C -> Scissors

  Me:
  --
  Y -> Paper -> 2
  X -> Rock -> 1
  Z -> Scissors -> 3

  Round Points:
  --------
  Win -> 6
  Draw -> 3
  Loss -> 0

  Strategy:
  --------
  A Y -> 6 + 2 = 8
  B X -> 0 + 1 = 1
  C Z -> 3 + 3 = 6

*/
void main(List<String> arguments) async {

  print("Advent of Code Day 02!");

  final String file = await File('assets/input.txt').readAsString();

  List<String> roundsStr =  file.split("\n");

  List<Round> rounds = roundsStr.map((e) {
    List<String> round = e.split(" ");
    return Round(
      opponent: Referee.mapTheirPlay(round[0]),
      me: Referee.mapMyPlay(round[1]),
    );
  }).toList();
  
  // Part 1 - Total score if everything goes exactly according to the strategy guide
  print("----------------------");
  print("Part 1: ");
  int totalScore = 0;
  for(Round round in rounds) {
    totalScore += Referee.calculateRoundScore(round);
  }
  print("Your score is: $totalScore");

  // Part 2 - Total score with a twist in the strategy:
  // Y -> Draw
  // X -> Loss
  // Z -> Win
  print("----------------------");
  print("Part 2: ");
  List<Round> roundsPartTwo = roundsStr.map((e) {
    List<String> round = e.split(" ");
    final Play theirPlay = Referee.mapTheirPlay(round[0]);
    return Round(
      opponent: theirPlay,
      me: Referee.mapMyPlayInPartTwo(theirPlay, round[1]),
    );
  }).toList();
  int totalScorePartTwo = 0;
  for(Round round in roundsPartTwo) {
    totalScorePartTwo += Referee.calculateRoundScore(round);
  }
  print("Your score is: $totalScorePartTwo");
}

enum Play {
  rock,
  paper,
  scissors
}

class Round {
  final Play opponent;
  final Play me;

  Round({required this.opponent, required this.me});
}

class Referee {
  static int calculateRoundScore(Round round) {
    int points = 0;
    switch(round.me) {
      case Play.rock:
        points+=1;
        break;
      case Play.paper:
        points+=2;
        break;
      case Play.scissors:
        points+=3;
        break;
    }
    points+=_calculateWinPoints(round);
    return points;
  }

  static int _calculateWinPoints(Round round) {
      int points = 0;
      switch(round.me) {
      case Play.rock:
        switch(round.opponent) {
          case Play.rock:
            points+=3;
            break;
          case Play.paper:
            break;
          case Play.scissors:
            points+=6;
            break;
        }
        break;
      case Play.paper:
        switch(round.opponent) {
          case Play.rock:
            points+=6;
            break;
          case Play.paper:
            points+=3;
            break;
          case Play.scissors:
            points+=0;
            break;
        }
        break;
        break;
      case Play.scissors:
        switch(round.opponent) {
          case Play.rock:
            points+=0;
            break;
          case Play.paper:
            points+=6;
            break;
          case Play.scissors:
            points+=3;
            break;
        }
        break;
    }

    return points;
  }

  static Play mapTheirPlay(String play) {
    switch(play) {
      case "A":
        return Play.rock;
        break;
      case "B":
        return Play.paper;
        break;
      case "C":
        return Play.scissors;
        break;
      default:
        throw Exception ("Play not allowed");
    }
  }


  static Play mapMyPlay(String play) {
    switch(play) {
      case "X":
        return Play.rock;
        break;
      case "Y":
        return Play.paper;
        break;
      case "Z":
        return Play.scissors;
        break;
      default:
        throw Exception ("Play not allowed");
    }
  }

  static Play mapMyPlayInPartTwo(Play theirPlay, String outcome) {
    bool win = false;
    bool loss = false;
    bool draw = false;

    switch(outcome) {
      case "X":
        loss = true;
        break;
      case "Y":
        draw = true;
        break;
      case "Z":
        win = true;
        break;
      default:
        throw Exception ("Play not allowed");
    }
    switch(theirPlay) {
          case Play.rock:
            if(win) {
              return Play.paper;
            } else if(loss) {
              return Play.scissors;
            } else {
              return theirPlay;
            }
            break;
          case Play.paper:
            if(win) {
              return Play.scissors;
            } else if(loss) {
              return Play.rock;
            } else {
              return theirPlay;
            }
            break;
          case Play.scissors:
            if(win) {
              return Play.rock;
            } else if(loss) {
              return Play.paper;
            } else {
              return theirPlay;
            }
            break;
      }
  }
}
