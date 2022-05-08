import 'package:flutter/material.dart';

//GETX CONTROLLERS
import 'package:get/get.dart';
import 'package:product_verification/utils/show_password_controller.dart';
import 'package:product_verification/views/widgets/customIcons.dart';
import 'package:product_verification/views/widgets/colors.dart';

//STYLES

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required this.passwordController,
    required this.showPassword,
  }) : super(key: key);

  final TextEditingController passwordController;
  final ShowPassController showPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff131a31),
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: mango.withOpacity(.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: GetBuilder<ShowPassController>(
            init: ShowPassController(),
            builder: (_) {
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 45),
                    child: TextFormField(
                      obscureText: _.invisible,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff131a31),
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF1A1922),
                        ),
                      ),
                      controller: passwordController,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 6.5,
                    child: GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        showPassword.showPass(details);
                      },
                      onTapUp: (TapUpDetails details) {
                        showPassword.hidePass(details);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: mango.withOpacity(.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: _.invisible
                              ? Icon(
                                  CustomIcons.eye,
                                  size: 17,
                                  color: Color(0xFF1A1922).withOpacity(.5),
                                )
                              : Icon(
                                  CustomIcons.eye_off,
                                  size: 17,
                                  color: Color(0xFF1A1922).withOpacity(.5),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
