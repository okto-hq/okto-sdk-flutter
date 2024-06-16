import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_flutter_sdk/okto_flutter_sdk.dart';

class OrderDetailsNftPage extends StatefulWidget {
  const OrderDetailsNftPage({super.key});

  @override
  State<OrderDetailsNftPage> createState() => _OrderDetailsNftPageState();
}

class _OrderDetailsNftPageState extends State<OrderDetailsNftPage> {
  Future<OrderDetailsNftResponse>? _orderDetailsNft;

  Future<OrderDetailsNftResponse> getOrderDetailsNft() async {
    try {
      final orderDetails = await okto.orderDetailsNft();
      return orderDetails;
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
                'Order Details NFT',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _orderDetailsNft = getOrderDetailsNft();
                });
              },
              child: const Text('Order Details NFT'),
            ),
            Expanded(
              child: _orderDetailsNft == null
                  ? Container()
                  : FutureBuilder<OrderDetailsNftResponse>(
                      future: _orderDetailsNft,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final orderDetails = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 0.6,
                                  child: ListView.builder(
                                      itemCount: orderDetails.data.nfts.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          color: Colors.blue,
                                          margin: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Collection Address: ${orderDetails.data.nfts[index].collectionAddress}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Collection Id : ${orderDetails.data.nfts[index].collectionId}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Collection Image : ${orderDetails.data.nfts[index].collectionImage}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Collection Name : ${orderDetails.data.nfts[index].collectionName}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Description : ${orderDetails.data.nfts[index].desctiption}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Explorer Smart Contract Url: ${orderDetails.data.nfts[index].explorerSmartContractUrl}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Id : ${orderDetails.data.nfts[index].id}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Network Id: ${orderDetails.data.nfts[index].networkId}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Network Name: ${orderDetails.data.nfts[index].networkName}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Nft Name: ${orderDetails.data.nfts[index].nftName}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Nft Token Id: ${orderDetails.data.nfts[index].nftTokenId}',
                                                style: const TextStyle(color: Colors.white, fontSize: 20),
                                              ),
                                              Text(
                                                'Type: ${orderDetails.data.nfts[index].type}',
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
