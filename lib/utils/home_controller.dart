import 'package:get/get.dart';
import 'package:product_verification/utils/web3_controller.dart';

class HomeController extends GetxController {
  final web3Controller = Get.find<Web3Controller>();

  late final List<dynamic> products;

  @override
  void onInit() async {
    super.onInit();
    products = await web3Controller.getProducts();
  }
}
