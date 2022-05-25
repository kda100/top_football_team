import 'package:top_football_team/constants/json_keys.dart';
import 'package:top_football_team/models/match_winner.dart';

///models each match

class Match {
  final int id; //not necessary
  final int homeTeamId;
  final int awayTeamId;
  final MatchWinner winner;

  Match(
      {required this.id,
      required this.homeTeamId,
      required this.awayTeamId,
      required this.winner});

  Match.fromJson(Map<String, dynamic> json)
      : id = json[JsonKeys.id],
        homeTeamId = json[JsonKeys.homeTeam][JsonKeys.id],
        awayTeamId = json[JsonKeys.awayTeam][JsonKeys.id],
        winner =
            MatchWinnerConverter.decode(json[JsonKeys.score][JsonKeys.winner]);
}
