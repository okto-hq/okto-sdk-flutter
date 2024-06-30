import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:tictactoe/constants/colors.dart';
import 'package:tictactoe/utils/okto.dart';
import 'package:tictactoe/utils/structs.dart';
import 'package:tictactoe/core/widgets.dart';
import 'package:tictactoe/utils/var.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Future<UserDetails>? _userDetails;

  Future<UserDetails> fetchUserDetails() async {
    try {
      final userDetails = await okto.userDetails();
      return userDetails;
    } catch (e) {
      throw Exception(e);
    }
  }

  static const String p1 = "X", p2 = "O";
  late String currPlay;
  late bool gameEnd;
  late List<String> occupied;

  @override
  void initState() {
    initializeGame();
    super.initState();
  }

  void initializeGame() {
    currPlay = p1;
    gameEnd = false;
    occupied = ["", "", "", "", "", "", "", "", ""];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeaderText(curr: currPlay),
            _userDetails == null
                ? Container()
                : FutureBuilder<UserDetails>(
                    future: _userDetails,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(color: Colors.white));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final userDetails = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email: ${userDetails.data.email}',
                                style: const TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              // Add more fields here as needed
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
            GameContainer(state: context, used: occupied, onTap: _handleBoxTap),
            const Text('You are player X'),
            RestartButton(press: _handleRestartButtonPressed),
          ],
        ),
      ),
    );
  }

  void _handleBoxTap(int index) {
    if (gameEnd || occupied[index].isNotEmpty) {
      return;
    }

    setState(() {
      occupied[index] = currPlay;
      changeTurn();
      checkForWinner();
      checkForDraw();
    });
  }

  void _handleRestartButtonPressed() {
    setState(() {
      initializeGame();
    });
  }

  void changeTurn() {
    currPlay = (currPlay == p1) ? p2 : p1;
  }

  void checkForWinner() {
    for (var winningPos in winningList) {
      if (occupied[winningPos[0]].isNotEmpty && occupied[winningPos[0]] == occupied[winningPos[1]] && occupied[winningPos[0]] == occupied[winningPos[2]]) {
        if (occupied[winningPos[0]] == 'X') {
          // CALLED WHENEVER PLAYER X WINS
        }
        showGameOverMessage("Player ${occupied[winningPos[0]]} Won");
        gameEnd = true;
        return;
      }
    }
  }

  void checkForDraw() {
    if (gameEnd) return;
    bool draw = occupied.every((occupiedP) => occupiedP.isNotEmpty);
    if (draw) {
      showGameOverMessage("Draw");
      gameEnd = true;
    }
  }

  void showGameOverMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, color: primaryColor)),
      ),
    );
  }
}
