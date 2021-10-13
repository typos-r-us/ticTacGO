import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_go/uiElements/themes/colors.dart';
import 'package:tic_tac_go/utils/game_engine.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TicTacGo(),
    );
  }
}
class TicTacGo extends StatefulWidget {
  const TicTacGo({Key? key}) : super(key: key);

  @override
  _TicTacGoState createState() => _TicTacGoState();
}

class _TicTacGoState extends State<TicTacGo> {
  // Add the variables
  String lastVal = "X";
  String playerName = "Player 1";
  Game game = Game();
  bool gameOver = false;
  int plays = 0; // the number of plays
  String gameResult = "";
  List<int> scoreBoard = [0,0,0,0,0,0,0,0]; // each score represents a possible winning combination, rows 3, cols 3, diagonals 2

  // initialize the game board
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    print(game.board); // for debug. prints the list to console
  }

  @override
  Widget build(BuildContext context) {
    // get the device size, set board dimensions
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Current Player: ${playerName}".toUpperCase(),
            style: TextStyle(
              color: Colors.white, fontSize: 38,
            ),
          ),
          SizedBox(height: 20.0,),
          // Add the game board
          Container(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3, // using ~/ allows to return INT only
              padding: EdgeInsets.all(16.0),
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: List.generate(Game.boardLength, (index) {
                // todo: handle overflow error on screen auto-rotate
                return InkWell(
                  onTap: gameOver ? null : (){
                    // Check if te field is empty :-) Only allow the move is true
                    if(game.board![index]==""){
                      // Add new value to the board and refresh the screen.
                      // Also, toggle the player
                      setState(() {
                        game.board![index] = lastVal;
                        plays++;
                        gameOver = game.checkWinner(lastVal, index, scoreBoard, 3);
                        if(gameOver){
                          if(lastVal == "x"){
                            gameResult = "Player 1 wins!";
                          }else{
                            gameResult = "Player 2 wins!";
                          }
                        }
                        if (lastVal == "X"){
                          lastVal = "O";
                          playerName = "Player 2";
                        }else {
                          lastVal = "X";
                          playerName = "Player 1";
                        }
                      });
                    }
                  },
                  child: Container(
                    height: Game.blocSize,
                    width: Game.blocSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondaryColor,
                      borderRadius: BorderRadius.circular(5.0)
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                          color: game.board![index] == "X" ? Colors.blue : Colors.pink,
                          fontSize: 50.0
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            gameResult,
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton.icon(
            onPressed: (){
              setState(() {
                // erase the game board, reset scores
                game.board = Game.initGameBoard();
                lastVal = "X";
                playerName = "Player 1";
                gameOver = false;
                plays=0;
                gameResult="";
                scoreBoard = [0,0,0,0,0,0,0,0];
              });
            },
            icon: Icon(Icons.replay),
            label: Text("Replay"),
            // style: ButtonStyle(
            //   backgroundColor: Color(MainColor.accentColor),
            // ),
          )
        ],
      ),
    );
  }
}