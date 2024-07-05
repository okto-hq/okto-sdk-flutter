import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class RawTransactionStatusPage extends StatefulWidget {
  const RawTransactionStatusPage({super.key});

  @override
  State<RawTransactionStatusPage> createState() => _RawTransactionStatusPageState();
}

class _RawTransactionStatusPageState extends State<RawTransactionStatusPage> {
  final jobIdController = TextEditingController();
  Future<RawTransactionStatusResponse>? _rawTransactionStatus;

  Future<RawTransactionStatusResponse> rawTransactionStatus() async {
    try {
      final rawTransaction = await okto!.rawTransactionStatus(orderId: jobIdController.text);
      return rawTransaction;
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
                'Raw Transaction Status',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            TextField(
              controller: jobIdController,
              decoration: const InputDecoration(hintText: 'Paste Job id'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _rawTransactionStatus = rawTransactionStatus();
                });
              },
              child: const Text('View status'),
            ),
            Expanded(
              child: _rawTransactionStatus == null
                  ? Container()
                  : FutureBuilder<RawTransactionStatusResponse>(
                      future: _rawTransactionStatus,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final rawTransaction = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: ListView.builder(
                                      itemCount: rawTransaction.data.jobs.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.blue,
                                          margin: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Network name: ${rawTransaction.data.jobs[index].networkName}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Order Id : ${rawTransaction.data.jobs[index].orderId}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Status : ${rawTransaction.data.jobs[index].status}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Transaction Hash : ${rawTransaction.data.jobs[index].transactionHash}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )

                                // Add more fields here as needed
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
