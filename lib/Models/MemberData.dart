import 'package:ppl_app/Models/PlayerData.dart';

class MemberData {
  late int id;
  late String firstName;
  late String lastName;
  late int teamId;
  late MemberType type;
  late int age;
  late int status;
  PlayerData? playerData;

  MemberData({
    required this.id,
    required this.age,
    required this.firstName,
    required this.lastName,
    this.playerData,
    required this.teamId,
    required this.status,
    required this.type,
  });

  MemberData.fromJson(Map memberData) {
    id = memberData['id'];
    age = memberData['age'];
    firstName = memberData['firstName'];
    lastName = memberData['lastName'];
    if (memberData['player'] != null) {
      playerData = PlayerData.fromJson(memberData['player']);
    }
    type = getMemberTypeFromString(memberData['type']);
    teamId = memberData['teamId'];
    status = memberData['status'];
  }
}

enum MemberType {
  owner,
  player,
  coach,
  manager,
  staff,
  sponsor,
}

MemberType getMemberTypeFromString(String type) {
  for (int i = 0; i < MemberType.values.length; i++) {
    MemberType memType = MemberType.values[i];
    if (memType.toString().split('.')[1] == type) {
      return memType;
    }
  }

  return MemberType.staff;
}

String getMemberTypeAsString(MemberType type) {
  return type.toString().split('.')[1];
}
