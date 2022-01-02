import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:ppl_app/Models/AppState.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/Models/TeamData.dart';
import 'package:ppl_app/UserInterface/Pages/Team/TeamPage/TeamPage.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';
import 'package:ppl_app/constants.dart';
import 'package:provider/provider.dart';

class TeamCard extends StatefulWidget {
  final TeamData data;
  TeamCard({required this.data});

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  @override
  Widget build(BuildContext context) {
    AppState appStateListen = Provider.of<AppState>(context, listen: true);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return TeamPage(
                teamId: widget.data.id,
              );
            },
          ));
        },
        child: NeuContainer(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                // Team Logo.
                (widget.data.logoFile != null)
                    ? Container(
                        child: DisplayPicture(
                          imgUrl: LOGO_URL + "/" + widget.data.logoFile!,
                          isEditable: false,
                          height: 90,
                          width: 90,
                          isDeletable: false,
                          contPadding: 5,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )
                    : NeuContainer(
                        child: Container(
                          height: 90,
                          width: 90,
                          child: Icon(
                            FontAwesome.file_image,
                            size: 55,
                            color: AppColorScheme.lightDividerColor,
                          ),
                        ),
                      ),

                SizedBox(
                  width: 20,
                ),

                // Info.
                Expanded(
                    child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name.
                      Container(
                        child: NeuText(
                          text: widget.data.name,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // Number of Members.
                      Container(
                        child: NeuText(
                          text: "${widget.data.members.length} Members",
                          color: AppColorScheme.lightDetailColor,
                          textSize: NeuTextSize.light_14,
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
