import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okto_sdk/network/model/aptos_raw_transaction_detail.dart';

class RawTransactionExecuteAptos extends StatefulWidget {
  const RawTransactionExecuteAptos({super.key});

  @override
  State<RawTransactionExecuteAptos> createState() =>
      _RawTransactionExecuteAptosState();
}

class _RawTransactionExecuteAptosState
    extends State<RawTransactionExecuteAptos> {
  final networkNameController = TextEditingController();
  final functionNameController = TextEditingController();
  final typeArgumentsController = TextEditingController();
  final functionArgumentsController = TextEditingController();

  Future<String?>? _rawTransactionExecuted;

  Future<String?> rawTransactionExecute() async {
    final transactionObject = AptosTransaction(
      function: functionNameController.text,
      typeArguments: typeArgumentsController.text.split(','),
      functionArguments: functionArgumentsController.text.split(','),
    );
    try {
      final rawTransactionDetail = AptosRawTransactionDetail(
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
                      'Raw Transaction Execute Aptos',
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
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        maxLines: null,
                        controller: functionNameController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter the function name: ',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLines: null,
                        controller: typeArgumentsController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter the type arguments: ',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLines: null,
                        controller: functionArgumentsController,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,
                          hintText: 'Enter the function arguments',
                        ),
                      )
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
