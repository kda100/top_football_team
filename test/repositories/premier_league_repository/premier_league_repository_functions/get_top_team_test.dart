import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:top_football_team/models/team.dart';
import 'package:top_football_team/repositories/premier_league_repository.dart';

import '../../../helpers_for_tests/json_maps.dart';
import '../../../helpers_for_tests/mocks/mock_premier_league_service.dart';

void main() {
  group("getTopTeam function tests - ", () {
    final PremierLeagueRepository premierLeagueRepository =
        PremierLeagueRepository();
    late MockPremierLeagueService mockPremierLeagueService;

    /// sets up mock service, then assign service to repository,
    /// so functionality can be mocked.
    setUp(() {
      mockPremierLeagueService = MockPremierLeagueService();
      premierLeagueRepository.premierLeagueService = mockPremierLeagueService;
    });

    test("return team object", () async {
      const teamId = 65;
      final teamJson = JsonMaps.genTeamJson(
        teamId: teamId,
      );
      when(mockPremierLeagueService.getTeamJson(id: teamId))
          .thenAnswer((_) async => teamJson);

      expect(await premierLeagueRepository.getTopTeam(teamId), isA<Team>());
    });
  });
}
