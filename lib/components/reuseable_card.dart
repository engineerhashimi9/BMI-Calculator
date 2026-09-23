import 'package:flutter/material.dart';


class ReuseableCard extends StatelessWidget {
  final Color clr;
  final cardChild;
  final Function ontaped;
  const ReuseableCard({
    super.key,
    required this.clr,
    this.cardChild,
    required this.ontaped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: cardChild,

        width: 160.0,
        height: 160.0,

        decoration: BoxDecoration(
          color: clr,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onTap: () {
        ontaped();
      },
    );
  }
}


