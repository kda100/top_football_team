import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:top_football_team/models/season.dart';
import 'package:top_football_team/repositories/premier_league_repository.dart';

import '../../../helpers_for_tests/json_maps.dart';
import '../../../helpers_for_tests/mocks/mock_premier_league_service.dart';

void main() {
  group("getRecentSeason function - ", () {
    final PremierLeagueRepository premierLeagueRepository =
        PremierLeagueRepository();
    late MockPremierLeagueService mockPremierLeagueService;

    /// sets up mock service, then assign service to repository,
    /// so functionality can be mocked.
    setUp(() {
      mockPremierLeagueService = MockPremierLeagueService();
      premierLeagueRepository.premierLeagueService = mockPremierLeagueService;
    });

    test("returns season object", () async {
      const String seasonEndDate = "2022-05-22";
      final Map<String, dynamic> standingsJson =
          JsonMaps.genStandingsJson(id: 200, seasonEndDate: seasonEndDate);
      final DateTime dateTime = DateTime.parse(seasonEndDate);
      when(mockPremierLeagueService.getStandingsJson())
          .thenAnswer((_) async => standingsJson);
      final Season season = await premierLeagueRepository.getRecentSeason();

      expect(season, isA<Season>());
      expect(season.endDate.isAtSameMomentAs(dateTime), true);
    });
  });
}
