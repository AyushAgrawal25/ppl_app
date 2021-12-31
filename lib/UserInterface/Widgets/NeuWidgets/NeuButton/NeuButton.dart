import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuAnimatedContainer.dart';

class NeuButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  final Color? color;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final int shadowDepth;
  final bool isDisabled;
  NeuButton(
      {required this.child,
      required this.onPressed,
      this.borderRadius,
      this.padding,
      this.shadowDepth: 10,
      this.color,
      this.isDisabled: false});

  @override
  _NeuButtonState createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> with TickerProviderStateMixin {
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        if (!widget.isDisabled) {
          setState(() {
            isPressed = false;
          });
          SystemSound.play(SystemSoundType.click);
          widget.onPressed();
        }
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedScale(
        scale: (widget.isDisabled)
            ? 1
            : (isPressed)
                ? 0.98
                : 1,
        duration: Duration(milliseconds: 150),
        child: NeuAnimatedContainer(
          depth: (widget.isDisabled)
              ? widget.shadowDepth
              : (isPressed)
                  ? -5
                  : widget.shadowDepth,
          borderRadius: (this.widget.borderRadius != null)
              ? this.widget.borderRadius!
              : BorderRadius.circular(360),
          bgColor: (this.widget.color != null)
              ? this.widget.color!
              : AppColorScheme.themeColor,
          duration: Duration(milliseconds: 150),
          child: Container(
              padding: (this.widget.padding != null)
                  ? this.widget.padding
                  : EdgeInsets.all(12.0),
              child: this.widget.child),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
