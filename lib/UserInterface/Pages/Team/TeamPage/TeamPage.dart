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

    print("Updating.... From Team Page.");

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

    return Container(
      child: Stack(
        children: [
          // Main Page.
          Container(
            child: Scaffold(
              appBar: NeuAppBar(
                title: "Team Info",
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
                          text: data.name,
                          color: AppColorScheme.darkDetailColor,
                          textSize: NeuTextSize.bold_25,
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      // logo.
                      (data.logoFile != null)
                          ? Container(
                              child: DisplayPicture(
                                imgUrl: LOGO_URL + "/" + data.logoFile!,
                                isEditable: false,
                                height:
                                    MediaQuery.of(context).size.width * 0.75,
                                width: MediaQuery.of(context).size.width * 0.75,
                                isDeletable: false,
                                contPadding: 20,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            )
                          : NeuContainer(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.75,
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Icon(
                                  FontAwesome.file_image,
                                  size: (MediaQuery.of(context).size.width *
                                          0.75) -
                                      100,
                                  color: AppColorScheme.lightDividerColor,
                                ),
                              ),
                            ),

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
                        height: 40,
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
