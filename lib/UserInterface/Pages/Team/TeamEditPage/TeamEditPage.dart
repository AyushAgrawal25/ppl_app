import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/UserInterface/Pages/Team/MemberCard/MemberCard.dart';
import 'package:ppl_app/UserInterface/Pages/Team/MemberCard/OwnerCard.dart';
import 'package:ppl_app/UserInterface/Pages/Team/MemberEditPage/MemberEditPage.dart';
import 'package:ppl_app/UserInterface/Pages/Team/PlayerPage/PlayerPage.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/LoaderPage.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuAppBar/NeuAppBar.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuButton/NeuButton.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuFab/NeuFAB.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuFormField/NeuTextFormField.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuFormField/NeuTextFormLabel.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';
import 'package:ppl_app/Utils/ImageUtils.dart';

class TeamEditPage extends StatefulWidget {
  const TeamEditPage({Key? key}) : super(key: key);

  @override
  _TeamEditPageState createState() => _TeamEditPageState();
}

class _TeamEditPageState extends State<TeamEditPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  File? imgFile;
  String name = "";
  MemberData? ownerInfo;
  List<MemberData> sponsors = [];
  List<MemberData> players = [];
  List<MemberData> coaches = [];
  List<MemberData> managers = [];
  List<MemberData> staff = [];

  @override
  Widget build(BuildContext context) {
    _checkValidity();
    return Container(
      child: Stack(
        children: [
          // Main Page.
          Container(
            child: Scaffold(
              appBar: NeuAppBar(
                title: "Team",
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: NeuButton(
                          borderRadius: BorderRadius.circular(25),
                          color: AppColorScheme.bgColor,
                          onPressed: () async {
                            File? file = await ImageUtils().getImage();
                            if (file != null) {
                              setState(() {
                                imgFile = file;
                              });
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.65,
                            width: MediaQuery.of(context).size.width * 0.65,
                            padding: EdgeInsets.all(10),
                            child: (imgFile == null)
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Add
                                        Icon(
                                          Icons.add,
                                          size: 55,
                                          color:
                                              AppColorScheme.lightDetailColor,
                                        ),
                                        NeuText(
                                          text: "Logo",
                                          textSize: NeuTextSize.light_16,
                                          color:
                                              AppColorScheme.lightDetailColor,
                                        )
                                      ],
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      child: Image.file(
                                        imgFile!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Name.
                      _memberTypeTitle("Name"),

                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        child: NeuTextFormField(
                          onChange: (value) {
                            setState(() {
                              if (value != null) {
                                name = value;
                              }
                            });
                          },
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),

                      // Owner.
                      _memberTypeTitle("Owner"),

                      SizedBox(
                        height: 5,
                      ),

                      (ownerInfo == null)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: _memberAddButton(
                                onPressed: _addOwnerPressed,
                                title: "Add",
                              ),
                            )
                          : OwnerCard(data: ownerInfo!),

                      SizedBox(
                        height: 20,
                      ),

                      // Sponsor Info.
                      _memberTypeTitle("Sponsors"),

                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          children: [
                            ...sponsors.map((sponsorData) {
                              return MemberCard(
                                data: sponsorData,
                                toShowAge: false,
                              );
                            }).toList(),
                            _memberAddButton(
                                title: "Add", onPressed: _onAddSponsorPressed)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Coach Info.
                      _memberTypeTitle("Coaches"),

                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          children: [
                            ...coaches.map((coachData) {
                              return MemberCard(
                                data: coachData,
                                toShowAge: false,
                              );
                            }).toList(),
                            _memberAddButton(
                                title: "Add", onPressed: _onAddCoachPressed)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Player Info.
                      _memberTypeTitle("Players"),

                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          children: [
                            ...players.map((playerData) {
                              return MemberCard(
                                data: playerData,
                                onPressed: (playerData.playerData == null)
                                    ? null
                                    : () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return PlayerPage(
                                                memberData: playerData);
                                          },
                                        ));
                                      },
                              );
                            }).toList(),
                            _memberAddButton(
                                title: "Add", onPressed: _onAddPlayerPressed)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Manager Info.
                      _memberTypeTitle("Managers"),

                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          children: [
                            ...managers.map((managerData) {
                              return MemberCard(
                                data: managerData,
                                toShowAge: false,
                              );
                            }).toList(),
                            _memberAddButton(
                                title: "Add", onPressed: _onAddManagerPressed)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Staff Info.
                      _memberTypeTitle("Staff Members"),

                      SizedBox(
                        height: 5,
                      ),

                      Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          runAlignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          children: [
                            ...staff.map((staffData) {
                              return MemberCard(
                                data: staffData,
                                toShowAge: false,
                              );
                            }).toList(),
                            _memberAddButton(
                                title: "Add", onPressed: _onAddStaffPressed)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      // Create Button.
                      NeuButton(
                        borderRadius: BorderRadius.circular(10),
                        color: (isFormValid)
                            ? AppColorScheme.themeColor
                            : AppColorScheme.darkDividerColor,
                        isDisabled: !isFormValid,
                        child: Container(
                          alignment: Alignment.center,
                          child: NeuText(
                            text: "Create",
                            color: AppColorScheme.bgColor,
                            textSize: NeuTextSize.bold_18,
                          ),
                        ),
                        onPressed: _onCreatePressed,
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

          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }

  bool isFormValid = true;
  _checkValidity() {
    isFormValid = true;
    if (name == "") {
      isFormValid = false;
    }

    if (ownerInfo == null) {
      isFormValid = false;
    }

    int countofMembers = 0;
    countofMembers += sponsors.length;
    countofMembers += coaches.length;
    countofMembers += players.length;
    countofMembers += managers.length;
    countofMembers += staff.length;

    if (countofMembers > 29) {
      isFormValid = false;
    }
  }

  _addOwnerPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MemberEditPage(
          teamId: DateTime.now().microsecondsSinceEpoch,
          type: MemberType.owner,
          onAddPressed: (member) {
            setState(() {
              ownerInfo = member;
            });
          },
        );
      },
    ));
  }

  _onAddSponsorPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MemberEditPage(
          teamId: DateTime.now().microsecondsSinceEpoch,
          type: MemberType.sponsor,
          onAddPressed: (member) {
            setState(() {
              sponsors.add(member);
            });
          },
        );
      },
    ));
  }

  _onAddCoachPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MemberEditPage(
          teamId: DateTime.now().microsecondsSinceEpoch,
          type: MemberType.coach,
          onAddPressed: (member) {
            setState(() {
              coaches.add(member);
            });
          },
        );
      },
    ));
  }

  _onAddPlayerPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MemberEditPage(
          teamId: DateTime.now().microsecondsSinceEpoch,
          type: MemberType.player,
          onAddPressed: (member) {
            setState(() {
              players.add(member);
            });
          },
        );
      },
    ));
  }

  _onAddManagerPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MemberEditPage(
          teamId: DateTime.now().microsecondsSinceEpoch,
          type: MemberType.manager,
          onAddPressed: (member) {
            setState(() {
              managers.add(member);
            });
          },
        );
      },
    ));
  }

  _onAddStaffPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MemberEditPage(
          teamId: DateTime.now().microsecondsSinceEpoch,
          type: MemberType.staff,
          onAddPressed: (member) {
            setState(() {
              staff.add(member);
            });
          },
        );
      },
    ));
  }

  _onCreatePressed() {
    // TODO: call the API.
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

  Widget _memberAddButton(
      {required String title, required Function onPressed}) {
    return Container(
      width: (MediaQuery.of(context).size.width - 60) / 3,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: NeuButton(
        color: AppColorScheme.bgColor,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        borderRadius: BorderRadius.circular(10),
        onPressed: onPressed,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                size: 40,
                color: AppColorScheme.darkDetailColor,
              ),
              Container(
                child: NeuText(
                  text: title,
                  color: AppColorScheme.lightDetailColor,
                  textSize: NeuTextSize.light_12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
