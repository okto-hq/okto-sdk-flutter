import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/nft_transfer_user_operation.dart';
import 'package:okto_sdk/core/sdk_client/user_operation/token_transfer_user_operation.dart';
import 'package:okto_sdk/network/models/order_response_v2.dart';
import 'package:okto_sdk/network/models/user_op_data.dart';
import 'package:okto_sdk/util/conversion_utility.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({super.key});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {

  Future<UserOpData?>? _estimateResponse;

  Future<OrderResponseV2?>? _executeTransaction;

  Future<UserOpData?>? estimate() async {
    try {
      final transferDetail = TokenTransferDetails(
          recipientWalletAddress: "0xff90C06e1fA92A9B7Dd95E7FBA9F7FC4d518058d",
          networkId: "eip155:137",
          tokenAddress: "",
          amount: 0.01);

      print("Amount in wei: ${ConversionUtility.numToWei(0.01)}");
      final userOpResponse = await okto!.estimateTransaction(transferDetail).then((value) {
        print(value.toString());
        return value;
      }).onError((e,s) {
        print("$e $s");
      });
      return userOpResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<OrderResponseV2?> execute() async {
    try {
      final userOpData = await _estimateResponse;
      okto!.executeTransaction(userOpData!.userOps!).then((value) {
        print(value.toString());
      }).onError((e,s) {
        print("$e $s");
      });
    } catch (e) {
      throw Exception(e);
    }
    return null;
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
                'Estimate',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
               _estimateResponse = estimate();
              },
              child: const Text('Estimate'),
            ),
            Container(
              child: _estimateResponse == null
                  ? Container()
                  : FutureBuilder<UserOpData?>(
                      future: _estimateResponse,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final userOp = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Estimate successfully',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: Text(userOp.toString())
                                )
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
            ),

            ElevatedButton(
              onPressed: () {
                _executeTransaction =  execute();
              },
              child: const Text('Execute'),
            ),

            Text('Execute Transaction: $_executeTransaction')
          ],
        ),
      ),
    );
  }
}
