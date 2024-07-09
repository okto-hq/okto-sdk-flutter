import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({super.key});

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  Future<WalletResponse>? _createdWallet;

  Future<WalletResponse> createWallets() async {
    try {
      final createdWallet = await okto!.createWallet();
      return createdWallet;
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
                'Create Wallet',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _createdWallet = createWallets();
                });
              },
              child: const Text('Create Wallet'),
            ),
            Expanded(
              child: _createdWallet == null
                  ? Container()
                  : FutureBuilder<WalletResponse>(
                      future: _createdWallet,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final createdWallet = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Wallet created successfully',
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: ListView.builder(
                                      itemCount: createdWallet.data.wallets.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.blue,
                                          margin: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                'Wallet adress: ${createdWallet.data.wallets[index].address}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              SelectableText(
                                                'Network name: ${createdWallet.data.wallets[index].networkName}',
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
