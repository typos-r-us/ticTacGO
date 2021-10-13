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

  // add endgame logic. This wil rely on the scoreboard
  bool checkWinner (String player, int index, List<int> scoreboard, int gridSize){
    // declare the rows and cols
    int row = index ~/3;
    int col = index % 3;
    int score = player == "X" ? 1: -1;

    scoreboard[row]+=score;
    scoreboard[gridSize + col] +=score;
    if(row == col) scoreboard[2*gridSize] += score;
    if(gridSize -1 - col == row) scoreboard[2*gridSize +1] += score;
    // look for 3 or -3 in the scoreboard
    if(scoreboard.contains(3)||scoreboard.contains(-3)){
      return true;
    }
    // default return value is always false
    return false;
  }
}