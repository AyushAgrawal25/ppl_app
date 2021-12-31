import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppl_app/UserInterface/Pages/Team/TeamCard/TeamCard.dart';
import 'package:ppl_app/UserInterface/Widgets/LoaderPage.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuAppBar/NeuAppBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
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
                child: Column(
                  children: [TeamCard()],
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
