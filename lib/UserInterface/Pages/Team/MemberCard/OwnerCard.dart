import 'package:flutter/material.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';

class OwnerCard extends StatelessWidget {
  final MemberData data;
  OwnerCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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

          SizedBox(
            width: 15,
          ),

          // Info.
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name.
              Container(
                child: NeuText(
                  text: data.firstName.trim() + " " + data.lastName.trim(),
                  color: AppColorScheme.textColor,
                  textSize: NeuTextSize.bold_18,
                ),
              ),

              // Age.
              Container(
                child: NeuText(
                  text: "Age : ${data.age} years",
                  color: AppColorScheme.lightDetailColor,
                  textSize: NeuTextSize.light_14,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
