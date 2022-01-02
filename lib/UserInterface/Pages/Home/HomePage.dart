import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:ppl_app/Models/AppState.dart';
import 'package:ppl_app/Models/TeamData.dart';
import 'package:ppl_app/UserInterface/Pages/Team/TeamCard/TeamCard.dart';
import 'package:ppl_app/UserInterface/Pages/Team/TeamEditPage/TeamEditPage.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/LoaderPage.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuAppBar/NeuAppBar.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuFab/NeuFAB.dart';
import 'package:ppl_app/Utils/TeamsUtils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  late AppState appState;

  @override
  void initState() {
    super.initState();
    initApp();
    appState = Provider.of<AppState>(context, listen: false);
  }

  initApp() async {
    setState(() {
      isLoading = true;
    });

    List<TeamData> teams = await TeamsUtils().getTeams();
    appState.addTeam(teams);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppState appStateListen = Provider.of<AppState>(context, listen: true);
    List<TeamData> teams = appStateListen.getTeams();
    print("Updating.... From Home");
    return Container(
      child: Stack(
        children: [
          // Main Page.
          Container(
            child: Scaffold(
              appBar: NeuAppBar(
                leadingIcon: Icons.home,
                title: "Your Teams",
              ),
              body: Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TeamCard(
                      data: teams[index],
                    );
                  },
                  itemCount: teams.length,
                ),
              ),
            ),
          ),

          // Add Button.
          Positioned(
              bottom: 25,
              right: 25,
              child: NeuFAB(
                size: 55,
                onPressed: _onAddTeamPressed,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColorScheme.lightShadowColor,
                    borderRadius: BorderRadius.circular(360),
                  ),
                  // padding: EdgeInsets.all(20),
                  child: Icon(
                    Icons.add,
                    color: AppColorScheme.textColor,
                    size: 37.5,
                  ),
                ),
              )),

          // Loader
          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }

  _onAddTeamPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return TeamEditPage();
      },
    ));
  }
}
