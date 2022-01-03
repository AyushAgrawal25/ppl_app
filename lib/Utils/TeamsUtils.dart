import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:ppl_app/Models/MemberData.dart';
import 'package:ppl_app/Models/TeamData.dart';

import 'package:http/http.dart' as http;
import 'package:ppl_app/Utils/ToastUtils.dart';
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

  Future<TeamData?> createTeam(TeamData teamData, XFile? imgFile) async {
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(API_URL + "/teams/create"));

      if (imgFile != null) {
        int imgLen = await imgFile.length();
        request.files.add(http.MultipartFile(
          'image',
          imgFile.readAsBytes().asStream(),
          imgLen,
          filename: imgFile.name,
        ));
      }

      request.fields['data'] = json.encode(teamData.toJson(true));
      http.StreamedResponse response = await request.send();

      // For Response Body.
      String respStr = await response.stream.bytesToString();
      print(respStr);

      if (response.statusCode == 201) {
        ToastUtils.showMessage("Team Created Successfully");
        Map respBody = json.decode(respStr);

        TeamData teamData = TeamData.fromJson(respBody['team']);
        return teamData;
      } else if (response.statusCode == 400) {
        ToastUtils.showMessage("Team Creation Failed");
      }

      return null;
    } catch (err) {
      print(err);
      ToastUtils.showMessage("Team Creation Failed");
      return null;
    }
  }

  Future<TeamData?> addMember(
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
        Map respBody = json.decode(response.body);
        return TeamData.fromJson(respBody['team']);
      }

      return null;
    } catch (err) {
      print(err);
      return null;
    }
  }
}

enum MemberAdditionStatus { added, failed }
