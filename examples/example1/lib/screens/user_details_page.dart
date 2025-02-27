import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/network/models/user_session_info.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  Future<UserSessionInfo?>? _userDetails;

  Future<UserSessionInfo?> fetchUserDetails() async {
    try {
      final userDetails = await okto!.verifyUserSession();
      return userDetails;
    } catch (e) {
      rethrow;
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
                'User session',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userDetails = fetchUserDetails();
                });
              },
              child: const Text('Verify user session'),
            ),
            Expanded(
              child: _userDetails == null
                  ? Container()
                  : FutureBuilder<UserSessionInfo?>(
                      future: _userDetails,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(color: Colors.white));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          final userDetails = snapshot.data!;
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText(
                                  'User ID: ${userDetails.userId}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Client Id: ${userDetails.clientId}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SelectableText(
                                  'User swa: ${userDetails.userSwa}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SelectableText(
                                  'Client SWA: ${userDetails.clientSwa}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SelectableText(
                                  'Is session added: ${userDetails.isSessionAdded}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
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
