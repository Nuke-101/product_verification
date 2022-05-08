import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_verification/utils/auth_controller.dart';
import 'package:product_verification/utils/show_password_controller.dart';
import 'package:product_verification/views/home.dart';
import 'package:product_verification/views/loginsignup/login.dart';
import 'package:product_verification/views/widgets/buttons.dart';
import 'package:product_verification/views/widgets/colors.dart';
import 'package:product_verification/views/widgets/input.dart';
import 'package:product_verification/views/widgets/password_input.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  // Toggles the password show status

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ShowPassController showPassword = Get.put(ShowPassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defBackgroundColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment(0.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40),
                        Text(
                          "Signup",
                          style: TextStyle(
                            fontSize: 30,
                            color: defTextColor,
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Create account",
                          style: TextStyle(
                            fontSize: 18,
                            color: defTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: FlatButtonBuilder(
                      buttonText: "Signup",
                      color: mango,
                      onTap: () async {
                        final String email = emailController.text.trim();
                        final String password = passwordController.text.trim();

                        // context
                        //     .read<AuthService>()
                        //     .signUp(email, password)
                        //     .then((value) async {
                        //   User? user = FirebaseAuth.instance.currentUser;
                        //   await FirebaseFirestore.instance
                        //       .collection("users")
                        //       .doc(user?.uid)
                        //       .set({
                        //     'uid': user?.uid,
                        //     "email": email,
                        //     "password": password
                        //   });
                        // });
                        AuthController.instance.registerUser(email, password);
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                fontSize: 15,
                                color: defTextColor,
                                fontFamily: "Gilroy",
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.offAll(() => LoginPage());
                                },
                              text: "Login",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
