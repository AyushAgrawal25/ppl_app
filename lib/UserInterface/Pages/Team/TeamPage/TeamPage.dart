import 'package:flutter/material.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/Models/TeamData.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuAppBar/NeuAppBar.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';

class TeamPage extends StatefulWidget {
  final TeamData data;
  TeamPage({required this.data});

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // Main Page.
          Container(
            child: Scaffold(
              appBar: NeuAppBar(
                title: "Specification",
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Name.
                      Container(
                        alignment: Alignment.center,
                        child: NeuText(
                          text: widget.data.name,
                          color: AppColorScheme.darkDetailColor,
                          textSize: NeuTextSize.bold_25,
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      // logo.
                      Container(
                        child: DisplayPicture(
                          imgUrl:
                              "https://cdn6.f-cdn.com/contestentries/1268957/26769824/5aa9ca94e532c_thumb900.jpg",
                          isEditable: false,
                          height: MediaQuery.of(context).size.width * 0.75,
                          width: MediaQuery.of(context).size.width * 0.75,
                          isDeletable: false,
                          contPadding: 20,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Owner Info.
                      _memberTypeTitle("Owner"),

                      // Sponsor Info.

                      // Coach Info.

                      // Player Info.

                      // Manager Info.

                      // Staff Info.
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _memberTypeTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      child: NeuText(
        text: title,
        color: AppColorScheme.darkDetailColor,
        textSize: NeuTextSize.bold_20,
      ),
    );
  }
}
