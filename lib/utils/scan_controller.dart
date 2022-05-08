import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScanController extends GetxController {
  Future scanQR() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;

    if (cameraPermissionStatus == PermissionStatus.granted) {
      String scannedQRData = await scanner.scan() ?? "";
      return scannedQRData;
    } else if (cameraPermissionStatus == PermissionStatus.denied) {
      cameraPermissionStatus = await Permission.camera.request();
      if (cameraPermissionStatus.isGranted) {
        String scannedQRData = await scanner.scan() ?? "";
        return scannedQRData;
      }
    } else if (cameraPermissionStatus == PermissionStatus.permanentlyDenied) {
      Get.snackbar("Error Accessing Camera",
          "Camera permission denied permanently, please change from your device settings.");
      return;
    }
  }
}
