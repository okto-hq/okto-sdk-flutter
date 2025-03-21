import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_collection_creation_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_mint_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_transfer_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/token_transfer_user_operation.dart';
import 'package:okto_sdk/network/models/client/transfer_nft_model.dart';

class TransferNftMint extends StatefulWidget {
  const TransferNftMint({super.key});

  @override
  State<TransferNftMint> createState() => _TransferNftPageState();
}

class _TransferNftPageState extends State<TransferNftMint> {
  final networkIdController = TextEditingController();
  final nftNameEditController = TextEditingController();
  final collectionNameController = TextEditingController();
  final metadataUriController = TextEditingController();
  final descriptionEditController = TextEditingController();
  final nftAddressController = TextEditingController();
  final propertyNameController = TextEditingController();
  final propertyValueTypeController = TextEditingController();
  final propertyValueController = TextEditingController();

  Future<String?>? _transferNft;

  Future<String?> transferNft() async {
    try {
      final nftTransfer = NftMintDetail(
        caip2Id: networkIdController.text,
        nftName: nftNameEditController.text,
        collectionName: collectionNameController.text,
        uri: metadataUriController.text,
        description: descriptionEditController.text,
        properties: [
          NftMintMetadata(
            name: propertyNameController.text,
            valueType: propertyValueTypeController.text,
            value: propertyValueController.text,
          )
        ],
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
              controller: collectionNameController,
              decoration: const InputDecoration(label: Text('Collection Name')),
            ),
            TextField(
              controller: metadataUriController,
              decoration: const InputDecoration(label: Text('Metadata Uri')),
            ),
            TextField(
              controller: descriptionEditController,
              decoration: const InputDecoration(label: Text('Description')),
            ),
            TextField(
              controller: propertyNameController,
              decoration: const InputDecoration(label: Text('Property name')),
            ),
            TextField(
              controller: propertyValueTypeController,
              decoration: const InputDecoration(label: Text('Property value type')),
            ),
            TextField(
              controller: propertyValueController,
              decoration: const InputDecoration(label: Text('Property value')),
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
