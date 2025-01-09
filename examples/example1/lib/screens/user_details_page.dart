import 'package:example/okto.dart';
import 'package:flutter/material.dart';
import 'package:okto_sdk/network/models/client/user_model.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  Future<UserData>? _userDetails;

  Future<UserData> fetchUserDetails() async {
    try {
      final userDetails = await okto!.userDetails();
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
                'User Details',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 30),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userDetails = fetchUserDetails();
                });
              },
              child: const Text('Get User Details'),
            ),
            Expanded(
              child: _userDetails == null
                  ? Container()
                  : FutureBuilder<UserData>(
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
                                  'Email: ${userDetails.email}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SelectableText(
                                  'Created At: ${userDetails.createdAt}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SelectableText(
                                  'Freezed: ${userDetails.freezed.toString()}',
                                  style: const TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                SelectableText(
                                  'Freezed Reason: ${userDetails.freezeReason}',
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
