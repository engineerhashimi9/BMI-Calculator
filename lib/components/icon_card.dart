import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config.dart';

class IconCard extends StatelessWidget {
  const IconCard({super.key, required this.label, required this.icon});
  final String label;
  final FaIconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(icon, size: 70.0),
        SizedBox(height: 10.0),
        Text(label, style: labelTextStyle),
      ],
    );
  }
}
