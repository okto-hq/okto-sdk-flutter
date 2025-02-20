import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/token_transfer_user_operation.dart';

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

  Future<String?>? jobId;

  Future<String?> transferToken() async {
    try {
      final transferDetail = TokenTransferDetails(
          recipientWalletAddress: '0x54321',
          networkId: 'eip155:137',
          tokenAddress: '',
          amount: 10000000000000000);
      // final userOpResponse = await okto!.estimateTransaction(transferDetail);

      // final userOpFromApi = (await okto!.estimateTransaction(nftTransfer))!.userOps!;
      final userOpFromSdk = await TokenTransferUserOperation(details: transferDetail).userOp;
      return okto!.executeTransaction(userOpFromSdk);
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
                  jobId = transferToken();
                });
              },
              child: const Text('Transfer Token'),
            ),
            Expanded(
              child: jobId == null
                  ? Container()
                  : FutureBuilder<String?>(
                      future: jobId,
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
                                SelectableText(
                                  'Job ID: $jobId',
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
