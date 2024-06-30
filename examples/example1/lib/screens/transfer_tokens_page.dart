import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class TransferTokensPage extends StatefulWidget {
  const TransferTokensPage({super.key});

  @override
  State<TransferTokensPage> createState() => _TransferTokensPageState();
}

class _TransferTokensPageState extends State<TransferTokensPage> {
  final networkNameController = TextEditingController(text: 'APTOS TESTNET');
  final tokenAddressController = TextEditingController(text: '0x2f7b97837f2d14ba2ed3a4b2282e259126a9b848');
  final quantityController = TextEditingController(text: '0.0001');
  final recipientAddressController = TextEditingController(text: '0x8ff71ae16c88d86f5ec4100951f37a50683e8cd23ca515894854fcfc4ab7399b');

  Future<TransferTokenResponse>? _transferToken;

  Future<TransferTokenResponse> transferToken() async {
    try {
      final transferToken = await okto.transferTokens(
        networkName: networkNameController.text,
        tokenAddress: tokenAddressController.text,
        quantity: quantityController.text,
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
      backgroundColor: const Color(0xff5166EE),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(40),
              child: const Text(
                'Transfer Tokens',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            TextField(controller: networkNameController),
            TextField(controller: tokenAddressController),
            TextField(controller: quantityController),
            TextField(controller: recipientAddressController),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _transferToken = transferToken();
                });
              },
              child: const Text('Transfer Token'),
            ),
            Expanded(
              child: _transferToken == null
                  ? Container()
                  : FutureBuilder<TransferTokenResponse>(
                      future: _transferToken,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final transferTokenResponse = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID: ${transferTokenResponse.data.orderId}',
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
