import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuButton/NeuButton.dart';

class NeuFAB extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Function onPressed;
  final double size;
  final bool isElevated;
  final bool isDisabled;
  final BoxBorder? border;

  NeuFAB(
      {required this.child,
      required this.onPressed,
      this.border,
      this.isDisabled: false,
      this.color,
      this.isElevated: true,
      this.size: 45});

  @override
  Widget build(BuildContext context) {
    if (isElevated) {
      return Container(
        child: NeuButton(
          color: (this.color != null) ? this.color : AppColorScheme.bgColor,
          borderRadius: BorderRadius.circular(360),
          padding: EdgeInsets.zero,
          shadowDepth: 10,
          isDisabled: this.isDisabled,
          child: Container(
            height: this.size,
            width: this.size,
            child: this.child,
          ),
          onPressed: () {
            this.onPressed();
          },
        ),
      );
    }

    return Container(
      child: GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(360),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(360),
            child: Container(
              color: (this.color != null) ? this.color : AppColorScheme.bgColor,
              height: this.size,
              width: this.size,
              child: this.child,
            ),
          ),
        ),
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          this.onPressed();
        },
      ),
    );
  }
}
