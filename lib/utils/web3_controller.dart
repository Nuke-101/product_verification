import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Web3Controller extends GetxController {
  late Client httpClient;
  late Web3Client ethClient;
  RxBool performingETHTransaction = false.obs;
  final myAddress = "0xF3F4369A2C14D85CC96278f7cFEC16812c6adCA9";
  final _privateKey =
      "8d060e4ca7620a1340e5dc3d2ae2c2a02099b67ab1981c979f66708b8fe52aca";
  late final EthPrivateKey _credentials;

  late final String productName;
  late final String productBrand;
  late final String productManfYr;
  late final String productOrigin;

  @override
  void onInit() async {
    super.onInit();
    httpClient = Client();
    ethClient = Web3Client(
        "https://rinkeby.infura.io/v3/542073ed8c374b9bbcbf248104b7abf4",
        httpClient);
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<DeployedContract> loadFactoryContract() async {
    String abi = await rootBundle.loadString("assets/productfactory.json");
    EthereumAddress contractAddress =
        EthereumAddress.fromHex("0xEc8bF6d065b263a0A7A55B17C56C07E42C9FccD7");
    final contract = DeployedContract(
      ContractAbi.fromJson(abi, "ProductFactory"),
      contractAddress,
    );
    return contract;
  }

  Future<DeployedContract> loadProductContract(String address) async {
    String abi = await rootBundle.loadString("assets/product.json");
    EthereumAddress contractAddress = EthereumAddress.fromHex(address);
    final contract = DeployedContract(
      ContractAbi.fromJson(abi, "Product"),
      contractAddress,
    );
    return contract;
  }

  query(String functionName, List<dynamic> args) async {
    final contract = await loadFactoryContract();
    final ethFunction = contract.function(functionName);
    final result =
        ethClient.call(contract: contract, function: ethFunction, params: args);

    return result;
  }

  Future<void> addProductToBlockchain(
    String productName,
    String productCompany,
    String productManfYr,
    String productOrigin,
  ) async {
    performingETHTransaction = true.obs;

    final contract = await loadFactoryContract();
    try {
      ethClient.sendTransaction(
        _credentials,
        Transaction.callContract(
          contract: contract,
          function: contract.function("createProduct"),
          parameters: [
            productName,
            productCompany,
            productManfYr,
            productOrigin,
          ],
        ),
        chainId: 4,
      );
      print("added");
      performingETHTransaction = false.obs;
      return;
    } catch (err) {
      print(err);
      return;
    }
  }

  Future<List<dynamic>> getProducts() async {
    final DeployedContract productFactory = await loadFactoryContract();
    final ContractFunction getProducts = productFactory.function("getProducts");
    List res = await ethClient
        .call(contract: productFactory, function: getProducts, params: []);

    List addresses = res[0];
    return addresses;
  }

  Future<List<dynamic>> getData(String address) async {
    final DeployedContract productFactory = await loadFactoryContract();
    final ContractFunction getProducts = productFactory.function("getProducts");
    List res = await ethClient
        .call(contract: productFactory, function: getProducts, params: []);

    List addresses = res[0];

    if (address.length == 42) {
      final data = addresses.contains(EthereumAddress.fromHex(address));
      if (data) {
        final DeployedContract productContract =
            await loadProductContract(address);
        final ContractFunction getSummary =
            productContract.function("getSummary");
        final result = await ethClient
            .call(contract: productContract, function: getSummary, params: []);
        return result;
      }
    }
    return [];
  }
}
