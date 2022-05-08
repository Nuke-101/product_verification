import 'package:flutter/material.dart';

class FlatButtonBuilder extends StatelessWidget {
  const FlatButtonBuilder({
    Key? key,
    required this.onTap,
    required this.buttonText,
    required this.color,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: StadiumBorder(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlatButton2Builder extends StatelessWidget {
  const FlatButton2Builder({
    Key? key,
    required this.onTap,
    required this.buttonText,
    required this.color,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: StadiumBorder(),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: color,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FlatButton3Builder extends StatelessWidget {
  const FlatButton3Builder({
    Key? key,
    required this.onTap,
    required this.buttonText,
    required this.color,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            width: 2,
            color: color,
          )),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
