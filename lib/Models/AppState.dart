import 'package:ppl_app/Models/TeamData.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  Map<int, TeamData> teams = {};

  void addTeam(List<TeamData> newTeams) {
    newTeams.forEach((teamData) {
      teams[teamData.id] = teamData;
    });

    notifyListeners();
  }

  void updateTeam(TeamData teamData) {
    teams[teamData.id] = teamData;
    notifyListeners();
  }

  List<TeamData> getTeams() {
    List<TeamData> teamsList = [];
    teams.forEach((key, value) {
      teamsList.add(value);
    });

    return teamsList;
  }
}
