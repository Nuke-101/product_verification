import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_verification/utils/auth_controller.dart';
import 'package:product_verification/utils/scan_controller.dart';
import 'package:product_verification/utils/show_password_controller.dart';
import 'package:product_verification/utils/web3_controller.dart';
import 'package:product_verification/views/home.dart';
import 'package:product_verification/views/loginsignup/signup.dart';
import 'package:product_verification/views/resultpage.dart';
import 'package:product_verification/views/widgets/buttons.dart';
import 'package:product_verification/views/widgets/colors.dart';
import 'package:product_verification/views/widgets/input.dart';
import 'package:product_verification/views/widgets/password_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  // Toggles the password show status

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ShowPassController showPassword = Get.put(ShowPassController());

  final web3Controller = Get.find<Web3Controller>();
  final scanController = Get.find<ScanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defBackgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment(0.0, 0.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 40),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 30,
                          color: defTextColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Access account",
                        style: TextStyle(
                          fontSize: 18,
                          color: defTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LoginInputBuilder(
                        fieldController: emailController,
                        inputHead: "Email",
                        hintText: "Enter email",
                        type: "email",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PasswordInput(
                        passwordController: passwordController,
                        showPassword: showPassword,
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     RichText(
                      //       text: TextSpan(
                      //         recognizer: TapGestureRecognizer()
                      //           ..onTap = () {
                      //             print("Forgot pass");
                      //           },
                      //         text: "Forgot Password?",
                      //         style: TextStyle(
                      //           fontSize: 15,
                      //           color: fontColorLightSub,
                      //           fontFamily: "Gilroy",
                      //           fontWeight: FontWeight.w400,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FlatButtonBuilder(
                    buttonText: "Login",
                    color: mango,
                    onTap: () async {
                      final String email = emailController.text.trim();
                      final String password = passwordController.text.trim();

                      //context.read<AuthService>().login(email, password);
                      AuthController.instance.loginUser(email, password);
                    },
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 15,
                              color: defTextColor,
                              fontFamily: "Gilroy",
                            ),
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAll(() => SignUpPage());
                              },
                            text: "Register",
                            style: TextStyle(
                              fontSize: 15,
                              color: defTextColor,
                              fontFamily: "Gilroy",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Not a manufacturer? ",
                            style: TextStyle(
                              fontSize: 15,
                              color: defTextColor,
                              fontFamily: "Gilroy",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: FlatIconButtonBuilder(
                    width: 150,
                    icon: Icons.qr_code_2_outlined,
                    buttonText: "Scan QR",
                    onTap: () async {
                      String scannedData = await scanController.scanQR();
                      List<dynamic> scannedResult =
                          await web3Controller.getData(scannedData);
                      await Get.to(() => ResultPage(
                            productAddress: scannedData,
                            results: scannedResult,
                          ));
                    },
                    iconColor: Colors.white,
                    color: mango,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
