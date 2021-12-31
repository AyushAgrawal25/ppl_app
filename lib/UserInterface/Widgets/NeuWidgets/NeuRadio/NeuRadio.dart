import 'package:flutter/material.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuButton/NeuButton.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';

class NeuRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final Widget child;
  final Function(String value) onChange;

  NeuRadio(
      {required this.value,
      required this.groupValue,
      required this.onChange,
      required this.child});
  @override
  Widget build(BuildContext context) {
    if (value != groupValue) {
      return NeuButton(
          child: this.child,
          color: AppColorScheme.bgColor,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(10),
          onPressed: () {
            this.onChange(this.value);
          });
    } else {
      return NeuContainer(emboss: true, depth: 5, child: this.child);
    }
  }
}
