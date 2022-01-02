import 'dart:convert';
import 'dart:io';

import 'package:ppl_app/Models/MemberData.dart';
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

  Future<TeamCreationStatus> createTeam(
      TeamData teamData, File? imgFile) async {
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(API_URL + "/teams/create"));

      if (imgFile != null) {
        request.files.add(http.MultipartFile(
          'image',
          imgFile.readAsBytes().asStream(),
          imgFile.lengthSync(),
          filename: imgFile.path.split("/").last,
        ));
      }

      request.fields['data'] = json.encode(teamData.toJson(true));
      http.StreamedResponse response = await request.send();

      // For Response Body.
      print(await response.stream.bytesToString());

      if (response.statusCode == 201) {
        return TeamCreationStatus.created;
      } else if (response.statusCode == 205) {
        return TeamCreationStatus.memberAdditionFailed;
      }

      return TeamCreationStatus.failed;
    } catch (err) {
      print(err);
      return TeamCreationStatus.failed;
    }
  }

  Future<MemberAdditionStatus> addMember(
      {required MemberData memberData, required int teamId}) async {
    try {
      Map<String, dynamic> reqBody = {
        "teamId": teamId,
        "members": [memberData.toJson(true)]
      };

      http.Response response = await http.post(
          Uri.parse(API_URL + "/teams/members/add"),
          body: jsonEncode(reqBody),
          headers: {CONTENT_TYPE_KEY: JSON_CONTENT_VALUE});

      // print(response.body);
      if (response.statusCode == 201) {
        return MemberAdditionStatus.added;
      }
      return MemberAdditionStatus.failed;
    } catch (err) {
      print(err);
      return MemberAdditionStatus.failed;
    }
  }
}

enum TeamCreationStatus { created, memberAdditionFailed, failed }

enum MemberAdditionStatus { added, failed }
