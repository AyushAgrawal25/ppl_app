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

      if ((bowlingScore == null) || (bowlingScore! < 0)) {
        isFormValid = false;
      }
      if ((battingScore == null) || (battingScore! < 0)) {
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
    return Container(
      child: Stack(
        children: [
          // Main Page.
          Container(
            child: Scaffold(
              appBar: NeuAppBar(
                title: "Member",
              ),
              body: Container(
                child: SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                  child: Column(
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
                        height: 20,
                      ),

                      // First Name.
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

                      // Last Name.
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

                      // Age.
                      NeuTextFormLabel(
                        title: "Age",
                        icon: Icons.calendar_today,
                      ),

                      Container(
                        child: NeuTextFormField(
                          onChange: (value) {
                            setState(() {
                              if ((value != null) &&
                                  (int.tryParse(value) != null)) {
                                age = int.parse(value);
                              }
                            });
                          },
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      (widget.type == MemberType.player)
                          ? Container(
                              child: Column(
                                children: [
                                  // Forte.
                                  NeuTextFormLabel(
                                    title: "Forte",
                                  ),

                                  _specialityMenu(),

                                  SizedBox(
                                    height: 15,
                                  ),

                                  // Centuries.
                                  NeuTextFormLabel(
                                    title: "Centuries",
                                    icon: Icons.circle,
                                  ),
                                  Container(
                                    child: NeuTextFormField(
                                      onChange: (value) {
                                        setState(() {
                                          if ((value != null) &&
                                              (int.tryParse(value) != null)) {
                                            centuries = int.parse(value);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  // matches.
                                  NeuTextFormLabel(
                                    title: "Matches",
                                    icon: Icons.circle,
                                  ),
                                  Container(
                                    child: NeuTextFormField(
                                      onChange: (value) {
                                        setState(() {
                                          if ((value != null) &&
                                              (int.tryParse(value) != null)) {
                                            matches = int.parse(value);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  // Wickets.
                                  NeuTextFormLabel(
                                    title: "Wickets",
                                    icon: Icons.circle,
                                  ),
                                  Container(
                                    child: NeuTextFormField(
                                      onChange: (value) {
                                        setState(() {
                                          if ((value != null) &&
                                              (int.tryParse(value) != null)) {
                                            wickets = int.parse(value);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  // Batting Score
                                  NeuTextFormLabel(
                                    title: "Batting Score.",
                                    icon: Icons.circle,
                                  ),
                                  Container(
                                    child: NeuTextFormField(
                                      onChange: (value) {
                                        setState(() {
                                          if ((value != null) &&
                                              (double.tryParse(value) !=
                                                  null)) {
                                            battingScore = double.parse(value);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  // Bowling Score
                                  NeuTextFormLabel(
                                    title: "Bowling Score.",
                                    icon: Icons.circle,
                                  ),
                                  Container(
                                    child: NeuTextFormField(
                                      onChange: (value) {
                                        setState(() {
                                          if ((value != null) &&
                                              (double.tryParse(value) !=
                                                  null)) {
                                            bowlingScore = double.parse(value);
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
                            )
                          : Container(),

                      SizedBox(
                        height: 25,
                      ),

                      // Add Button.
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
                )),
              ),
            ),
          ),

          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }

  _specialityMenu() {
    return NeuContainer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: MediaQuery.of(context).size.width,
        child: DropdownButton<PlayerSpeciality>(
            onChanged: (value) {
              setState(() {
                speciality = value;
              });
            },
            isExpanded: true,
            underline: Container(),
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
