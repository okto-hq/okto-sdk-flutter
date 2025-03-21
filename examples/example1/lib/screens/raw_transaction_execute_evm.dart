import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okto_sdk/network/model/evm_raw_transaction_detail.dart';

class RawTransactionExecuteEvm extends StatefulWidget {
  const RawTransactionExecuteEvm({super.key});

  @override
  State<RawTransactionExecuteEvm> createState() =>
      _RawTransactionExecuteEvmState();
}

class _RawTransactionExecuteEvmState extends State<RawTransactionExecuteEvm> {
  final networkNameController = TextEditingController();
  final dataEditController = TextEditingController();
  final fromEditController = TextEditingController();
  final toEditController = TextEditingController();
  final valueEditController = TextEditingController();

  Future<String?>? _rawTransactionExecuted;

  Future<String?> rawTransactionExecute() async {
    final transactionObject = EvmTransactions(
      data: dataEditController.text,
      from: fromEditController.text,
      to: toEditController.text,
      value: valueEditController.text,
    );
    try {
      final rawTransactionDetail = EvmRawTransactionDetail(
          caip2Id: networkNameController.text,
          transactions: [transactionObject]);
      final userOpResponse =
          await okto!.estimateTransaction(rawTransactionDetail);
      return okto!.executeTransaction(userOpResponse!.userOps!);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5166EE),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(40),
                    child: const Text(
                      'Raw Transaction Execute EVM',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 30),
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
                  Column(
                    children: [
                      TextField(
                        maxLines: null,
                        controller: dataEditController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter the data:',
                        ),
                      ),
                      TextField(
                        maxLines: null,
                        controller: dataEditController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter sender address:',
                        ),
                      ),
                      TextField(
                        maxLines: null,
                        controller: dataEditController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter receiver address:',
                        ),
                      ),
                      TextField(
                        maxLines: null,
                        controller: dataEditController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter value:',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
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
                        : FutureBuilder<String?>(
                            future: _rawTransactionExecuted,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Job id: $jobId',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            Clipboard.setData(
                                                ClipboardData(text: jobId));
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
            )
          ],
        ),
      ),
    );
  }
}
