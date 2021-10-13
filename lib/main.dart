import 'package:flutter/material.dart';
import 'package:tic_tac_go/uiElements/themes/colors.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
    );
  }
}