import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class RawTransactioneExecutePage extends StatefulWidget {
  const RawTransactioneExecutePage({super.key});

  @override
  State<RawTransactioneExecutePage> createState() => _RawTransactioneExecutePageState();
}

class _RawTransactioneExecutePageState extends State<RawTransactioneExecutePage> {
  final networkNameController = TextEditingController();
  final transactionObjectController = TextEditingController();
  Future<RawTransactionExecuteResponse>? _rawTransactionExecuted;

  Future<RawTransactionExecuteResponse> rawTransactionExecute() async {
    final transactionObject = {
      'transaction': transactionObjectController.text
    };
    try {
      final orderHistory = await okto!.rawTransactionExecute(networkName: networkNameController.text, transaction: transactionObject);
      return orderHistory;
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
                'Raw Transaction Execute',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            TextField(
              controller: networkNameController,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: 'Network Name',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: TextField(
                maxLines: null,
                controller: transactionObjectController,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Enter the transaction JSON for the network',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _rawTransactionExecuted = rawTransactionExecute();
                });
              },
              child: const Text('Execute Raw Transaction'),
            ),
            Expanded(
              child: _rawTransactionExecuted == null
                  ? Container()
                  : FutureBuilder<RawTransactionExecuteResponse>(
                      future: _rawTransactionExecuted,
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
                                  'Job id: ${transferNftResponse.data.jobId}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      Clipboard.setData(ClipboardData(text: transferNftResponse.data.jobId));
                                    },
                                    child: const Text('Copy job id'))
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
