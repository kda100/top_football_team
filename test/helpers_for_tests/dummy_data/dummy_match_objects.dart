import 'dart:math';
import 'package:top_football_team/models/match.dart';
import 'package:top_football_team/models/match_winner.dart';

///class used to generate fake Lists of Match objects to be used for testing

class DummyMatchObjects {
  ///generates a List<Match> where there is one that has won majority of matches.
  static List<Match> genTopTeam({int length = 38, required int topTeamId}) {
    assert(length > 6);
    assert(topTeamId > 20);
    final random = Random();
    return List.generate(length, (index) {
      final homeTeam = index % 2 == 0 ? topTeamId : random.nextInt(10) + 1;
      final randAwayTeam = homeTeam + 10;
      return Match(
          id: index,
          homeTeamId: homeTeam,
          awayTeamId: randAwayTeam,
          winner: MatchWinner.HOMETEAM);
    });
  }

  ///generates a List<Match> where every team draws.
  static List<Match> genDraws({int length = 38}) {
    final random = Random();
    return List.generate(length, (index) {
      final randHomeTeam = random.nextInt(10) + 1;
      final randAwayTeam = randHomeTeam + 10;
      return Match(
          id: index,
          homeTeamId: randHomeTeam,
          awayTeamId: randAwayTeam,
          winner: MatchWinner.DRAW);
    });
  }

  ///generates List<Match> where there are two teams win same number of wins
  ///but one team has a win later in the list
  static List<Match> genTwoTopTeams({
    required primaryTeamId,
    required secondaryTeamId,
    int length = 38,
  }) {
    assert(length % 2 == 0);
    assert(primaryTeamId > 10);
    assert(secondaryTeamId > 10);
    final random = Random();
    return List.generate(length, (index) {
      final isPrimaryId = index % 2 == 1;
      final homeTeamId = isPrimaryId ? primaryTeamId : secondaryTeamId;
      final randAwayTeam = random.nextInt(10) + 1;
      return Match(
          id: index,
          homeTeamId: homeTeamId,
          awayTeamId: randAwayTeam,
          winner: MatchWinner.HOMETEAM);
    });
  }
}
