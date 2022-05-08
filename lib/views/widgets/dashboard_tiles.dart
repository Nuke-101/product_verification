import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_verification/utils/web3_controller.dart';
import 'package:product_verification/views/widgets/colors.dart';

class DashboardTiles extends StatelessWidget {
  final web3Controller = Get.find<Web3Controller>();

  DashboardTiles({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<dynamic> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 5,
      ),
      child: Row(
        children: [
          DashboardTile(
            figures: products.length.toString(),
            detail: "Customers",
            txtColor: white,
            backgroundColor: mango,
          ),
          const SizedBox(
            width: 15,
          ),
          DashboardTile(
            figures: "265k",
            detail: "Revenue (Rs)",
            txtColor: Colors.brown[900],
            backgroundColor: yellow,
          ),
        ],
      ),
    );
  }
}

class DashboardTile extends StatelessWidget {
  const DashboardTile({
    Key? key,
    required this.figures,
    required this.detail,
    required this.backgroundColor,
    required this.txtColor,
  }) : super(key: key);

  final String figures;
  final String detail;
  final Color backgroundColor;
  final Color? txtColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: backgroundColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        figures,
                        style: TextStyle(
                          color: txtColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: white.withOpacity(.25),
                    ),
                    child: Center(
                      child: Text(
                        detail,
                        style: TextStyle(
                          color: txtColor,
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
    );
  }
}
