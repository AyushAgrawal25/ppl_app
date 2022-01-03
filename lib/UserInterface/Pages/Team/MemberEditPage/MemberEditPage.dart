import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/Models/PlayerData.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/LoaderPage.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuAppBar/NeuAppBar.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuButton/NeuButton.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuFormField/NeuTextFormField.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuFormField/NeuTextFormLabel.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';

class MemberEditPage extends StatefulWidget {
  final MemberType type;
  final Function(MemberData) onAddPressed;
  final int teamId;
  MemberEditPage({
    required this.type,
    required this.onAddPressed,
    required this.teamId,
  });

  @override
  _MemberEditPageState createState() => _MemberEditPageState();
}

class _MemberEditPageState extends State<MemberEditPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  String firstName = "", lastName = "";
  int? age;

  // Player Info.
  int? centuries, matches, wickets;
  double? bowlingScore, battingScore;
  PlayerSpeciality? speciality;

  bool isFormValid = true;
  _checkFormValidity() {
    isFormValid = true;
    if (firstName == "") {
      isFormValid = false;
    }

    if (lastName == "") {
      isFormValid = false;
    }

    if ((age == null) || (age! < 18)) {
      isFormValid = false;
    }

    if (widget.type == MemberType.player) {
      if ((centuries == null) || (centuries! < 0)) {
        isFormValid = false;
      }
      if ((matches == null) || (matches! < 0)) {
        isFormValid = false;
      }
      if ((wickets == null) || (wickets! < 0)) {
        isFormValid = false;
      }

      if ((bowlingScore == null) ||
          (bowlingScore! < 0) ||
          (bowlingScore! > 100)) {
        isFormValid = false;
      }
      if ((battingScore == null) ||
          (battingScore! < 0) ||
          (battingScore! > 100)) {
        isFormValid = false;
      }

      if (speciality == null) {
        isFormValid = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkFormValidity();

    Widget _mainBody = Container(
      height: 0,
      width: 0,
    );
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
                title: "Member",
              ),
              body: _mainBody,
            ),
          ),

          (isLoading)
              ? LoaderPage()
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }

  Widget _mobileView() {
    return Container(
      child: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),

            // Profile Pic.
            _profilePic(size: MediaQuery.of(context).size.width * 0.4),

            SizedBox(
              height: 20,
            ),

            // First Name.
            _firstNameField(),

            // Last Name.
            _lastNameField(),

            // Age.
            _ageField(),

            (widget.type == MemberType.player)
                ? Container(
                    child: Column(
                      children: [
                        // Forte.
                        _specialityMenu(),

                        // Centuries.
                        _centuriesField(),

                        // matches.
                        _matchesField(),

                        // Wickets.
                        _wicketsField(),

                        // Batting Score
                        _battingScoreField(),

                        // Bowling Score
                        _bowlingScoreField(),
                      ],
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),

            SizedBox(
              height: 25,
            ),

            // Add Button.
            _addButtonWidget(),
          ],
        ),
      )),
    );
  }

  Widget _desktopView() {
    double scHeight = MediaQuery.of(context).size.height;
    double scWidth = MediaQuery.of(context).size.width - 60;
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

            // First Name.
            _desktopItemContainer(_firstNameField()),

            // Last Name.
            _desktopItemContainer(_lastNameField()),

            // Age.
            _desktopItemContainer(_ageField()),

            // Forte.
            (widget.type == MemberType.player)
                ? _desktopItemContainer(_specialityMenu())
                : Container(
                    height: 0,
                    width: 0,
                  ),

            // Centuries.
            (widget.type == MemberType.player)
                ? _desktopItemContainer(_centuriesField())
                : Container(
                    height: 0,
                    width: 0,
                  ),

            // matches.
            (widget.type == MemberType.player)
                ? _desktopItemContainer(_matchesField())
                : Container(
                    height: 0,
                    width: 0,
                  ),

            // Wickets.
            (widget.type == MemberType.player)
                ? _desktopItemContainer(_wicketsField())
                : Container(
                    height: 0,
                    width: 0,
                  ),

            // Batting Score
            (widget.type == MemberType.player)
                ? _desktopItemContainer(_battingScoreField())
                : Container(
                    height: 0,
                    width: 0,
                  ),

            // Bowling Score
            (widget.type == MemberType.player)
                ? _desktopItemContainer(_bowlingScoreField())
                : Container(
                    height: 0,
                    width: 0,
                  ),

            _desktopItemContainer(SizedBox(
              height: 20,
            )),

            // Add Button.
            _desktopItemContainer(_addButtonWidget()),
          ],
        ));
  }

  Widget _desktopItemContainer(Widget child) {
    double scWidth = MediaQuery.of(context).size.width;
    int rowCount = 3;
    if ((scWidth >= 500) && (scWidth <= 1000)) {
      rowCount = 2;
    }

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

  Widget _firstNameField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuTextFormLabel(
            title: "First Name",
            icon: Icons.person,
          ),
          Container(
            child: NeuTextFormField(
              onChange: (value) {
                setState(() {
                  if (value != null) {
                    firstName = value;
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _lastNameField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuTextFormLabel(
            title: "Last Name",
            icon: Icons.person,
          ),
          Container(
            child: NeuTextFormField(
              onChange: (value) {
                setState(() {
                  if (value != null) {
                    lastName = value;
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _ageField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuTextFormLabel(
            title: "Age",
            icon: Icons.calendar_today,
          ),
          Container(
            child: NeuTextFormField(
              onChange: (value) {
                setState(() {
                  if ((value != null) && (int.tryParse(value) != null)) {
                    age = int.parse(value);
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _specialityMenu() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NeuTextFormLabel(
          title: "Forte",
        ),
        NeuContainer(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: MediaQuery.of(context).size.width,
            child: DropdownButton<PlayerSpeciality>(
                dropdownColor: AppColorScheme.bgColor,
                onChanged: (value) {
                  setState(() {
                    speciality = value;
                  });
                },
                isExpanded: true,
                underline: Container(
                  height: 0,
                  width: 0,
                ),
                value: speciality,
                items: [
                  DropdownMenuItem<PlayerSpeciality>(
                      value: null,
                      child: Container(
                        child: NeuText(
                          text: "Select Forte",
                          textSize: NeuTextSize.light_16,
                          color: AppColorScheme.textColor,
                        ),
                      )),
                  ...PlayerSpeciality.values.map((spec) {
                    String specTitle = "";
                    switch (spec) {
                      case PlayerSpeciality.allRounder:
                        specTitle = "All Rounder";
                        break;
                      case PlayerSpeciality.batsman:
                        specTitle = "Batsman";
                        break;
                      case PlayerSpeciality.bowler:
                        specTitle = "Bowler";
                        break;
                    }
                    return DropdownMenuItem<PlayerSpeciality>(
                        value: spec,
                        child: Container(
                          child: NeuText(
                            text: specTitle,
                            textSize: NeuTextSize.light_16,
                            color: AppColorScheme.textColor,
                          ),
                        ));
                  }).toList(),
                ]),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget _centuriesField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuTextFormLabel(
            title: "Centuries",
            icon: Icons.circle,
          ),
          Container(
            child: NeuTextFormField(
              onChange: (value) {
                setState(() {
                  if ((value != null) && (int.tryParse(value) != null)) {
                    centuries = int.parse(value);
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _matchesField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuTextFormLabel(
            title: "Matches",
            icon: Icons.circle,
          ),
          Container(
            child: NeuTextFormField(
              onChange: (value) {
                setState(() {
                  if ((value != null) && (int.tryParse(value) != null)) {
                    matches = int.parse(value);
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _wicketsField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          NeuTextFormLabel(
            title: "Wickets",
            icon: Icons.circle,
          ),
          Container(
            child: NeuTextFormField(
              onChange: (value) {
                setState(() {
                  if ((value != null) && (int.tryParse(value) != null)) {
                    wickets = int.parse(value);
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _battingScoreField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeuTextFormLabel(
                  title: "Batting Score.",
                  icon: Icons.circle,
                ),
                NeuText(
                  text: "0 to 100",
                  textSize: NeuTextSize.light_12,
                )
              ],
            ),
          ),
          Container(
            child: NeuTextFormField(
              onChange: (value) {
                setState(() {
                  if ((value != null) && (double.tryParse(value) != null)) {
                    battingScore = double.parse(value);
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _bowlingScoreField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NeuTextFormLabel(
                  title: "Bowling Score.",
                  icon: Icons.circle,
                ),
                NeuText(
                  text: "0 to 100",
                  textSize: NeuTextSize.light_12,
                )
              ],
            ),
          ),
          Container(
            child: NeuTextFormField(
              onChange: (value) {
                setState(() {
                  if ((value != null) && (double.tryParse(value) != null)) {
                    bowlingScore = double.parse(value);
                  }
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget _addButtonWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: NeuButton(
              onPressed: _onAddMemberPressed,
              isDisabled: !isFormValid,
              color: (isFormValid)
                  ? AppColorScheme.themeColor
                  : AppColorScheme.darkDividerColor,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                alignment: Alignment.center,
                child: NeuText(
                  text: "Add",
                  textSize: NeuTextSize.bold_18,
                  color: AppColorScheme.bgColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }

  _onAddMemberPressed() {
    int memberId = DateTime.now().microsecondsSinceEpoch;
    MemberData memberData = MemberData(
      age: age!,
      firstName: firstName,
      lastName: lastName,
      id: memberId,
      teamId: widget.teamId,
      type: widget.type,
      playerData: (widget.type == MemberType.player)
          ? PlayerData(
              id: DateTime.now().microsecondsSinceEpoch,
              wickets: wickets!,
              speciality: speciality!,
              battingScore: battingScore!,
              bowlingScore: bowlingScore!,
              centuries: centuries!,
              matches: matches!,
              memberId: memberId,
              status: 1,
            )
          : null,
      status: 1,
    );

    Navigator.of(context).pop();
    widget.onAddPressed(memberData);
  }
}
