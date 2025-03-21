import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_collection_creation_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_transfer_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/token_transfer_user_operation.dart';
import 'package:okto_sdk/network/models/client/transfer_nft_model.dart';

class TransferNftPage extends StatefulWidget {
  const TransferNftPage({super.key});

  @override
  State<TransferNftPage> createState() => _TransferNftPageState();
}

class _TransferNftPageState extends State<TransferNftPage> {
  final networkIdController = TextEditingController();
  final nftIdEditController = TextEditingController();
  final collectionAddressController = TextEditingController();
  final quantityController = TextEditingController();
  final recipientAddressController = TextEditingController();
  final nftAddressController = TextEditingController();
  final nftTypeController = TextEditingController();

  Future<String?>? _transferNft;

  Future<String?> transferNft() async {
    try {
      // caip2Id: 'eip155:137',
      // nftId: '1',
      // recipientWalletAddress: '0xEE54970770DFC6cA138D12e0D9Ccc7D20b899089',
      // amount: "1",
      // nftType: 'ERC721',
      // collectionAddress: '0x9501f6020b0cf374918ff3ea0f2817f8fbdd0762'

      if (recipientAddressController.text.isEmpty ||
          networkIdController.text.isEmpty ||
          quantityController.text.isEmpty ||
          nftIdEditController.text.isEmpty ||
          nftTypeController.text.isEmpty ||
          collectionAddressController.text.isEmpty) {
        throw Exception('Please fill all the details');
      }

      final nftTransfer = NftTransferDetails(
          caip2Id: networkIdController.text,
          nftId: nftIdEditController.text,
          recipientWalletAddress: recipientAddressController.text,
          amount: quantityController.text,
          nftType: nftTypeController.text,
          collectionAddress: collectionAddressController.text
      );
      // final userOpFromApi = (await okto!.estimateTransaction(nftTransfer))!.userOps!;
      final userOpFromSdk = await NftUserOperation(details: nftTransfer).userOp;
      return okto!.executeTransaction(userOpFromSdk);
    } catch (e, s) {
      print("$e, $s");
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
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 30),
              ),
            ),
            TextField(
              controller: networkIdController,
              decoration: const InputDecoration(label: Text('Network Id')),
            ),
            TextField(
              controller: nftIdEditController,
              decoration: const InputDecoration(label: Text('Nft id')),
            ),
            TextField(
              controller: collectionAddressController,
              decoration:
                  const InputDecoration(label: Text('Collection Address')),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(label: Text('Quantity')),
            ),
            TextField(
              controller: recipientAddressController,
              decoration:
                  const InputDecoration(label: Text('Recipient Address')),
            ),
            TextField(
              controller: nftTypeController,
              decoration: const InputDecoration(label: Text('Nft type')),
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
                  : FutureBuilder<String?>(
                      future: _transferNft,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final jobId = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID: $jobId',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
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
