import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:top_football_team/models/api_response.dart';
import 'package:top_football_team/models/team.dart';
import 'package:top_football_team/providers/top_premier_league_team_provider.dart';
import 'package:top_football_team/repositories/premier_league_repository.dart';
import '../helpers_for_tests/dummy_data/dummy_team_object.dart';
import '../helpers_for_tests/mocks/premier_league_repository_mock.dart';

@GenerateMocks([PremierLeagueRepository])
void main() {
  group("TopPremierLeagueTeamProvider initialisation", () {
    final TopPremierLeagueTeamProvider topPremierLeagueTeamProvider =
        TopPremierLeagueTeamProvider();
    test(
        "On initialisation ApiResponse object is of type loading and team is null.",
        () {
      expect(topPremierLeagueTeamProvider.getApiResponse.responseType,
          ApiResponseType.LOADING);
      expect(topPremierLeagueTeamProvider.getTopPremierLeagueTeam, null);
    });
  });

  group("TopPremierLeagueTeamProvider function tests", () {
    late TopPremierLeagueTeamProvider topPremierLeagueTeamProvider;
    late MockPremierLeagueRepository mockPremierLeagueRepository;
    late bool listenersNotified;

    /// sets up provider object and mock repository, then assign repository to provider,
    /// so functionality can be mocked.
    setUp(() {
      listenersNotified = false;
      topPremierLeagueTeamProvider = TopPremierLeagueTeamProvider();
      mockPremierLeagueRepository = MockPremierLeagueRepository();
      topPremierLeagueTeamProvider.premierLeagueRepository =
          mockPremierLeagueRepository;
      topPremierLeagueTeamProvider.addListener(() => listenersNotified = true);
    });

    tearDown(() {
      topPremierLeagueTeamProvider.dispose();
    });

    test(
        "When setTopPremierLeagueTeam sets a team object the ApiResponse object becomes a success and listeners are notified",
        () async {
      final Team team = DummyTeamObject.genTeam();
      when(mockPremierLeagueRepository.getTopPremierLeagueTeam())
          .thenAnswer((_) async => team);
      await topPremierLeagueTeamProvider.setTopPremierLeagueTeam();
      expect(listenersNotified, true);
      expect(topPremierLeagueTeamProvider.apiResponse.responseType,
          ApiResponseType.SUCCESS);
      expect(topPremierLeagueTeamProvider.getTopPremierLeagueTeam, team);
    });

    test(
        "When setTopPremierLeagueTeam sets a null object for team the ApiResponse object becomes a success and listeners are notified",
        () async {
      when(mockPremierLeagueRepository.getTopPremierLeagueTeam())
          .thenAnswer((_) async => null);
      await topPremierLeagueTeamProvider.setTopPremierLeagueTeam();
      expect(listenersNotified, true);
      expect(topPremierLeagueTeamProvider.apiResponse.responseType,
          ApiResponseType.SUCCESS);
      expect(topPremierLeagueTeamProvider.getTopPremierLeagueTeam, null);
    });

    test(
        "When setTopPremierLeagueTeam throws an error the ApiResponse object becomes a error and listeners are notified",
        () async {
      when(mockPremierLeagueRepository.getTopPremierLeagueTeam())
          .thenAnswer((_) => throw Exception());
      await topPremierLeagueTeamProvider.setTopPremierLeagueTeam();
      expect(listenersNotified, true);
      expect(topPremierLeagueTeamProvider.apiResponse.responseType,
          ApiResponseType.ERROR);
    });
  });
}
