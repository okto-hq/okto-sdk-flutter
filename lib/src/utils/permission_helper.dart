import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCamera() async {
    PermissionStatus statuses = await Permission.camera.request();
    return statuses == PermissionStatus.granted;
  }

  static Future<bool> requestMicrophone() async {
    PermissionStatus statuses = await Permission.microphone.request();
    return statuses == PermissionStatus.granted;
  }
}
