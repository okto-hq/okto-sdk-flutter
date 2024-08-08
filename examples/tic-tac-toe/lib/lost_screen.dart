import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:tictactoe/utils/okto.dart';

class YouLostScreen extends StatefulWidget {
  const YouLostScreen({super.key});

  @override
  State<YouLostScreen> createState() => _YouLostScreenState();
}

class _YouLostScreenState extends State<YouLostScreen> {
  final recipientAddressController = TextEditingController();

  Future<TransferTokenResponse>? _transferToken;

  Future<TransferTokenResponse> transferToken() async {
    try {
      final transferToken = await okto!.transferTokens(
        networkName: 'POLYGON_TESTNET_AMOY',
        tokenAddress: '',
        quantity: '0.01',
        recipientAddress: recipientAddressController.text,
      );
      return transferToken;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text('You Lost!'),
            const Text('Better luck next time!'),
            TextField(
              controller: recipientAddressController,
              decoration: const InputDecoration(label: Text('Player 0 Polygon testnet address')),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _transferToken = transferToken();
                });
              },
              child: const Text('Transfer 0.01 Matic to Player 0'),
            ),
            _transferToken == null
                ? Container()
                : FutureBuilder<TransferTokenResponse>(
                    future: _transferToken,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator(color: Colors.black));
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final transferTokenResponse = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SelectableText(
                                'Order ID: ${transferTokenResponse.data.orderId}',
                                style: const TextStyle(color: Colors.black, fontSize: 20),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
