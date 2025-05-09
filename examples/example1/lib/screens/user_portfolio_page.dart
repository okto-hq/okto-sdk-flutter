import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:okto_sdk/network/models/portfolio_data_v2.dart';

class UserPortfolioPage extends StatefulWidget {
  const UserPortfolioPage({super.key});

  @override
  State<UserPortfolioPage> createState() => _UserPortfolioPageState();
}

class _UserPortfolioPageState extends State<UserPortfolioPage> {
  Future<PortfolioDataV2?>? _userPortfolio;

  Future<PortfolioDataV2?> getuserPortfolio() async {
    try {
      final userPortfolio = await okto!.userPortfolio();
      return userPortfolio;
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
                'User Portfolio',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userPortfolio = getuserPortfolio();
                });
              },
              child: const Text('User Portfolio'),
            ),
            Expanded(
              child: _userPortfolio == null
                  ? Container()
                  : FutureBuilder<PortfolioDataV2?>(
                      future: _userPortfolio,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData && snapshot.data != null) {
                          final userPortfolio = snapshot.data!;
                          final aggregatedData = userPortfolio.aggregatedData;
                          return Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                      "holding count: ${aggregatedData?.holdingsCount}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "holding price INR: ${aggregatedData?.holdingsPriceInr}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "holding price USDT: ${aggregatedData?.holdingsPriceUsdt}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "Total holding price INR: ${aggregatedData?.totalHoldingPriceInr}"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      "Total holding price USDT: ${aggregatedData?.totalHoldingPriceUsdt}")
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              userPortfolio.groupTokens?.isNotEmpty == true
                                  ? Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.6,
                                            child: ListView.builder(
                                                itemCount: userPortfolio
                                                    .groupTokens?[0]
                                                    .tokens
                                                    ?.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    color: Colors.blue,
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SelectableText(
                                                          'Token Name: ${userPortfolio.groupTokens?[0].tokens?[index].name}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                        ),
                                                        SelectableText(
                                                          'Quantity : ${userPortfolio.groupTokens?[0].tokens?[index].balance}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                        ),
                                                        SelectableText(
                                                          'Amount In INR : ${userPortfolio.groupTokens?[0].holdingsPriceInr}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                        ),
                                                        SelectableText(
                                                          'Network Name: ${userPortfolio.groupTokens?[0].tokens?[index].networkName}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                        ),
                                                        SelectableText(
                                                          'Token Address: ${userPortfolio.groupTokens?[0].tokens?[index].tokenAddress}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                        ),
                                                        SelectableText(
                                                          'Token Image url: ${userPortfolio.groupTokens?[0].tokenImage}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          )

                                          // Add more fields here as needed
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
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
