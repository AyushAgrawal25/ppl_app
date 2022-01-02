import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ppl_app/UserInterface/Themes/AppColorScheme.dart';
import 'package:ppl_app/UserInterface/Widgets/DisplayPicture.dart';
import 'package:ppl_app/UserInterface/Widgets/LoaderPage.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuAppBar/NeuAppBar.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuContainer/NeuContainer.dart';
import 'package:ppl_app/UserInterface/Widgets/NeuWidgets/NeuText/NeuText.dart';

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
  @override
  Widget build(BuildContext context) {
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
                        child: NeuContainer(
                          child: Container(
                            height: MediaQuery.of(context).size.width * 0.65,
                            width: MediaQuery.of(context).size.width * 0.65,
                            padding: EdgeInsets.all(20),
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
                                    child: Container(
                                      child: Image.file(imgFile!),
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      // Name.

                      // All Members Type.

                      // Create Button.
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
}
