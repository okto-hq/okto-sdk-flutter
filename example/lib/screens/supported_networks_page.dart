import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class SupportedNetworksPage extends StatefulWidget {
  const SupportedNetworksPage({super.key});

  @override
  State<SupportedNetworksPage> createState() => _SupportedNetworksPageState();
}

class _SupportedNetworksPageState extends State<SupportedNetworksPage> {
  Future<NetworkDetails>? _supportedNetworks;

  Future<NetworkDetails> getSupportedNetworks() async {
    try {
      final supportedNetworls = await okto.supportedNetworks();
      return supportedNetworls;
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
                'View Supported Networks',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _supportedNetworks = getSupportedNetworks();
                });
              },
              child: const Text('Supported Wallet'),
            ),
            Expanded(
              child: _supportedNetworks == null
                  ? Container()
                  : FutureBuilder<NetworkDetails>(
                      future: _supportedNetworks,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final supportedNetworls = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: ListView.builder(
                                      itemCount: supportedNetworls.data.network.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.blue,
                                          margin: const EdgeInsets.all(5),
                                          child: ListTile(
                                            title: Text(
                                              'Network name: ${supportedNetworls.data.network[index].networkName}',
                                              style: const TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                            subtitle: Text(
                                              'Chain ID : ${supportedNetworls.data.network[index].chainId}',
                                              style: const TextStyle(color: Colors.white, fontSize: 20),
                                            ),
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
