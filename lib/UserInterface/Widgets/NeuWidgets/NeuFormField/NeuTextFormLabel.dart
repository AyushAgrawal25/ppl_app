import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';

class NeuTextFormLabel extends StatelessWidget {
  final String title;
  final IconData? icon;
  NeuTextFormLabel({required this.title, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          (this.icon != null)
              ? Icon(
                  icon,
                  size: 15,
                  color: AppColorScheme.textColor,
                )
              : Container(),
          (this.icon != null)
              ? SizedBox(
                  width: 7.5,
                )
              : Container(),
          Container(
            child: Text(
              this.title,
              style: GoogleFonts.notoSans(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: AppColorScheme.textColor),
              textScaleFactor: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
