import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:product_verification/utils/auth_controller.dart';
import 'package:product_verification/utils/scan_controller.dart';
import 'package:product_verification/utils/web3_controller.dart';
import 'package:product_verification/views/addproductpage.dart';
import 'package:product_verification/views/resultpage.dart';
import 'package:product_verification/views/widgets/buttons.dart';

class HomePage extends StatelessWidget {
  final web3Controller = Get.find<Web3Controller>();

  final scanController = Get.find<ScanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Authentication"),
        actions: [
          IconButton(
              onPressed: () {
                AuthController.instance.logOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Color.fromARGB(255, 48, 18, 7),
              ))
        ],
      ),
      body: GetBuilder<Web3Controller>(builder: (controller) {
        return SingleChildScrollView(
          child: SizedBox(
            height: 500,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButtonwithBorderBuilder(
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
                        String scannedData = await scanController.scanQR();
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
