import 'package:flutter/material.dart';
import 'package:product_verification/views/widgets/colors.dart';

//STYLES

class InputBuilder extends StatelessWidget {
  const InputBuilder({
    Key? key,
    required this.fieldController,
    required this.inputHead,
    required this.hintText,
    required this.type,
  }) : super(key: key);

  final TextEditingController fieldController;
  final String inputHead;
  final String hintText;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          inputHead != null ? inputHead : "Input field",
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w500,
            color: Color(0xff131a31),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xff131a31),
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w500,
            ),
            keyboardType: type != "number"
                ? TextInputType.emailAddress
                : TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText != null ? hintText : "Input field",
              hintStyle: const TextStyle(
                fontSize: 16,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w300,
                color: Color(0xFF1A1922),
              ),
            ),
            controller: fieldController,
          ),
        ),
      ],
    );
  }
}

class LoginInputBuilder extends StatelessWidget {
  const LoginInputBuilder({
    Key? key,
    required this.fieldController,
    required this.inputHead,
    required this.hintText,
    required this.type,
  }) : super(key: key);

  final TextEditingController fieldController;
  final String inputHead;
  final String hintText;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          inputHead != null ? inputHead : "Input field",
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Gilroy",
            fontWeight: FontWeight.w500,
            color: Color(0xff131a31),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: mango.withOpacity(.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xff131a31),
              fontFamily: "Gilroy",
              fontWeight: FontWeight.w500,
            ),
            keyboardType: type != "number"
                ? TextInputType.emailAddress
                : TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText != null ? hintText : "Input field",
              hintStyle: const TextStyle(
                fontSize: 16,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w300,
                color: Color(0xFF1A1922),
              ),
            ),
            controller: fieldController,
          ),
        ),
      ],
    );
  }
}
