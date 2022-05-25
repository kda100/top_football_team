import 'package:top_football_team/constants/json_keys.dart';
import 'dart:math';

import 'package:top_football_team/models/match_winner.dart';

import '../json_maps.dart';

///helper class to emulate the match data received from the football api database used for testing.
class DummyMatchJson {
  ///function returns a map object of json match data to be read and converted into Match objects
  static Map<String, dynamic> genRandom({int length = 38}) {
    final random = Random();
    return {
      JsonKeys.matches: List.generate(length, (index) {
        final randHomeTeam = random.nextInt(10) + 1;
        final randAwayTeam = randHomeTeam + 10;
        return JsonMaps.genMatchJson(
            matchId: index,
            homeTeamId: randHomeTeam,
            awayTeamId: randAwayTeam,
            matchWinner: MatchWinner.values[random.nextInt(3)]);
      })
    };
  }
}
