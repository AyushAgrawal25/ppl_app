import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
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
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';
import 'package:ppl_app/Utils/TeamsUtils.dart';
import 'package:ppl_app/Utils/ToastUtils.dart';
import 'package:ppl_app/constants.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  final int teamId;
  TeamPage({required this.teamId});

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  bool isLoading = false;
  late AppState appState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MemberData? ownerInfo;
    List<MemberData> sponsors = [];
    List<MemberData> players = [];
    List<MemberData> coaches = [];
    List<MemberData> managers = [];
    List<MemberData> staff = [];

    AppState appStateListen = Provider.of<AppState>(context, listen: true);
    TeamData data = appStateListen.teams[widget.teamId]!;

    data.members.forEach((member) {
      switch (member.type) {
        case MemberType.owner:
          ownerInfo = member;
          break;
        case MemberType.coach:
          coaches.add(member);
          break;
        case MemberType.manager:
          managers.add(member);
          break;
        case MemberType.player:
          players.add(member);
          break;
        case MemberType.sponsor:
          sponsors.add(member);
          break;
        case MemberType.staff:
          staff.add(member);
          break;
      }
    });

    Widget mainBody = Container();

    double scWidth = MediaQuery.of(context).size.width;
    if (scWidth < 500) {
      mainBody = _mobileView(
          data: data,
          ownerInfo: ownerInfo,
          sponsors: sponsors,
          players: players,
          coaches: coaches,
          managers: managers,
          staff: staff);
    } else {
      mainBody = _desktopView(
          data: data,
          ownerInfo: ownerInfo,
          sponsors: sponsors,
          players: players,
          coaches: coaches,
          managers: managers,
          staff: staff);
    }

    return Container(
      child: Stack(
        children: [
          // Main Page.
          Container(
            child: Scaffold(
              appBar: NeuAppBar(
                title: "Team Info",
              ),
              body: mainBody,
            ),
          ),

          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }

  _onAddSponsorPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MemberEditPage(
          teamId: DateTime.now().microsecondsSinceEpoch,
          type: MemberType.sponsor,
          onAddPressed: (member) {
            _onMemberAddition(member);
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
            _onMemberAddition(member);
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
            _onMemberAddition(member);
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
            _onMemberAddition(member);
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
            _onMemberAddition(member);
          },
        );
      },
    ));
  }

  _onMemberAddition(MemberData memberData) async {
    setState(() {
      isLoading = true;
    });

    TeamData? newTeamData = await TeamsUtils()
        .addMember(memberData: memberData, teamId: widget.teamId);

    if (newTeamData != null) {
      AppState appState = Provider.of<AppState>(context, listen: false);
      appState.updateTeam(newTeamData);
      ToastUtils.showMessage("Member Added");
    } else {
      ToastUtils.showMessage("Member Failed");
    }
    setState(() {
      isLoading = false;
    });
  }

  // Main Page for responsive view.
  Widget _desktopView({
    required TeamData data,
    required MemberData? ownerInfo,
    required List<MemberData> sponsors,
    required List<MemberData> players,
    required List<MemberData> coaches,
    required List<MemberData> managers,
    required List<MemberData> staff,
  }) {
    int flex1 = 1, flex2 = 2;
    double scWidth = MediaQuery.of(context).size.width;
    double scHeight = MediaQuery.of(context).size.height;
    if (scWidth < 1000) {
      flex2 = 1;
    }
    return Container(
      height: scHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and owner.
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
                    height: 25,
                  ),

                  // Name.
                  _teamName(data),

                  SizedBox(
                    height: 15,
                  ),

                  // logo.
                  _logoWidget(data: data, contSize: 360, imgSize: 300),

                  SizedBox(
                    height: 30,
                  ),

                  // Owner Info.
                  _memberTypeTitle("Owner"),

                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    child: OwnerCard(
                      data: ownerInfo!,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Members
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

  Widget _mobileView({
    required TeamData data,
    required MemberData? ownerInfo,
    required List<MemberData> sponsors,
    required List<MemberData> players,
    required List<MemberData> coaches,
    required List<MemberData> managers,
    required List<MemberData> staff,
  }) {
    double scWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Name.
            _teamName(data),

            SizedBox(
              height: 15,
            ),

            // logo.
            _logoWidget(
                data: data,
                contSize: scWidth * 0.75,
                imgSize: scWidth * 0.75 - 100),

            SizedBox(
              height: 20,
            ),

            // Owner Info.
            _memberTypeTitle("Owner"),

            SizedBox(
              height: 5,
            ),

            Container(
              child: OwnerCard(
                data: ownerInfo!,
              ),
            ),

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
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _teamName(TeamData data) {
    return Container(
      alignment: Alignment.center,
      child: NeuText(
        text: data.name,
        color: AppColorScheme.darkDetailColor,
        textSize: NeuTextSize.bold_25,
      ),
    );
  }

  Widget _logoWidget(
      {required TeamData data,
      required double contSize,
      required double imgSize}) {
    return (data.logoFile != null)
        ? Container(
            child: DisplayPicture(
              imgUrl: LOGO_URL + "/" + data.logoFile!,
              isEditable: false,
              height: contSize,
              width: contSize,
              isDeletable: false,
              contPadding: 20,
              borderRadius: BorderRadius.circular(15),
            ),
          )
        : NeuContainer(
            child: Container(
              height: contSize,
              width: contSize,
              child: Icon(
                FontAwesome.file_image,
                size: imgSize,
                color: AppColorScheme.lightDividerColor,
              ),
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

  Widget _memberContainer(List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
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
