import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';

class NeuContainer extends StatelessWidget {
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final Widget child;
  final CurveType? curveType;
  final int depth;
  final bool emboss;
  final Color? lightShadowColor;
  NeuContainer(
      {required this.child,
      this.bgColor,
      this.borderRadius,
      this.curveType,
      this.depth: 10,
      this.lightShadowColor,
      this.emboss: false});
  @override
  Widget build(BuildContext context) {
    BorderRadius? bRFinal = this.borderRadius;
    if (this.borderRadius == null) {
      bRFinal = BorderRadius.circular(10);
    }

    Color? surfaceColor = this.bgColor;
    if (this.bgColor == null) {
      surfaceColor = AppColorScheme.bgColor;
    }

    return ClayContainer(
        customBorderRadius: bRFinal,
        color: (this.lightShadowColor == null)
            ? AppColorScheme.lightShadowColor
            : this.lightShadowColor,
        parentColor: AppColorScheme.bgColor,
        surfaceColor: surfaceColor,
        curveType: this.curveType,
        depth: this.depth,
        spread: 10,
        child: ClipRRect(borderRadius: bRFinal, child: this.child),
        emboss: this.emboss);
  }
}
