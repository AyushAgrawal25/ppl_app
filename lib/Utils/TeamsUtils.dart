import 'dart:convert';

import 'package:ppl_app/Models/TeamData.dart';

import 'package:http/http.dart' as http;
import 'package:ppl_app/constants.dart';

class TeamsUtils {
  Future<List<TeamData>> getTeams() async {
    try {
      http.Response resp = await http.get(Uri.parse(API_URL + "/teams"));
      if (resp.statusCode == 200) {
        Map bodyData = json.decode(resp.body);
        List<dynamic> teams = bodyData['data'];
        List<TeamData> teamsData = [];
        teams.forEach((team) {
          teamsData.add(TeamData.fromJson(team));
        });

        return teamsData;
      }
      return [];
    } catch (error) {
      print(error);
      return [];
    }
  }
}
