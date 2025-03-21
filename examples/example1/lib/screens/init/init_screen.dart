import 'package:example/okto.dart';
import 'package:example/screens/auth/login_page.dart';
import 'package:example/utils/global_mode.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  Globals globals = Globals.instance;
  final clientSwaController = TextEditingController();
  final clientPrivateKey = TextEditingController();

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
            controller: clientSwaController,
            decoration:
                const InputDecoration(hintText: 'Enter your client swa'),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: clientPrivateKey,
            decoration:
            const InputDecoration(hintText: 'Enter your client private key'),
          ),
          const SizedBox(height: 16.0,),
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
                      prefillDummyValues();
                    });
                  },
                );
              },
            ).toList(),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_selectedChipIndex != -1) {
                if (_selectedChipIndex == 0) {
                  setState(() {
                    globals.setBuildType(Env.sandbox);
                  });
                } else if (_selectedChipIndex == 1) {
                  setState(() {
                    globals.setBuildType(Env.staging);
                  });
                } else if (_selectedChipIndex == 2) {
                  setState(() {
                    globals.setBuildType(Env.production);
                  });
                }
                setState(() {
                  globals.setClientSwa(clientSwaController.text);
                });
                setState(() {
                  globals.setClientPrivateKey(clientPrivateKey.text);
                });
                if(okto == null ) {
                  okto = Okto();
                  await okto?.initializeSdk(
                      swa: globals.getClientSwa(),
                      privateKey: globals.getClientPrivateKey(),
                      env: globals.getBuildType());
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }

  void prefillDummyValues() {
    if (_selectedChipIndex != -1) {
      if (_selectedChipIndex == 0) {
        clientSwaController.text = SdkConstants.sandbox.clientSWA;
        clientPrivateKey.text = SdkConstants.sandbox.clientPrivateKey;
      } else if (_selectedChipIndex == 1) {
        clientSwaController.text = SdkConstants.staging.clientSWA;
        clientPrivateKey.text = SdkConstants.staging.clientPrivateKey;
      } else if (_selectedChipIndex == 2) {
        clientSwaController.text = SdkConstants.production.clientSWA;
        clientPrivateKey.text = SdkConstants.production.clientPrivateKey;
      }
    }
  }
}
