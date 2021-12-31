import 'package:flutter/material.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';

class NeuSingleCurvedCard extends StatelessWidget {
  final Widget child;
  NeuSingleCurvedCard({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColorScheme.bgColor,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: AppColorScheme.darkShadowColor,
                offset: Offset(15, 15),
                blurRadius: 10,
                spreadRadius: 0),
          ]),
      child: this.child,
    );
  }
}
