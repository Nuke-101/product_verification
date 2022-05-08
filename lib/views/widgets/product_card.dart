import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_verification/views/product_info_page.dart';
import 'package:product_verification/views/widgets/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.productAddress,
    required this.productName,
    required this.productBrand,
    required this.productManfYr,
    required this.productOrigin,
  }) : super(key: key);

  final String productAddress;
  final String productName;
  final String productBrand;
  final String productManfYr;
  final String productOrigin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductInfoPage(productAddress: productAddress, results: [
              productName,
              productBrand,
              productManfYr,
              productOrigin
            ]));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: white,
            boxShadow: [
              BoxShadow(
                color: defTextColor.withOpacity(.075),
                blurRadius: 10,
              )
            ]),
        child: Row(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: mango),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: QrImage(
                  data: productAddress,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    productName.length >= 20
                        ? productName.substring(0, 19) + "..."
                        : productName,
                    style: TextStyle(
                      color: defTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: mango.withOpacity(.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Brand",
                                style: TextStyle(
                                  color: defTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                productBrand.length >= 11
                                    ? productBrand.substring(0, 10) + "..."
                                    : productBrand,
                                style: TextStyle(
                                  color: defTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Country",
                                style: TextStyle(
                                  color: defTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                productOrigin.length >= 9
                                    ? productOrigin.substring(0, 8) + "..."
                                    : productOrigin,
                                style: TextStyle(
                                  color: defTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Year",
                                style: TextStyle(
                                  color: defTextColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                productManfYr,
                                style: TextStyle(
                                  color: defTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
