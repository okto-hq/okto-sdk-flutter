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
  final networkNameController = TextEditingController();
  final collectionAddressController = TextEditingController();
  final collectionNameController = TextEditingController();
  final quantityController = TextEditingController();
  final recipientAddressController = TextEditingController();
  final nftAddressController = TextEditingController();

  Future<TransferNftResponse>? _transferNft;
  Future<TransferNftResponse> transferNft() async {
    try {
      final transferNft = await okto!.transferNft(
          networkName: networkNameController.text,
          quantity: quantityController.text,
          recipientAddress: recipientAddressController.text,
          operationType: operationTypeController.text,
          collectionAddress: collectionAddressController.text,
          collectionName: collectionNameController.text,
          nftAddress: nftAddressController.text);
      return transferNft;
    } catch (e) {
      print(e.toString());
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
            TextField(
              controller: operationTypeController,
              decoration: const InputDecoration(label: Text('Operation Type')),
            ),
            TextField(
              controller: networkNameController,
              decoration: const InputDecoration(label: Text('Network Name')),
            ),
            TextField(
              controller: collectionAddressController,
              decoration: const InputDecoration(label: Text('Collection Address')),
            ),
            TextField(
              controller: collectionNameController,
              decoration: const InputDecoration(label: Text('Collection Name')),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(label: Text('Quantity')),
            ),
            TextField(
              controller: recipientAddressController,
              decoration: const InputDecoration(label: Text('Recipient Address')),
            ),
            TextField(
              controller: nftAddressController,
              decoration: const InputDecoration(label: Text('Nft address')),
            ),
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
                  : FutureBuilder<TransferNftResponse>(
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
