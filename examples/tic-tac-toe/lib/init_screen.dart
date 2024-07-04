import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:tictactoe/constants/globals.dart';
import 'package:tictactoe/login_screen.dart';
import 'package:tictactoe/utils/okto.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  Globals globals = Globals.instance;
  final apiController = TextEditingController();

  int _selectedChipIndex = -1;

  final List<String> _options = ['Sandbox', 'Staging', 'Production'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: apiController,
            decoration: const InputDecoration(hintText: 'Enter your client api key'),
          ),
          Wrap(
            spacing: 8.0,
            children: List<Widget>.generate(
              _options.length,
              (int index) {
                return ChoiceChip(
                  label: Text(_options[index]),
                  selected: _selectedChipIndex == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedChipIndex = selected ? index : -1;
                    });
                  },
                );
              },
            ).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              if (_selectedChipIndex != -1) {
                     if (_selectedChipIndex == 0) {
                  setState(() {
                    globals.setBuildType(BuildType.sandbox);
                  });
                } else if (_selectedChipIndex == 1) {
                  setState(() {
                    globals.setBuildType(BuildType.staging);
                  });
                } else if (_selectedChipIndex == 2) {
                  setState(() {
                    globals.setBuildType(BuildType.production);
                  });
                }
                setState(() {
                  globals.setApiKey(apiController.text);
                  okto = Okto(globals.getApiKey(),globals.getBuildType());
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginWithGoogle()));
              }
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
