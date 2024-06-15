import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class UserPortfolioActivityPage extends StatefulWidget {
  const UserPortfolioActivityPage({super.key});

  @override
  State<UserPortfolioActivityPage> createState() => _UserPortfolioActivityPageState();
}

class _UserPortfolioActivityPageState extends State<UserPortfolioActivityPage> {
  Future<UserPortfolioActivityResponse>? _userPortfolioActivity;

  Future<UserPortfolioActivityResponse> getuserPortfolioActivity() async {
    try {
      final userPortfolioActivity = await okto.getUserPortfolioActivity();
      return userPortfolioActivity;
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
                'User Portfolio Activity',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userPortfolioActivity = getuserPortfolioActivity();
                });
              },
              child: const Text('User Portfolio Activity'),
            ),
            Expanded(
              child: _userPortfolioActivity == null
                  ? Container()
                  : FutureBuilder<UserPortfolioActivityResponse>(
                      future: _userPortfolioActivity,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final userPortfolioActivity = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: ListView.builder(
                                      itemCount: userPortfolioActivity.data.activity.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.blue,
                                          margin: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Symbol : ${userPortfolioActivity.data.activity[index].symbol}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Name : ${userPortfolioActivity.data.activity[index].name}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Short Name : ${userPortfolioActivity.data.activity[index].shortName}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'ID : ${userPortfolioActivity.data.activity[index].id}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Description : ${userPortfolioActivity.data.activity[index].description}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Quantity : ${userPortfolioActivity.data.activity[index].quantity}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Order Type : ${userPortfolioActivity.data.activity[index].orderType}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Transfer Type: ${userPortfolioActivity.data.activity[index].transferType}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Status: ${userPortfolioActivity.data.activity[index].status}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Timestamp: ${userPortfolioActivity.data.activity[index].timestamp}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Tx-Hash: ${userPortfolioActivity.data.activity[index].txHash}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Network Id: ${userPortfolioActivity.data.activity[index].networkId}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Network Name: ${userPortfolioActivity.data.activity[index].networkName}',
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
