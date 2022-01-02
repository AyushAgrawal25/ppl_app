import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';

class NeuText extends StatelessWidget {
  final NeuTextSize textSize;
  final String text;
  final Color? color;
  final TextAlign align;
  final int? maxLines;

  NeuText({
    this.textSize: NeuTextSize.bold_18,
    required this.text,
    this.color,
    this.maxLines,
    this.align: TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.text,
        style: GoogleFonts.nunito(
          fontSize: getSizeFrom(textSize),
          color: (this.color == null)
              ? AppColorScheme.darkDetailColor
              : this.color,
          fontWeight: getFontWeight(textSize),
        ),
        maxLines: this.maxLines,
        textScaleFactor: 1.0,
        textAlign: this.align,
      ),
    );
  }
}

enum NeuTextSize {
  light_12,
  light_14,
  light_16,
  light_18,

  bold_14,
  bold_16,
  bold_18,
  bold_20,
  bold_22,
  bold_25,
}

double getSizeFrom(NeuTextSize neuTextSize) {
  switch (neuTextSize) {
    case NeuTextSize.light_12:
      return 12;
    case NeuTextSize.light_14:
    case NeuTextSize.bold_14:
      return 14;
    case NeuTextSize.light_16:
    case NeuTextSize.bold_16:
      return 16;
    case NeuTextSize.light_18:
    case NeuTextSize.bold_18:
      return 18;
    case NeuTextSize.bold_20:
      return 20;
    case NeuTextSize.bold_22:
      return 22;
    case NeuTextSize.bold_25:
      return 25;
  }
}

FontWeight getFontWeight(NeuTextSize neuTextSize) {
  switch (neuTextSize) {
    case NeuTextSize.light_12:
    case NeuTextSize.light_14:
    case NeuTextSize.light_16:
    case NeuTextSize.light_18:
      return FontWeight.w600;
    case NeuTextSize.bold_14:
    case NeuTextSize.bold_16:
    case NeuTextSize.bold_18:
    case NeuTextSize.bold_20:
    case NeuTextSize.bold_22:
    case NeuTextSize.bold_25:
      return FontWeight.w700;
  }
}
