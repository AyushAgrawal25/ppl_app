import 'package:flutter/material.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/Models/TeamData.dart';
import 'package:ppl_app/UserInterface/Pages/Team/MemberCard/MemberCard.dart';
import 'package:ppl_app/UserInterface/Pages/Team/MemberCard/OwnerCard.dart';
import 'package:ppl_app/UserInterface/Pages/Team/PlayerPage/PlayerPage.dart';
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
    MemberData? ownerInfo;
    List<MemberData> sponsors = [];
    List<MemberData> players = [];
    List<MemberData> coaches = [];
    List<MemberData> managers = [];
    List<MemberData> staff = [];

    widget.data.members.forEach((member) {
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

                      (sponsors.length > 0)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                children: sponsors.map((sponsorData) {
                                  return MemberCard(
                                    data: sponsorData,
                                    toShowAge: false,
                                  );
                                }).toList(),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              child: NeuText(
                                text: "No Sponsors.",
                                textSize: NeuTextSize.light_16,
                                color: AppColorScheme.lightDetailColor,
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

                      (coaches.length > 0)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                children: coaches.map((coachData) {
                                  return MemberCard(
                                    data: coachData,
                                    toShowAge: false,
                                  );
                                }).toList(),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              child: NeuText(
                                text: "No Coaches.",
                                textSize: NeuTextSize.light_16,
                                color: AppColorScheme.lightDetailColor,
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

                      (players.length > 0)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                children: players.map((playerData) {
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
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              child: NeuText(
                                text: "No Players.",
                                textSize: NeuTextSize.light_16,
                                color: AppColorScheme.lightDetailColor,
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

                      (managers.length > 0)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                children: managers.map((managerData) {
                                  return MemberCard(
                                    data: managerData,
                                    toShowAge: false,
                                  );
                                }).toList(),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              child: NeuText(
                                text: "No Sponsors.",
                                textSize: NeuTextSize.light_16,
                                color: AppColorScheme.lightDetailColor,
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

                      (staff.length > 0)
                          ? Container(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                alignment: WrapAlignment.start,
                                children: staff.map((staffData) {
                                  return MemberCard(
                                    data: staffData,
                                    toShowAge: false,
                                  );
                                }).toList(),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.only(top: 10),
                              child: NeuText(
                                text: "No Staff Members.",
                                textSize: NeuTextSize.light_16,
                                color: AppColorScheme.lightDetailColor,
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
