import 'package:flutter/material.dart';

import 'tic_tac_toe_screen.dart';

class Instruction extends StatelessWidget {
  const Instruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _text("Game Instructions -", 20.0, Colors.white),
          _text(
              "1. The game is played on a grid that's 3 squares by 3 squares.",
              14.0,
              Colors.white),
          _text(
              "2. Suppose if you choose X, the computer is O. Players take turns putting their marks in empty squares.",
              14.0,
              Colors.white),
          _text(
              "3. The first player to get 3 of her marks in a row (up, down, across, or diagonally) is the winner.",
              14.0,
              Colors.white),
          _text("4. When all 9 squares are full, the game is over.", 14.0,
              Colors.white),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10.0),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const GamePage();
                }),
              );
            },
            child: _text("Continue", 20.0, Theme.of(context).primaryColor),
          )
        ],
      ),
    );
  }

  _text(text, size, color) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color),
    );
  }
}
