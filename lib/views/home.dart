import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:product_verification/utils/web3controller.dart';
import 'package:product_verification/views/addproductpage.dart';
import 'package:product_verification/views/resultpage.dart';
import 'package:product_verification/views/widgets/buttons.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final web3Controller = Get.put(Web3Controller());

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseAuth.instance.signOut();
  // }

  Future _scanQR() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Authentication"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Color.fromARGB(255, 48, 18, 7),
              ))
        ],
      ),
      body: GetBuilder<Web3Controller>(builder: (controller) {
        return SingleChildScrollView(
          child: Container(
            height: 500,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton3Builder(
                      buttonText: "Add Product",
                      color: Color(0xffFFBD00),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProductPage()),
                        );
                        ;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FlatButton2Builder(
                      buttonText: "Scan QR",
                      color: Color(0xffFFBD00),
                      onTap: () async {
                        String scannedData = await _scanQR();
                        List<dynamic> scannedResult =
                            await controller.getData(scannedData);
                        await Get.to(() => ResultPage(
                              productAddress: scannedData,
                              results: scannedResult,
                            ));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
