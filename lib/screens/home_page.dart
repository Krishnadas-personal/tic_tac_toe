import 'package:flutter/material.dart';
import 'package:tic_tac_toe/screens/instruction.dart';

import 'tic_tac_toe_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const Text(
            "TIC TAC TOE",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
          Center(child: Image.asset('assets/game_logo.png')),
          ElevatedButton.icon(
            label: const Text("PLAY GAME",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF222431),
                )),
            icon: const Icon(
              Icons.play_arrow,
              color: Color(0xFF222431),
            ),
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10.0),
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const Instruction();
                }),
              );
            },
          )
        ],
      ),
    );
  }
}
