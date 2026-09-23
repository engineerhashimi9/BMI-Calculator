import 'package:flutter/material.dart';
import '../config.dart';
class BottomButton extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  const BottomButton({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        color: bottomContainerColor,
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 60,
        child: Center(child: Text(text, style: bottomTextStyle)),
      ),
    );
  }
}
