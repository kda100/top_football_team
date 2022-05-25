import 'package:top_football_team/constants/json_keys.dart';
import 'package:top_football_team/models/match_winner.dart';

///class to provide fake Json Map objects for conversion into objects.
class JsonMaps {
  ///returns readable standingsJson to be created by season object
  static Map<String, dynamic> genStandingsJson(
      {required int id, required String seasonEndDate}) {
    return {
      JsonKeys.season: {JsonKeys.id: id, JsonKeys.endDate: seasonEndDate}
    };
  }

  ///returns readable Match Json Map to create match object.
  static Map<String, dynamic> genMatchJson(
      {required int matchId,
      required int homeTeamId,
      required int awayTeamId,
      required MatchWinner matchWinner}) {
    return {
      JsonKeys.id: matchId,
      JsonKeys.homeTeam: {JsonKeys.id: homeTeamId},
      JsonKeys.awayTeam: {JsonKeys.id: awayTeamId},
      JsonKeys.score: {
        JsonKeys.winner: MatchWinnerConverter.encode(matchWinner),
      }
    };
  }

  ///returns readable Team Json Map to create Team object
  static Map<String, dynamic> genTeamJson(
      {required int teamId,
      required String name,
      required String crestLink,
      required String venue,
      required int yearFounded}) {
    return {
      JsonKeys.id: teamId,
      JsonKeys.name: name,
      JsonKeys.crestLink: crestLink,
      JsonKeys.venue: venue,
      JsonKeys.yearFounded: yearFounded,
    };
  }
}
