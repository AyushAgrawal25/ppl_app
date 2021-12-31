import 'package:flutter/material.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';

class TeamCard extends StatefulWidget {
  const TeamCard({Key? key}) : super(key: key);

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: NeuContainer(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              // Team Logo.
              Container(
                child: DisplayPicture(
                  imgUrl:
                      "https://cdn6.f-cdn.com/contestentries/1268957/26769824/5aa9ca94e532c_thumb900.jpg",
                  isEditable: false,
                  height: 90,
                  width: 90,
                  isDeletable: false,
                  contPadding: 5,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              SizedBox(
                width: 20,
              ),

              // Info.
              Expanded(
                  child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name.
                    Container(
                      child: NeuText(
                        text: "Wolves",
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    // Number of Members.
                    Container(
                      child: NeuText(
                        text: "30 Members",
                        color: AppColorScheme.lightDetailColor,
                        textSize: NeuTextSize.light_14,
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
