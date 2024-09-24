// ignore_for_file: use_build_context_synchronously

import 'package:example/okto.dart';
import 'package:example/screens/auth/login_page.dart';
import 'package:example/screens/create_wallet_page.dart';
import 'package:example/screens/order_details_nft_page.dart';
import 'package:example/screens/order_history_page.dart';
import 'package:example/screens/raw_transaction_execute_page.dart';
import 'package:example/screens/raw_transaction_status.dart';
import 'package:example/screens/supported_networks_page.dart';
import 'package:example/screens/supported_tokens_page.dart';
import 'package:example/screens/transfer_nft_page.dart';
import 'package:example/screens/transfer_tokens_page.dart';
import 'package:example/screens/user_details_page.dart';
import 'package:example/screens/user_portfolio_activity_page.dart';
import 'package:example/screens/user_portfolio_page.dart';
import 'package:example/screens/view_wallet_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                'Home Page',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 7,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UserDetailsPage()));
                        },
                        child: const Text('User Details')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateWalletPage()));
                        },
                        child: const Text('Create Wallet')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewWalletPage()));
                        },
                        child: const Text('Get Wallet')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportedNetworksPage()));
                        },
                        child: const Text('Supported Networks')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportedTokensPage()));
                        },
                        child: const Text('Supported Tokens')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPortfolioPage()));
                        },
                        child: const Text('User Portfolio')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPortfolioActivityPage()));
                        },
                        child: const Text('User Portfolio Activity')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TransferTokensPage()));
                        },
                        child: const Text('Transfer Tokens')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderHistoryPage()));
                        },
                        child: const Text('Order History')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const TransferNftPage()));
                        },
                        child: const Text('Transfer NFT')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderDetailsNftPage()));
                        },
                        child: const Text('Order Details NFT')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RawTransactioneExecutePage()));
                        },
                        child: const Text('Raw Transaction Execute')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RawTransactionStatusPage()));
                        },
                        child: const Text('Raw Transaction Status')),
                    ElevatedButton(
                        onPressed: () async {
                          await okto!.openBottomSheet(context: context);
                        },
                        child: const Text('Open BottomSheet')),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await okto!.logout();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Logout')),
          ],
        ),
      ),
    );
  }
}
