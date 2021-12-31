import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';

class NeuText extends StatelessWidget {
  final NeuTextSize textSize;
  final String text;
  final Color? color;

  NeuText({
    this.textSize: NeuTextSize.bold_18,
    required this.text,
    this.color,
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
        textScaleFactor: 1.0,
      ),
    );
  }
}

enum NeuTextSize { light_18, light_16, light_14, bold_18, bold_20 }

double getSizeFrom(NeuTextSize neuTextSize) {
  switch (neuTextSize) {
    case NeuTextSize.light_14:
      return 14;
    case NeuTextSize.light_16:
      return 16;
    case NeuTextSize.light_18:
    case NeuTextSize.bold_18:
      return 18;
    case NeuTextSize.bold_20:
      return 20;
  }
}

FontWeight getFontWeight(NeuTextSize neuTextSize) {
  switch (neuTextSize) {
    case NeuTextSize.light_14:
    case NeuTextSize.light_16:
    case NeuTextSize.light_18:
      return FontWeight.w600;
    case NeuTextSize.bold_18:
    case NeuTextSize.bold_20:
      return FontWeight.w700;
  }
}
