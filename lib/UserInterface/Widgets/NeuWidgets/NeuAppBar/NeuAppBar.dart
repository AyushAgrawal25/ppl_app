import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuFab/NeuFAB.dart';

class NeuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool toPopUp;
  final IconData leadingIcon;
  final String? title;
  final Widget? titleWidget;
  final bool implyLeadingIcon;
  final Widget? secondaryWidget;
  final Color? backgroundColor;
  final double leftSpacing;

  NeuAppBar(
      {this.toPopUp: true,
      this.leadingIcon: Icons.arrow_back,
      this.title,
      this.titleWidget,
      this.implyLeadingIcon: true,
      this.secondaryWidget,
      this.leftSpacing: 30,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    // App Bar Size=65
    final MediaQueryData media = MediaQuery.of(context);
    return Container(
      width: media.size.width,
      padding: EdgeInsets.only(top: media.padding.top),
      color: (this.backgroundColor != null)
          ? this.backgroundColor
          : AppColorScheme.bgColor,
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 80,
        child: Row(
          children: [
            (this.implyLeadingIcon)
                ? Container(
                    padding: EdgeInsets.only(right: 12.5),
                    alignment: Alignment.centerLeft,
                    child: NeuFAB(
                      size: 47.5,
                      child: Icon(
                        this.leadingIcon,
                        size: 22.5,
                        color: AppColorScheme.textColor,
                      ),
                      onPressed: () {
                        if (this.toPopUp && Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  )
                : Container(
                    height: 45,
                    width: this.leftSpacing,
                  ),

            // SizedBox(
            //   width: 12.5,
            // ),

            // Text
            (this.title != null)
                ? Expanded(
                    child: Container(
                      child: Text(
                        this.title!,
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColorScheme.darkDetailColor),
                        textScaleFactor: 1.0,
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      child: this.titleWidget,
                    ),
                  ),

            SizedBox(
              width: 20,
            ),
            Container(
              child: this.secondaryWidget,
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75);
}
