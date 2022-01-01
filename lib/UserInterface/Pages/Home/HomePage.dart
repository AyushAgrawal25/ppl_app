import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppl_app/Models/TeamData.dart';
import 'package:ppl_app/UserInterface/Pages/Team/TeamCard/TeamCard.dart';
import 'package:ppl_app/UserInterface/Widgets/LoaderPage.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuAppBar/NeuAppBar.dart';
import 'package:ppl_app/Utils/TeamsUtils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<TeamData> teams = [];

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    setState(() {
      isLoading = true;
    });

    teams = await TeamsUtils().getTeams();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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

          // Loader
          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }
}
