import 'package:flutter/material.dart';
import 'package:tictactoe/utils/structs.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key, required this.curr});
  final String curr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Player $curr turn",
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class GameContainer extends StatelessWidget {
  const GameContainer({
    super.key,
    required this.state,
    required this.used,
    required this.onTap,
  });

  final BuildContext state;
  final List<String> used;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return Box(i: index, used: used, onTap: onTap);
          }),
    );
  }
}
