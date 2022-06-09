import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:top_football_team/helpers/datetime_helper.dart';
import 'package:top_football_team/models/match.dart';
import 'package:top_football_team/models/season.dart';
import 'package:top_football_team/repositories/premier_league_repository.dart';
import '../../../helpers_for_tests/dummy_data/dummy_match_json.dart';
import '../../../helpers_for_tests/mocks/mock_premier_league_service.dart';

void main() {
  group("getRecentMatches Function tests - ", () {
    final PremierLeagueRepository premierLeagueRepository =
        PremierLeagueRepository();
    late MockPremierLeagueService mockPremierLeagueService;
    final seasonEndDate = DateTime(2022, 05, 22);

    setUp(() {
      mockPremierLeagueService = MockPremierLeagueService();
      premierLeagueRepository.premierLeagueService = mockPremierLeagueService;
    });

    test(
        "When 'getDateTo' is called and season is still active the dateTo is the current day",
        () {
      final mockToday = seasonEndDate.subtract(const Duration(days: 30));
      fakeAsync((async) {
        final DateTime dateTo =
            premierLeagueRepository.getDateTo(seasonEndDate);

        expect(mockToday.isAtSameMomentAs(dateTo), true);
      }, initialTime: mockToday);
    });

    test(
        "When 'getDateTo' is called and season has finished the dateTo becomes the end date of the season",
        () {
      final mockToday = seasonEndDate.add(const Duration(days: 30));
      fakeAsync((async) {
        final DateTime dateTo =
            premierLeagueRepository.getDateTo(seasonEndDate);

        expect(seasonEndDate.isAtSameMomentAs(dateTo), true);
      }, initialTime: mockToday);
    });

    test(
        "when 'getDateFrom' is called a DateTime object is 30 days less than its date argument",
        () {
      final DateTime dateTo = DateTime(14, 3, 2022);

      expect(
        premierLeagueRepository.getDateFrom(dateTo),
        dateTo.subtract(
          const Duration(days: 30),
        ),
      );
    });

    test("when getRecentMatches is called a List<Match> is returned", () async {
      final Season season = Season(id: 0, endDate: DateTime(2022, 05, 22));
      final DateTime dateTo = premierLeagueRepository.getDateTo(season.endDate);
      final DateTime dateFrom = premierLeagueRepository.getDateFrom(dateTo);
      final Map<String, dynamic> dummyMatchJson = DummyMatchJson.genRandom();
      when(mockPremierLeagueService.getRecentMatchesJson(
        dateTo: DateTimeHelper.dateTimeToString(dateTo),
        dateFrom: DateTimeHelper.dateTimeToString(dateFrom),
      )).thenAnswer((_) async => dummyMatchJson);

      expect(await premierLeagueRepository.getRecentMatches(season),
          isA<List<Match>>());
    });
  });
}
