import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_collection_creation_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_mint_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_transfer_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/token_transfer_user_operation.dart';
import 'package:okto_sdk/network/models/client/transfer_nft_model.dart';

class NftCollectionCreation extends StatefulWidget {
  const NftCollectionCreation({super.key});

  @override
  State<NftCollectionCreation> createState() => _TransferNftPageState();
}

class _TransferNftPageState extends State<NftCollectionCreation> {
  final networkIdController = TextEditingController();
  final nftNameEditController = TextEditingController();
  final collectionNameController = TextEditingController();
  final metadataUriController = TextEditingController();
  final descriptionEditController = TextEditingController();
  final nftAddressController = TextEditingController();
  final uriEditController = TextEditingController();
  final symbolEditController = TextEditingController();

  Future<String?>? _transferNft;

  Future<String?> transferNft() async {
    try {
      final nftTransfer = NftCollectionCreationDetails(
        networkId: networkIdController.text,
        name: nftNameEditController.text,
        metadataUri: metadataUriController.text,
        description: descriptionEditController.text,
        symbol: symbolEditController.text,
      );
      final userOpResponse = await okto!.estimateTransaction(nftTransfer);
      return okto!.executeTransaction(userOpResponse!.userOps!);
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
              controller: networkIdController,
              decoration: const InputDecoration(label: Text('Network Id')),
            ),
            TextField(
              controller: nftNameEditController,
              decoration: const InputDecoration(label: Text('Nft name')),
            ),
            TextField(
              controller: descriptionEditController,
              decoration: const InputDecoration(label: Text('Description')),
            ),
            TextField(
              controller: uriEditController,
              decoration: const InputDecoration(label: Text('Metadata Uri')),
            ),
            TextField(
              controller: symbolEditController,
              decoration: const InputDecoration(label: Text('Symbol')),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _transferNft = transferNft();
                });
              },
              child: const Text('Nft min'),
            ),
            Expanded(
              child: _transferNft == null
                  ? Container()
                  : FutureBuilder<String?>(
                      future: _transferNft,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final jobId = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ID: $jobId',
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
