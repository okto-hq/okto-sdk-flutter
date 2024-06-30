import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class RawTransactioneExecutePage extends StatefulWidget {
  const RawTransactioneExecutePage({super.key});

  @override
  State<RawTransactioneExecutePage> createState() => _RawTransactioneExecutePageState();
}

class _RawTransactioneExecutePageState extends State<RawTransactioneExecutePage> {
  final networkName = 'SOLANA_DEVNET';
  final TextEditingController instructionsController = TextEditingController(text: '''
    [
      {
        "keys": [
          {
            "pubkey": "GQkXkHF8LTwyZiZUcBWwYJeJBFEqR4vRCV4J5Xe7zGiQ",
            "isSigner": true,
            "isWritable": true
          },
          {
            "pubkey": "GEjBy2puN8a53darpz7CTbRvSb6wepzhK7s8C3Dww4yg",
            "isSigner": false,
            "isWritable": true
          }
        ],
        "programId": "11111111111111111111111111111111",
        "data": [
          2,
          0,
          0,
          0,
          128,
          150,
          152,
          0,
          0,
          0,
          0,
          0
        ]
      }
    ]
    ''');
  final TextEditingController signersController = TextEditingController(text: '["GQkXkHF8LTwyZiZUcBWwYJeJBFEqR4vRCV4J5Xe7zGiQ"]');

  Future<RawTransactionExecuteResponse>? _rawTransactionExecuted;

  Future<RawTransactionExecuteResponse> rawTransactionExecute() async {
    final transactionObject = {
      'transaction': {
        'instructions': instructionsController.text,
        'signers': signersController.text,
      },
    };
    try {
      final orderHistory = await okto.rawTransactionExecute(networkName: networkName, transaction: transactionObject);
      return orderHistory;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5166EE),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(40),
              child: const Text(
                'Raw Transaction Execute',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _rawTransactionExecuted = rawTransactionExecute();
                });
              },
              child: const Text('Execute Raw Transaction'),
            ),
            Expanded(
              child: _rawTransactionExecuted == null
                  ? Container()
                  : FutureBuilder<RawTransactionExecuteResponse>(
                      future: _rawTransactionExecuted,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final transferNftResponse = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Job id: ${transferNftResponse.data.jobId}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
