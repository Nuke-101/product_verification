import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_verification/utils/web3_controller.dart';
import 'package:product_verification/views/widgets/buttons.dart';
import 'package:product_verification/views/widgets/colors.dart';
import 'package:product_verification/views/widgets/input.dart';

class AddProductPage extends StatelessWidget {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productBrandController = TextEditingController();
  TextEditingController productManfYrController = TextEditingController();
  TextEditingController productOriginController = TextEditingController();

  final web3Controller = Get.find<Web3Controller>();

  AddProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 0,
        title: Text(
          "Add Product to ETH Blockchain",
          style: TextStyle(
            color: defTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GetBuilder<Web3Controller>(builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    InputBuilder(
                      fieldController: productNameController,
                      inputHead: "Product Name",
                      hintText: "Enter Product Name",
                      type: "name",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputBuilder(
                      fieldController: productBrandController,
                      inputHead: "Parent Company (Brand)",
                      hintText: "Enter Parent Company",
                      type: "name",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputBuilder(
                      fieldController: productManfYrController,
                      inputHead: "Manufacturing Year",
                      hintText: "Enter Manufacturing Year",
                      type: "number",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InputBuilder(
                      fieldController: productOriginController,
                      inputHead: "Country of Origin",
                      hintText: "Enter Country of Origin",
                      type: "name",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: _.performingETHTransaction.value
                      ? const CircularProgressIndicator(
                          color: Color(0xffFFBD00),
                        )
                      : FlatButtonBuilder(
                          buttonText: "Add to Blockchain",
                          color: Color(0xffFFBD00),
                          onTap: () async {
                            await _.addProductToBlockchain(
                              productNameController.text,
                              productBrandController.text,
                              productManfYrController.text,
                              productOriginController.text,
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
