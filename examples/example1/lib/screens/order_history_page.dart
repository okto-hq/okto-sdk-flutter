import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';
import 'package:okto_sdk/network/models/client/order_history_model_v2.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  Future<OrderHistoryDataV2?>? _orderHistory;

  Future<OrderHistoryDataV2?> getOrderHistory() async {
    try {
      final orderHistory = await okto!.orderHistory();
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
                'Order History',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _orderHistory = getOrderHistory();
                });
              },
              child: const Text('Order History'),
            ),
            Expanded(
              child: _orderHistory == null
                  ? Container()
                  : FutureBuilder<OrderHistoryDataV2?>(
                      future: _orderHistory,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final orderHistory = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('Status: ${orderHistory.status}'),
                                Text('Total: ${orderHistory.count}'),
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: ListView.builder(
                                      // itemCount: orderHistory.data.jobs.length,
                                    itemCount: 10,
                                      itemBuilder: (context, index) {
                                      OrderHistoryItemV2? item = orderHistory.items![index];
                                        return Container(
                                          color: Colors.blue,
                                          margin: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Network Name: ${item.networkName ?? ''}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Order Id : ${item.orderId ?? ''}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Order Type : ${item.intentType ?? ''}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Status : ${item.status ?? ''}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Transaction Hash: ${item.transactionHash ?? ''}',
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
