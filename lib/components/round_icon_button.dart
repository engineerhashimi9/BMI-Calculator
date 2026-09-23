import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class RoundIconButton extends StatelessWidget {
  final FaIconData child;
  final VoidCallback ontap;
  const RoundIconButton({super.key, required this.child, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: ontap,
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4E5F),
      constraints: BoxConstraints().tighten(width: 50.0, height: 50.0),
      elevation: 0.0,
      child: FaIcon(child),
    );
  }
}