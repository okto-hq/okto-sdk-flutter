import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

import '../okto.dart';

class ReadContractScreen extends StatefulWidget {
  const ReadContractScreen({super.key});

  @override
  State<ReadContractScreen> createState() => _ReadContractScreenState();
}

class _ReadContractScreenState extends State<ReadContractScreen> {

  Future<ReadContractResponse>? _contractData;

  Future<ReadContractResponse> readContractData() async {
    try {
      final requestPayload = {
        "network_name": "APTOS_TESTNET",
        "data": {
          "function": "0x0000000000000000000000000000000000000000000000000000000000000001::chain_id::get",
          "typeArguments": [],
          "functionArguments": []
        }
      };
      final contractData = await okto!.readContractData(data: requestPayload);
      return contractData;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5166EE),
      body: SafeArea(child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(40),
            child: const Text(
              'Read contract data',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _contractData = readContractData();
              });
            },
            child: const Text('Read contract data'),
          ),

          Expanded(child:
              _contractData == null ? Container() : FutureBuilder<ReadContractResponse>(
                future: _contractData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final contractData = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Text('Data: '),
                          const SizedBox(height: 16,),
                          Text('Chain id: ${contractData.data.chainId}', style: const TextStyle(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              )
          )
        ],
      )),
    );
  }
}
