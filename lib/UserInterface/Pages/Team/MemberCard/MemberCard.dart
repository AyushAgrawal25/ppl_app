import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';

class MemberCard extends StatelessWidget {
  final MemberData data;
  final bool toShowAge;
  final Function? onPressed;
  MemberCard({required this.data, this.toShowAge: true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.onPressed != null) {
          SystemSound.play(SystemSoundType.click);
          this.onPressed!();
        }
      },
      child: Container(
        width: min((MediaQuery.of(context).size.width - 60) / 3, 100),
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // profile pic.
            DisplayPicture(
              imgUrl: "",
              height: 70,
              width: 70,
              borderRadius: BorderRadius.circular(360),
              contPadding: 5,
              isEditable: false,
            ),

            // Name.
            NeuText(
              text:
                  this.data.firstName.trim() + " " + this.data.lastName.trim(),
              color: AppColorScheme.textColor,
              textSize: NeuTextSize.bold_14,
              align: TextAlign.center,
              maxLines: 1,
            ),

            // Age.
            (toShowAge)
                ? NeuText(
                    text: "${this.data.age} yrs",
                    color: AppColorScheme.lightDetailColor,
                    align: TextAlign.center,
                    maxLines: 1,
                    textSize: NeuTextSize.light_12,
                  )
                : Container(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
    );
  }
}
