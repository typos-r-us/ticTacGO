class Player{
  static const x = "X";
  static const o = "O";
  static const empty= "";
}

class Game{
  static final boardLength = 9; // this is our 3*3 game board
  static final blocSize = 100.0;
  
  // generate the empty board
  List<String>? board;
  static List<String>? initGameBoard() => List.generate(boardLength, (index) => Player.empty);
}