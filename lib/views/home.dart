import 'dart:ui';

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
import 'package:product_verification/views/widgets/colors.dart';
import 'package:product_verification/views/widgets/dashboard_tiles.dart';
import 'package:product_verification/views/widgets/product_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  final scanController = Get.find<ScanController>();

  final web3Controller = Get.find<Web3Controller>();
  final String contractAddress = "0xEc8bF6d065b263a0A7A55B17C56C07E42C9FccD7";

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    web3Controller.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text(
          "Product Authentication",
          style: TextStyle(
            color: defTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AuthController.instance.logOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Color.fromARGB(255, 48, 18, 7),
              )),
          SizedBox(
            height: 40,
            width: 40,
            child: FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.center,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () async {
          String scannedData = await scanController.scanQR();
          List<dynamic> scannedResult =
              await web3Controller.getData(scannedData);
          await Get.to(() => ResultPage(
                productAddress: scannedData,
                results: scannedResult,
              ));
        },
        child: Container(
          width: 140,
          height: 50,
          decoration: BoxDecoration(
              color: mango,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: mango.withOpacity(.5),
                  blurRadius: 15,
                )
              ]),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.qr_code_outlined,
                color: white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Scan QR',
                style: TextStyle(
                  fontSize: 16,
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SmartRefresher(
        physics: BouncingScrollPhysics(),
        enablePullDown: true,
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: GetBuilder<Web3Controller>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 5,
                    ),
                    child: Text(
                      "Dashboard",
                      style: TextStyle(
                        color: defTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: mango,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: FutureBuilder(
                                              future: controller.getProducts(),
                                              builder: (context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.done) {
                                                  return Text(
                                                    snapshot.data.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: brown,
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  );
                                                } else {
                                                  return CircularProgressIndicator(
                                                    color: brown,
                                                  );
                                                }
                                              }),
                                        ),
                                      ),
                                      Container(
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: white.withOpacity(.45),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Products",
                                            style: TextStyle(
                                              color: brown,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 10.0, sigmaY: 10.0),
                                child: Container(
                                  // padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(width: 2, color: white),
                                    color: white,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.to(AddProductPage());
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: mango.withOpacity(.55),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.add,
                                                    size: 18,
                                                    color: brown,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Add Product",
                                                    style: TextStyle(
                                                      color: brown,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Contract Address",
                                        style: TextStyle(
                                          color: brown,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: mango,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "0xEc8b......ccD7",
                                            style: TextStyle(
                                              color: brown,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 5,
                    ),
                    child: Text(
                      "All Products",
                      style: TextStyle(
                        color: defTextColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: controller.getProducts(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data.length == 0) {
                            return const SizedBox(
                              height: 100,
                              child: Center(
                                child:
                                    Text("No Products found on the Blockchain"),
                              ),
                            );
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                children: [
                                  for (int i = 0; i < snapshot.data.length; i++)
                                    FutureBuilder(
                                        future: controller.getData(
                                            snapshot.data[i].toString()),
                                        builder:
                                            (context, AsyncSnapshot snapshot2) {
                                          if (snapshot2.connectionState ==
                                              ConnectionState.done) {
                                            return ProductCard(
                                              productAddress:
                                                  snapshot.data[i].toString(),
                                              productName:
                                                  snapshot2.data[0].toString(),
                                              productBrand:
                                                  snapshot2.data[1].toString(),
                                              productManfYr:
                                                  snapshot2.data[2].toString(),
                                              productOrigin:
                                                  snapshot2.data[3].toString(),
                                            );
                                          } else {
                                            return const SizedBox(
                                              height: 100,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            );
                                          }
                                        }),
                                ],
                              ),
                            );
                          }
                        } else {
                          return const SizedBox(
                            height: 100,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
