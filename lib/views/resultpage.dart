import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ResultPage extends StatelessWidget {
  const ResultPage(
      {Key? key, required this.productAddress, required this.results})
      : super(key: key);

  final String productAddress;
  final List<dynamic> results;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Scan Results"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Center(
                child: QrImage(
                  data: productAddress,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Container(
                width: double.infinity,
                child: results.isEmpty
                    ? const Center(
                        child: Text("No Product found on this address"),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.green,
                              ),
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.shield_rounded,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Product Verified",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              ProductInfoTile(
                                tileName: "Product Name",
                                info: results[0],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ProductInfoTile(
                                tileName: "Product Company",
                                info: results[1],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              ProductInfoTile(
                                tileName: "Product Manufacture Year",
                                info: results[2],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ProductInfoTile(
                                tileName: "Product Origin",
                                info: results[3],
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductInfoTile extends StatelessWidget {
  const ProductInfoTile({
    Key? key,
    required this.info,
    required this.tileName,
  }) : super(key: key);

  final String info;
  final String tileName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                .04,
              ),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tileName,
              style: const TextStyle(
                color: Color(0xFF010101),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              info,
              style: const TextStyle(
                color: Color(0xFF010101),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
