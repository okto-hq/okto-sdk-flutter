import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/network/models/order_response_v2.dart';

class TransferTokensPage extends StatefulWidget {
  const TransferTokensPage({super.key});

  @override
  State<TransferTokensPage> createState() => _TransferTokensPageState();
}

class _TransferTokensPageState extends State<TransferTokensPage> {
  final networkNameController = TextEditingController();
  final tokenAddressController = TextEditingController();
  final quantityController = TextEditingController();
  final recipientAddressController = TextEditingController();

  Future<OrderResponseV2?>? _transferToken;

  Future<OrderResponseV2?> transferToken() async {
    try {
      final transferToken = await okto!.transferTokens(
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
            TextField(
              controller: networkNameController,
              decoration: const InputDecoration(label: Text('Network Name')),
            ),
            TextField(
              controller: tokenAddressController,
              decoration: const InputDecoration(label: Text('Token Address (Not mandatory)')),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(label: Text('Quantity')),
            ),
            TextField(
              controller: recipientAddressController,
              decoration: const InputDecoration(label: Text('Recipient Address')),
            ),
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
                  : FutureBuilder<OrderResponseV2?>(
                      future: _transferToken,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final transferTokenResponse = snapshot.data!;
                          return const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SelectableText(
                                //   'Order ID: ${transferTokenResponse.data.orderId}',
                                //   style: const TextStyle(color: Colors.white, fontSize: 20),
                                // ),
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
