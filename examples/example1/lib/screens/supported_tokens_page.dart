import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class SupportedTokensPage extends StatefulWidget {
  const SupportedTokensPage({super.key});

  @override
  State<SupportedTokensPage> createState() => _SupportedTokensPageState();
}

class _SupportedTokensPageState extends State<SupportedTokensPage> {
  Future<TokenResponse>? _supportedTokens;

  Future<TokenResponse> getSupportedTokens() async {
    try {
      final supportedTokens = await okto!.supportedTokens();
      return supportedTokens;
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
                'View Supported Tokens',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _supportedTokens = getSupportedTokens();
                });
              },
              child: const Text('Supported Tokens'),
            ),
            Expanded(
              child: _supportedTokens == null
                  ? Container()
                  : FutureBuilder<TokenResponse>(
                      future: _supportedTokens,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final supportedTokens = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: ListView.builder(
                                      itemCount: supportedTokens.data.tokens.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.blue,
                                          margin: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SelectableText(
                                                'Network name: ${supportedTokens.data.tokens[index].networkName}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              SelectableText(
                                                'Token address : ${supportedTokens.data.tokens[index].tokenAddress}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                               SelectableText(
                                                'Token name : ${supportedTokens.data.tokens[index].tokenName}',
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
