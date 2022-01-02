import 'package:ppl_app/Models/TeamData.dart';

class AppState {
  Map<int, TeamData> teams = {};

  void addTeam(List<TeamData> newTeams) {
    newTeams.forEach((teamData) {
      teams[teamData.id] = teamData;
    });
  }

  void updateTeam(TeamData teamData) {
    teams[teamData.id] = teamData;
  }

  List<TeamData> getTeams() {
    List<TeamData> teamsList = [];
    teams.forEach((key, value) {
      teamsList.add(value);
    });

    return teamsList;
  }
}
