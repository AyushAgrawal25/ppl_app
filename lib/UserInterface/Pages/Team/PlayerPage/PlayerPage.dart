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
    Widget _mainBody = Container();
    double scWidth = MediaQuery.of(context).size.width;
    if (scWidth < 500) {
      _mainBody = _mobileView();
    } else {
      _mainBody = _desktopView();
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
              body: _mainBody,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mobileView() {
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
              Container(alignment: Alignment.center, child: _nameWidget()),

              SizedBox(
                height: 10,
              ),

              // Speciality
              _forteWidget(speciality),

              // Some Numbers.
              _numbersInfo(),

              SizedBox(
                height: 25,
              ),

              // Batting Score.
              _battingScoreWidget(),

              // Bowling Score.
              _bowlingScoreWidget(),
            ],
          ),
        ));
  }

  Widget _desktopView() {
    double scHeight = MediaQuery.of(context).size.height;
    double scWidth = MediaQuery.of(context).size.width - 60;
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
      padding: EdgeInsets.symmetric(horizontal: 30),
      height: scHeight,
      child: Wrap(
        direction: Axis.vertical,
        children: [
          // Profile Pic.
          _desktopItemContainer(
            _profilePic(size: scWidth / 4),
          ),

          _desktopItemContainer(SizedBox(
            height: 20,
          )),

          // Name.
          _desktopItemContainer(_nameWidget()),

          _desktopItemContainer(SizedBox(
            height: 25,
          )),

          // Speciality
          _desktopItemContainer(_forteWidget(speciality)),

          // Some Numbers.
          _desktopItemContainer(_numbersInfo()),

          _desktopItemContainer(SizedBox(
            height: 25,
          )),

          // Batting Score.
          _desktopItemContainer(_battingScoreWidget()),

          // Bowling Score.
          _desktopItemContainer(_bowlingScoreWidget()),
        ],
      ),
    );
  }

  Widget _desktopItemContainer(Widget child) {
    double scWidth = MediaQuery.of(context).size.width;
    int rowCount = 2;
    // if ((scWidth >= 500) && (scWidth <= 1000)) {
    //   rowCount = 2;
    // }

    scWidth -= 60;
    return Container(
      width: scWidth / rowCount,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: child,
    );
  }

  Widget _profilePic({required double size}) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        alignment: Alignment.center,
        child: DisplayPicture(
          imgUrl: "",
          height: size,
          width: size,
          borderRadius: BorderRadius.circular(360),
          contPadding: 5,
          isEditable: false,
        ),
      ),
    );
  }

  Widget _nameWidget() {
    return Container(
      child: NeuText(
        text: widget.memberData.firstName.trim() +
            " " +
            widget.memberData.lastName.trim(),
        color: AppColorScheme.textColor,
        textSize: NeuTextSize.bold_22,
        align: TextAlign.center,
        maxLines: 1,
      ),
    );
  }

  Widget _forteWidget(String speciality) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
      ),
    );
  }

  Widget _numbersInfo() {
    return Container(
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
    );
  }

  Widget _battingScoreWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: NeuText(
                      text: "Batting Score : ",
                      textSize: NeuTextSize.bold_20,
                      color: AppColorScheme.darkDetailColor,
                      align: TextAlign.start,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: NeuText(
                      text: "${widget.memberData.playerData?.battingScore}/100",
                      textSize: NeuTextSize.bold_20,
                      color: AppColorScheme.darkDetailColor,
                      align: TextAlign.start,
                    ),
                  ),
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
                value: (widget.memberData.playerData!.battingScore) / 100,
                minHeight: 40,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColorScheme.themeColor),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _bowlingScoreWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: NeuText(
                      text: "Bowling Score : ",
                      textSize: NeuTextSize.bold_20,
                      color: AppColorScheme.darkDetailColor,
                      align: TextAlign.start,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: NeuText(
                      text: "${widget.memberData.playerData?.bowlingScore}/100",
                      textSize: NeuTextSize.bold_20,
                      color: AppColorScheme.darkDetailColor,
                      align: TextAlign.start,
                    ),
                  ),
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
                value: (widget.memberData.playerData!.bowlingScore) / 100,
                minHeight: 40,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColorScheme.themeColor),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
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
