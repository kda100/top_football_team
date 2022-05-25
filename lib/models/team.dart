import 'package:flutter/cupertino.dart';
import 'package:top_football_team/constants/json_keys.dart';

///model for team

class Team {
  final int id; //not necessary
  final String name;
  final String crestLink;
  final String venue;
  final int yearFounded;

  @visibleForTesting
  Team({
    required this.id,
    required this.name,
    required this.crestLink,
    required this.venue,
    required this.yearFounded,
  });

  Team.fromJson(Map<String, dynamic> json)
      : id = json[JsonKeys.id],
        name = json[JsonKeys.name],
        crestLink = json[JsonKeys.crestLink],
        venue = json[JsonKeys.venue],
        yearFounded = json[JsonKeys.yearFounded];
}
