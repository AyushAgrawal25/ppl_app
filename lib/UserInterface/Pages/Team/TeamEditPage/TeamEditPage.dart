import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ppl_app/Models/AppState.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/Models/TeamData.dart';
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
import 'package:ppl_app/Utils/PlatformUtils.dart';
import 'package:ppl_app/Utils/TeamsUtils.dart';
import 'package:ppl_app/Utils/ToastUtils.dart';
import 'package:provider/provider.dart';

class TeamEditPage extends StatefulWidget {
  @override
  _TeamEditPageState createState() => _TeamEditPageState();
}

class _TeamEditPageState extends State<TeamEditPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  XFile? imgFile;
  Uint8List? imgBytes;
  String name = "";
  MemberData? ownerInfo;
  List<MemberData> sponsors = [];
  List<MemberData> players = [];
  List<MemberData> coaches = [];
  List<MemberData> managers = [];
  List<MemberData> staff = [];

  void setImgBytes() async {
    setState(() {
      isLoading = true;
    });
    if (imgFile != null) {
      imgBytes = await imgFile!.readAsBytes();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkValidity();

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
                title: "Team",
              ),
              body: _mainBody,
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

  _onCreatePressed() async {
    List<MemberData> members = [
      ownerInfo!,
      ...sponsors,
      ...coaches,
      ...players,
      ...managers,
      ...staff,
    ];
    TeamData teamData = TeamData(
        id: DateTime.now().microsecondsSinceEpoch,
        name: name,
        status: 1,
        members: members);

    setState(() {
      isLoading = true;
    });
    TeamData? newTeamData = await TeamsUtils().createTeam(teamData, imgFile);
    if (newTeamData != null) {
      print(newTeamData.toJson(false));
      AppState appState = Provider.of<AppState>(context, listen: false);
      appState.addTeam([newTeamData]);
    }

    Navigator.of(context).pop();
    setState(() {
      isLoading = false;
    });
  }

  Widget _mobileView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),

            _logoWidget(size: MediaQuery.of(context).size.width * 0.65),

            SizedBox(
              height: 20,
            ),

            // Name.
            _nameField(),

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

            _memberCards(sponsors, _onAddSponsorPressed),

            SizedBox(
              height: 20,
            ),

            // Coach Info.
            _memberTypeTitle("Coaches"),

            SizedBox(
              height: 5,
            ),

            _memberCards(coaches, _onAddCoachPressed),

            SizedBox(
              height: 20,
            ),

            // Player Info.
            _memberTypeTitle("Players"),

            SizedBox(
              height: 5,
            ),

            _memberCards(players, _onAddPlayerPressed),

            SizedBox(
              height: 20,
            ),

            // Manager Info.
            _memberTypeTitle("Managers"),

            SizedBox(
              height: 5,
            ),

            _memberCards(managers, _onAddManagerPressed),

            SizedBox(
              height: 20,
            ),

            // Staff Info.
            _memberTypeTitle("Staff Members"),

            SizedBox(
              height: 5,
            ),

            _memberCards(staff, _onAddStaffPressed),

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
    );
  }

  Widget _desktopView() {
    int flex1 = 1, flex2 = 2;
    double scWidth = MediaQuery.of(context).size.width;
    double scHeight = MediaQuery.of(context).size.height;
    if (scWidth < 1000) {
      flex2 = 1;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: scHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Owner.
          Flexible(
            flex: flex1,
            child: Container(
              height: scHeight,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  _logoWidget(size: 250),

                  SizedBox(
                    height: 20,
                  ),

                  // Name.
                  _nameField(),

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
                          ),
                        )
                      : OwnerCard(data: ownerInfo!),

                  SizedBox(
                    height: 25,
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
                ],
              ),
            ),
          ),

          // Members.
          Flexible(
              flex: flex2,
              child: Container(
                height: scHeight,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Sponsor Info.
                        _memberContainer([
                          _memberTypeTitle("Sponsors"),
                          SizedBox(
                            height: 5,
                          ),
                          _memberCards(sponsors, _onAddSponsorPressed),
                          SizedBox(
                            height: 20,
                          ),
                        ]),

                        // Coach Info.
                        _memberContainer([
                          _memberTypeTitle("Coaches"),
                          SizedBox(
                            height: 5,
                          ),
                          _memberCards(coaches, _onAddCoachPressed),
                          SizedBox(
                            height: 20,
                          ),
                        ]),

                        // Player Info.
                        _memberContainer([
                          _memberTypeTitle("Players"),
                          SizedBox(
                            height: 5,
                          ),
                          _memberCards(players, _onAddPlayerPressed),
                          SizedBox(
                            height: 20,
                          ),
                        ]),

                        // Manager Info.
                        _memberContainer([
                          _memberTypeTitle("Managers"),
                          SizedBox(
                            height: 5,
                          ),
                          _memberCards(managers, _onAddManagerPressed),
                          SizedBox(
                            height: 20,
                          ),
                        ]),

                        // Staff Info.
                        _memberContainer([
                          _memberTypeTitle("Staff Members"),
                          SizedBox(
                            height: 5,
                          ),
                          _memberCards(staff, _onAddStaffPressed),
                          SizedBox(
                            height: 20,
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget _logoWidget({required double size}) {
    Widget _imageWidget = Container();
    OSPlatformType osPlatformType = PlatformUtils().getOSPlatformType();
    if (osPlatformType == OSPlatformType.web) {
      _imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: (imgBytes == null)
              ? LoaderPage()
              : Image.memory(
                  imgBytes!,
                  fit: BoxFit.cover,
                ),
        ),
      );
    } else {
      _imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: Image.file(
            File(imgFile!.path),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      alignment: Alignment.center,
      child: NeuButton(
        borderRadius: BorderRadius.circular(25),
        color: AppColorScheme.bgColor,
        onPressed: () async {
          XFile? file = await ImageUtils().getImage();
          if (file != null) {
            setState(() {
              imgFile = file;
            });
            setImgBytes();
          }
        },
        child: Container(
          height: size,
          width: size,
          padding: EdgeInsets.all(10),
          child: (imgFile == null)
              // (true)
              ? Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Add
                      Icon(
                        Icons.add,
                        size: 55,
                        color: AppColorScheme.lightDetailColor,
                      ),
                      NeuText(
                        text: "Logo",
                        textSize: NeuTextSize.light_16,
                        color: AppColorScheme.lightDetailColor,
                      )
                    ],
                  ),
                )
              : _imageWidget,
        ),
      ),
    );
  }

  Widget _nameField() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
        ],
      ),
    );
  }

  Widget _memberContainer(List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }

  Widget _memberCards(List<MemberData> members, Function _onAddPressed) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        alignment: WrapAlignment.start,
        children: [
          ...members.map((memberData) {
            return MemberCard(
              data: memberData,
              toShowAge: (memberData.type == MemberType.player),
              onPressed: (memberData.playerData == null)
                  ? null
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return PlayerPage(memberData: memberData);
                        },
                      ));
                    },
            );
          }).toList(),
          _memberAddButton(onPressed: _onAddPressed)
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

  Widget _memberAddButton({required Function onPressed}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      height: min((MediaQuery.of(context).size.width - 60) / 3, 100),
      width: min((MediaQuery.of(context).size.width - 60) / 3, 100),
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
                  text: "Add",
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
