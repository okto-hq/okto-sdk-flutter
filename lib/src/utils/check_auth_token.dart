import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthToken {
  static bool checkExpiry(String token) {
    try {
      final jwt = JWT.decode(token);
      final expiry = jwt.payload['exp'];
      if (expiry == null) {
        throw Exception('Token does not have expiry');
      }
      final expirationTime = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
      final currentTime = DateTime.now();
      return expirationTime.isBefore(currentTime);
    } catch (e) {
      return true;
    }
  }
}
