import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class TransferNftPage extends StatefulWidget {
  const TransferNftPage({super.key});

  @override
  State<TransferNftPage> createState() => _TransferNftPageState();
}

class _TransferNftPageState extends State<TransferNftPage> {
  final operationTypeController = TextEditingController(text: 'NFT_TRANSFER');
  final networkNameController = TextEditingController(text: 'APTOS TESTNET');
  final collectionAddressController = TextEditingController(text: '0x171e643e8e8dabc66b838b9055dbdf88647cf6601b164f5987f50a497bedfbe1');
  final collectionNameController = TextEditingController(text: 'super avengers');
  final quantityController = TextEditingController(text: "1");
  final recipientAddressController = TextEditingController(text: '0x7c0c2c20facfd3a321d82da7b3c2fcd5e75a3e5d8226ce26c5533f2342e57e0b');
  final nftAddressController = TextEditingController(text: '0x719dad0b2800205ab7bff539bd617b04e21fe311bc30fce6d6d2d3beecd8a14e');

  Future<TransferTokenResponse>? _transferNft;
  Future<TransferTokenResponse> transferNft() async {
    try {
      final transferNft = await okto.transferNft(
          networkName: networkNameController.text,
          quantity: quantityController.text,
          recipientAddress: recipientAddressController.text,
          operationType: operationTypeController.text,
          collectionAddress: collectionAddressController.text,
          collectionName: collectionNameController.text,
          nftAddress: nftAddressController.text);
      return transferNft;
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
                'Transfer NFT',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            TextField(controller: operationTypeController),
            TextField(controller: networkNameController),
            TextField(controller: collectionAddressController),
            TextField(controller: collectionNameController),
            TextField(controller: quantityController),
            TextField(controller: recipientAddressController),
            TextField(controller: nftAddressController),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _transferNft = transferNft();
                });
              },
              child: const Text('Transfer NFT'),
            ),
            Expanded(
              child: _transferNft == null
                  ? Container()
                  : FutureBuilder<TransferTokenResponse>(
                      future: _transferNft,
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
                                  'Order ID: ${transferNftResponse.data.orderId}',
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
