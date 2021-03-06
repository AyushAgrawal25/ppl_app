import 'package:ppl_app/Models/MemberData.dart';

class TeamData {
  late int id;
  late String name;
  late int status;
  late String? logoFile;
  late List<MemberData> members;

  TeamData({
    required this.id,
    required this.name,
    required this.status,
    this.logoFile,
    required this.members,
  });

  TeamData.fromJson(Map teamData) {
    id = teamData['id'];
    name = teamData['name'];
    status = teamData['status'];
    logoFile = teamData['logoFile'];
    members = [];
    teamData['members'].forEach((memberData) {
      members.add(MemberData.fromJson(memberData));
    });
  }

  Map<String, dynamic> toJson(bool forCreation) {
    Map<String, dynamic> teamData = {};
    if (!forCreation) {
      teamData['id'] = id;
      teamData['logoFile'] = logoFile;
      teamData['status'] = status;
    }

    List<Map<String, dynamic>> membersData = [];
    members.forEach((MemberData member) {
      membersData.add(member.toJson(forCreation));
    });

    teamData['members'] = membersData;

    teamData['name'] = name;

    return teamData;
  }
}
