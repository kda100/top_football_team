import 'package:top_football_team/constants/json_keys.dart';

class Team {
  final int id;
  final String name;
  final String crestLink;
  final String venue;
  final int yearFounded;

  Team.fromJson(Map<String, dynamic> json)
      : id = json[JsonKeys.id],
        name = json[JsonKeys.name],
        crestLink = json[JsonKeys.crestLink],
        venue = json[JsonKeys.venue],
        yearFounded = json[JsonKeys.yearFounded];
}
