import 'package:flutter_test/flutter_test.dart';
import 'package:top_football_team/models/match.dart';
import 'package:top_football_team/repositories/premier_league_repository.dart';

import '../../../helpers_for_tests/dummy_data/dummy_match_objects.dart';

void main() {
  final PremierLeagueRepository premierLeagueRepository =
      PremierLeagueRepository();

  group("getTopTeam Function - ", () {
    test(
        "when 'incrementTeamTally' is called and team id is not in tally (map), an entry is added with the value of 1",
        () {
      const winnersId = 2;
      Map<int, int> tally = {};
      premierLeagueRepository.incrementTeamTally(
          winnersId: winnersId, tally: tally);
      expect(tally[winnersId], 1);
    });

    test(
        "when 'incrementTeamTally' is called and team id is in tally then tally is just incremented by 1",
        () {
      const winnersId = 2;
      Map<int, int> tally = {2: 1};
      premierLeagueRepository.incrementTeamTally(
          winnersId: winnersId, tally: tally);
      expect(tally[winnersId], 2);
    });

    test(
        "when calling 'setTopTeamId', if topTeamId is currently -1, then winnerId is returned",
        () {
      const int topTeamsId = -1;
      const int winnerId = 5;
      const Map<int, int> tally = {5: 1};
      expect(
          premierLeagueRepository.setTopTeamId(
              winnersId: winnerId, topTeamsId: topTeamsId, tally: tally),
          winnerId);
    });

    test(
        "when calling 'setTopTeamId', if current winnerId has more or same wins as current topTeamId, then winnerId is returned",
        () {
      const int topTeamsId = 2;
      const int winnerId = 5;
      Map<int, int> tally = {2: 1, 5: 1};
      expect(
          premierLeagueRepository.setTopTeamId(
              winnersId: winnerId, topTeamsId: topTeamsId, tally: tally),
          winnerId);

      tally = {2: 1, 5: 3};
      expect(
          premierLeagueRepository.setTopTeamId(
              winnersId: winnerId, topTeamsId: topTeamsId, tally: tally),
          winnerId);
    });

    test(
        "when calling 'setTopTeamId', if current winnerId has less wins as current topTeamId, then topTeamId is returned",
        () {
      const int topTeamsId = 2;
      const int winnerId = 5;
      Map<int, int> tally = {2: 2, 5: 1};

      expect(
          premierLeagueRepository.setTopTeamId(
              winnersId: winnerId, topTeamsId: topTeamsId, tally: tally),
          topTeamsId);
    });

    test("'getTopTeamId' returns correct topTeamId", () {
      const topTeamId = 22;
      final List<Match> matches =
          DummyMatchObjects.genTopTeam(topTeamId: topTeamId);

      expect(premierLeagueRepository.getTopTeamsId(matches), topTeamId);
    });

    test("when there are no matches available 'getTopTeamId returns -1", () {
      expect(premierLeagueRepository.getTopTeamsId([]), -1);
    });

    test("when all matches are draws 'getTopTeamId' returns correct -1", () {
      final List<Match> matches = DummyMatchObjects.genDraws();

      expect(premierLeagueRepository.getTopTeamsId(matches), -1);
    });

    test(
        "when there are more than one top team 'getTopTeamId' returns the team who won last",
        () {
      const primaryTeamId = 22; //team who won most recent most in db.
      const secondaryTeamId = 25;
      final List<Match> matches = DummyMatchObjects.genTwoTopTeams(
          primaryTeamId: primaryTeamId, secondaryTeamId: secondaryTeamId);

      expect(premierLeagueRepository.getTopTeamsId(matches), primaryTeamId);
    });
  });
}
