class PlayerData {
  late int id;
  late int memberId;
  late double battingScore;
  late double bowlingScore;
  late int centuries;
  late int matches;
  late int wickets;
  late PlayerSpeciality speciality;
  late int status;

  PlayerData({
    required this.id,
    required this.wickets,
    required this.speciality,
    required this.battingScore,
    required this.bowlingScore,
    required this.centuries,
    required this.matches,
    required this.memberId,
    required this.status,
  });

  PlayerData.fromJson(Map playerData) {
    id = playerData['id'];
    wickets = playerData['wickets'];
    speciality = getPlayerSpecialityFromString(playerData['speciality']);
    battingScore = (playerData['battingScore']).toDouble();
    bowlingScore = (playerData['bowlingScore']).toDouble();
    centuries = playerData['centuries'];
    matches = playerData['matches'];
    memberId = playerData['memberId'];
    status = playerData['status'];
  }
}

PlayerSpeciality getPlayerSpecialityFromString(String spec) {
  for (int i = 0; i < PlayerSpeciality.values.length; i++) {
    if (PlayerSpeciality.values[i].toString().split('.')[1] == spec) {
      return PlayerSpeciality.values[i];
    }
  }

  return PlayerSpeciality.allRounder;
}

String getPlayerSpecialityAsString(PlayerSpeciality speciality) {
  return speciality.toString().split('.')[1];
}

enum PlayerSpeciality { batsman, bowler, allRounder }
