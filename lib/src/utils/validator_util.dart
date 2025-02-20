import 'package:okto_flutter_sdk/src/error/invalid_arguement.dart';

class ValidatorUtil {
  ValidatorUtil._();

  static void validateEmailOtp(String emailId, String otp, String token) {
    if(emailId.isEmpty) throw InvalidArgument("emailId can't be empty");
    if(otp.isEmpty) throw InvalidArgument("otp can't be empty");
    if(token.isEmpty) throw InvalidArgument("token can't be empty");
  }

  static void validatePhoneNumber(String phoneNumber) {

  }
}