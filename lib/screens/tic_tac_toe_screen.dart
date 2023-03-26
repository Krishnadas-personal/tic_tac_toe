import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tic_tac_toe/screens/home_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext builder) {
            return AlertDialog(
              content: const Text("Choose your mark"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          userMark = "O";
                          computerMark = "X";
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.circle_outlined, size: 40)),
                    IconButton(
                        onPressed: () {
                          userMark = "X";
                          computerMark = "O";
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close, size: 40)),
                  ],
                ),
              ],
            );
          }),
    );
  }

  int playerPlayedBox = 0;
  String? userMark;
  String? computerMark;
  List? playerSymbolList = ["", "", "", "", "", "", "", "", ""];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () => (playerSymbolList![index] == "")
                      ? onMarking(index)
                      : null,
                  child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Center(
                      child: Text(
                        playerSymbolList![index] ?? "",
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
              itemCount: 9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10.0),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () {
                  setState(() {
                    playerSymbolList = ["", "", "", "", "", "", "", "", ""];
                    playerPlayedBox = 0;
                  });
                },
                child: const Text("RESTART THE GAME",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF222431),
                    ))),
          )
        ],
      ),
    );
  }

  onMarking(index) {
    setState(() {
      playerSymbolList![index] = userMark ?? "";
      print(playerSymbolList?.length);
      if (playerSymbolList!.isNotEmpty) {
        print("computerMark");
        // _computerPlaying();
        _aiPlaying();
      }
      playerPlayedBox++;
      print("$playerPlayedBox playerPlayedBox");
      _checkWinner();
    });
  }

  void _checkWinner() {
    //rows
    if (playerSymbolList![0] == playerSymbolList![1] &&
        playerSymbolList![0] == playerSymbolList![2] &&
        playerSymbolList![0] != '') {
      showingMessage(playerSymbolList![0]);
    }
    if (playerSymbolList![3] == playerSymbolList![4] &&
        playerSymbolList![3] == playerSymbolList![5] &&
        playerSymbolList![3] != '') {
      showingMessage(playerSymbolList![3]);
    }
    if (playerSymbolList![6] == playerSymbolList![7] &&
        playerSymbolList![6] == playerSymbolList![8] &&
        playerSymbolList![6] != '') {
      showingMessage(playerSymbolList![6]);
    }
    //column
    if (playerSymbolList![0] == playerSymbolList![3] &&
        playerSymbolList![0] == playerSymbolList![6] &&
        playerSymbolList![0] != '') {
      showingMessage(playerSymbolList![0]);
    }
    if (playerSymbolList![1] == playerSymbolList![4] &&
        playerSymbolList![1] == playerSymbolList![7] &&
        playerSymbolList![1] != '') {
      showingMessage(playerSymbolList![1]);
    }
    if (playerSymbolList![2] == playerSymbolList![5] &&
        playerSymbolList![2] == playerSymbolList![8] &&
        playerSymbolList![2] != '') {
      showingMessage(playerSymbolList![2]);
    }

    //diagonal
    if (playerSymbolList![0] == playerSymbolList![4] &&
        playerSymbolList![0] == playerSymbolList![8] &&
        playerSymbolList![0] != '') {
      showingMessage(playerSymbolList![0]);
    }
    if (playerSymbolList![2] == playerSymbolList![4] &&
        playerSymbolList![2] == playerSymbolList![6] &&
        playerSymbolList![2] != '') {
      showingMessage(playerSymbolList![2]);
    } else if (playerPlayedBox == 5) {
      showingMessage("Its a Draw");
    }
  }

  showingMessage(text) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext builder) {
        return AlertDialog(
          content: (computerMark == text)
              ? const Text("You Lose")
              : (userMark == text)
                  ? const Text("You Win")
                  : Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return const HomePage();
                    }),
                  );
                },
                child: const Text("Main Menu")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    playerSymbolList = ["", "", "", "", "", "", "", "", ""];
                    playerPlayedBox = 0;
                  });
                },
                child: const Text("Replay"))
          ],
        );
      },
    );
  }

  _aiPlaying() {
    print(playerSymbolList);
    if (((playerSymbolList![1] == computerMark &&
                playerSymbolList![2] == computerMark) ||
            (playerSymbolList![3] == computerMark &&
                playerSymbolList![6] == computerMark) ||
            (playerSymbolList![4] == computerMark &&
                playerSymbolList![8] == computerMark)) &&
        playerSymbolList![0] == "") {
      playerSymbolList![0] = computerMark;
      return;
    } else if (((playerSymbolList![1] == userMark &&
                playerSymbolList![2] == userMark) ||
            (playerSymbolList![3] == userMark &&
                playerSymbolList![6] == userMark) ||
            (playerSymbolList![4] == userMark &&
                playerSymbolList![8] == userMark)) &&
        playerSymbolList![0] == "") {
      playerSymbolList![0] = computerMark;
      return;
    }

    if (((playerSymbolList![0] == computerMark &&
                playerSymbolList![2] == computerMark) ||
            (playerSymbolList![4] == computerMark &&
                playerSymbolList![7] == computerMark)) &&
        playerSymbolList![1] == "") {
      playerSymbolList![1] = computerMark;
      return;
    } else if (((playerSymbolList![0] == userMark &&
                playerSymbolList![2] == userMark) ||
            (playerSymbolList![4] == userMark &&
                playerSymbolList![7] == userMark)) &&
        playerSymbolList![1] == "") {
      playerSymbolList![1] = computerMark;
      return;
    }

    if (((playerSymbolList![0] == computerMark &&
                playerSymbolList![1] == computerMark) ||
            (playerSymbolList![4] == computerMark &&
                playerSymbolList![6] == computerMark) ||
            (playerSymbolList![5] == computerMark &&
                playerSymbolList![8] == computerMark)) &&
        playerSymbolList![2] == "") {
      playerSymbolList![2] = computerMark;
      return;
    } else if (((playerSymbolList![0] == userMark &&
                playerSymbolList![1] == userMark) ||
            (playerSymbolList![4] == userMark &&
                playerSymbolList![6] == userMark) ||
            (playerSymbolList![5] == userMark &&
                playerSymbolList![8] == userMark)) &&
        playerSymbolList![2] == "") {
      playerSymbolList![2] = computerMark;
      return;
    }

    if (((playerSymbolList![0] == computerMark &&
                playerSymbolList![2] == computerMark) ||
            (playerSymbolList![4] == computerMark &&
                playerSymbolList![5] == computerMark)) &&
        playerSymbolList![3] == "") {
      playerSymbolList![3] = computerMark;
      return;
    } else if (((playerSymbolList![0] == userMark &&
                playerSymbolList![2] == userMark) ||
            (playerSymbolList![4] == userMark &&
                playerSymbolList![5] == userMark)) &&
        playerSymbolList![3] == "") {
      playerSymbolList![3] = computerMark;
      return;
    }

    if (((playerSymbolList![1] == computerMark &&
                playerSymbolList![7] == computerMark) ||
            (playerSymbolList![3] == computerMark &&
                playerSymbolList![5] == computerMark) ||
            (playerSymbolList![0] == computerMark &&
                playerSymbolList![8] == computerMark)) &&
        playerSymbolList![4] == "") {
      playerSymbolList![4] = computerMark;
      return;
    } else if (((playerSymbolList![1] == userMark &&
                playerSymbolList![7] == userMark) ||
            (playerSymbolList![3] == userMark &&
                playerSymbolList![5] == userMark) ||
            (playerSymbolList![0] == userMark &&
                playerSymbolList![8] == userMark)) &&
        playerSymbolList![4] == "") {
      playerSymbolList![4] = computerMark;
      return;
    }
    print("object5");
    if (((playerSymbolList![2] == computerMark &&
                playerSymbolList![8] == computerMark) ||
            (playerSymbolList![3] == computerMark &&
                playerSymbolList![4] == computerMark)) &&
        playerSymbolList![5] == "") {
      playerSymbolList![5] = computerMark;
      return;
    } else if (((playerSymbolList![2] == userMark &&
                playerSymbolList![8] == userMark) ||
            (playerSymbolList![3] == userMark &&
                playerSymbolList![4] == userMark)) &&
        playerSymbolList![5] == "") {
      playerSymbolList![5] = computerMark;
      return;
    }
    print("object");
    if (((playerSymbolList![0] == computerMark &&
                playerSymbolList![3] == computerMark) ||
            (playerSymbolList![2] == computerMark &&
                playerSymbolList![4] == computerMark) ||
            (playerSymbolList![7] == computerMark &&
                playerSymbolList![8] == computerMark)) &&
        playerSymbolList![6] == "") {
      playerSymbolList![6] = computerMark;
      return;
    } else if (((playerSymbolList![0] == userMark &&
                playerSymbolList![3] == userMark) ||
            (playerSymbolList![2] == userMark &&
                playerSymbolList![4] == userMark) ||
            (playerSymbolList![7] == userMark &&
                playerSymbolList![8] == userMark)) &&
        playerSymbolList![6] == "") {
      playerSymbolList![6] = computerMark;
      return;
    }
    print("after object");
    if (((playerSymbolList![1] == computerMark &&
                playerSymbolList![4] == computerMark) ||
            (playerSymbolList![6] == computerMark &&
                playerSymbolList![8] == computerMark)) &&
        playerSymbolList![7] == "") {
      playerSymbolList![7] = computerMark;
      return;
    } else if (((playerSymbolList![1] == userMark &&
                playerSymbolList![4] == userMark) ||
            (playerSymbolList![6] == userMark &&
                playerSymbolList![8] == userMark)) &&
        playerSymbolList![7] == "") {
      playerSymbolList![7] = computerMark;
      return;
    }

    if (((playerSymbolList![2] == computerMark &&
                playerSymbolList![5] == computerMark) ||
            (playerSymbolList![0] == computerMark &&
                playerSymbolList![4] == computerMark) ||
            (playerSymbolList![6] == computerMark &&
                playerSymbolList![7] == computerMark)) &&
        playerSymbolList![8] == "") {
      playerSymbolList![8] = computerMark;
      return;
    } else if (((playerSymbolList![2] == userMark &&
                playerSymbolList![5] == userMark) ||
            (playerSymbolList![0] == userMark &&
                playerSymbolList![4] == userMark) ||
            (playerSymbolList![6] == userMark &&
                playerSymbolList![7] == userMark)) &&
        playerSymbolList![8] == "") {
      playerSymbolList![8] = computerMark;
      return;
    }
    for (int i = 0; i < playerSymbolList!.length; i++) {
      if (playerSymbolList![i] == "") {
        playerSymbolList![i] = computerMark;
        break;
      }
    }
  }
}
