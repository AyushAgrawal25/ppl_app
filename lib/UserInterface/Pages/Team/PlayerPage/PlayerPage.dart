import 'package:flutter/material.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/Models/PlayerData.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuAppBar/NeuAppBar.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';

class PlayerPage extends StatefulWidget {
  final MemberData memberData;
  PlayerPage({required this.memberData});
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    String speciality = "";
    switch (widget.memberData.playerData!.speciality) {
      case PlayerSpeciality.allRounder:
        speciality = "All Rounder";
        break;
      case PlayerSpeciality.batsman:
        speciality = "Batsman";
        break;
      case PlayerSpeciality.bowler:
        speciality = "Bowler";
        break;
    }

    return Container(
      child: Stack(
        children: [
          // Main Page.
          Container(
            child: Scaffold(
              appBar: NeuAppBar(
                title: "Player Info",
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),

                      // Profile Pic.
                      Container(
                        alignment: Alignment.center,
                        child: DisplayPicture(
                          imgUrl: "",
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          borderRadius: BorderRadius.circular(360),
                          contPadding: 5,
                          isEditable: false,
                        ),
                      ),

                      SizedBox(
                        height: 17.5,
                      ),

                      // Name.
                      Container(
                        alignment: Alignment.center,
                        child: NeuText(
                          text: widget.memberData.firstName.trim() +
                              " " +
                              widget.memberData.lastName.trim(),
                          color: AppColorScheme.textColor,
                          textSize: NeuTextSize.bold_22,
                          align: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // Speciality
                      Container(
                        alignment: Alignment.center,
                        child: NeuText(
                          text: "Forte",
                          textSize: NeuTextSize.light_18,
                          color: AppColorScheme.lightDetailColor,
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        alignment: Alignment.center,
                        child: NeuText(
                          text: speciality,
                          textSize: NeuTextSize.bold_25,
                          color: AppColorScheme.darkDetailColor,
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      // Some Numbers.
                      Container(
                        child: Row(
                          children: [
                            // Centuris.
                            _infoTab(
                              value: widget.memberData.playerData!.centuries,
                              title: "Centuries",
                            ),

                            SizedBox(
                              width: 15,
                            ),

                            // Matches.
                            _infoTab(
                              value: widget.memberData.playerData!.matches,
                              title: "Matches",
                            ),

                            SizedBox(
                              width: 15,
                            ),

                            // Wickets.
                            _infoTab(
                              value: widget.memberData.playerData!.wickets,
                              title: "Wickets",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      // Batting Score.
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NeuText(
                              text: "Batting Score : ",
                              textSize: NeuTextSize.bold_20,
                              color: AppColorScheme.darkDetailColor,
                              align: TextAlign.start,
                            ),
                            NeuText(
                              text:
                                  "${widget.memberData.playerData?.battingScore}/100",
                              textSize: NeuTextSize.bold_20,
                              color: AppColorScheme.darkDetailColor,
                              align: TextAlign.start,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value:
                                (widget.memberData.playerData!.battingScore) /
                                    100,
                            minHeight: 40,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Bowling Score.
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NeuText(
                              text: "Bowling Score : ",
                              textSize: NeuTextSize.bold_20,
                              color: AppColorScheme.darkDetailColor,
                              align: TextAlign.start,
                            ),
                            NeuText(
                              text:
                                  "${widget.memberData.playerData?.bowlingScore}/100",
                              textSize: NeuTextSize.bold_20,
                              color: AppColorScheme.darkDetailColor,
                              align: TextAlign.start,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value:
                                (widget.memberData.playerData!.bowlingScore) /
                                    100,
                            minHeight: 40,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTab({required int value, required String title}) {
    return Expanded(
        child: NeuContainer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Value.
            Container(
              child: NeuText(
                text: value.toString(),
                textSize: NeuTextSize.bold_22,
                color: AppColorScheme.darkDetailColor,
              ),
            ),

            SizedBox(
              height: 1.5,
            ),

            // Title.
            Container(
              child: NeuText(
                text: title,
                textSize: NeuTextSize.light_12,
                color: AppColorScheme.textColor,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
