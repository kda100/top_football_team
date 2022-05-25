import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:top_football_team/constants/football_data_api_resources.dart';
import 'package:top_football_team/helpers/premier_league_service_helper.dart';
import 'package:top_football_team/services/premier_league_service.dart';
import '../helpers_for_tests/mocks/mock_http_client.dart';

@GenerateMocks([http.Client])
void main() {
  group("PremierLeagueService initialisation tests - ", () {
    final PremierLeagueService premierLeagueService = PremierLeagueService();
    test("Is a singleton", () {
      expect(premierLeagueService == PremierLeagueService(), true);
    });
  });
  group("PremierLeagueService function tests - ", () {
    final PremierLeagueService premierLeagueService = PremierLeagueService();
    late MockClient mockClient;

    /// sets up PremierLeagueService object and MockClient, then assign MockClient to PremierLeagueService,
    /// so functionality can be mocked.
    setUp(() {
      mockClient = MockClient();
      premierLeagueService.client = mockClient;
    });

    void testSuccessHttpGetFunction(
        String url, Future<dynamic> Function() testFunction) async {
      const jsonData = '{"jsonData":"jsonData"}';
      when(mockClient.get(Uri.parse(url), headers: headers))
          .thenAnswer((_) async => http.Response(jsonData, 200));

      expect(await testFunction(), jsonDecode(jsonData));
    }

    void testFailedHttpGetFunction(String url, Function testFunction) {
      when(mockClient.get(Uri.parse(url), headers: headers))
          .thenAnswer((_) async => http.Response("Not found", 404));
      expect(testFunction(), throwsException);
    }

    test("test getStandingsJson Function", () {
      const url = standingsUrl;
      testSuccessHttpGetFunction(url, premierLeagueService.getStandingsJson);
      testFailedHttpGetFunction(url, premierLeagueService.getStandingsJson);
    });

    test("test getRecentMatchesJson Function", () {
      const dateTo = "2022-05-22";
      const dateFrom = "2022-04-22";
      final String url = PremierLeagueServiceHelper.genMatchesQueryUrl(
          dateFrom: dateFrom, dateTo: dateTo);
      testSuccessHttpGetFunction(
          url,
          () async => premierLeagueService.getRecentMatchesJson(
              dateTo: dateTo, dateFrom: dateFrom));
      testFailedHttpGetFunction(
          url,
          () async => premierLeagueService.getRecentMatchesJson(
              dateTo: dateTo, dateFrom: dateFrom));
    });

    test("test getTeamJson Function", () {
      const id = 52;
      final url = PremierLeagueServiceHelper.genTeamQueryUrl(id: id);
      testSuccessHttpGetFunction(
          url, () => premierLeagueService.getTeamJson(id: id));
      testFailedHttpGetFunction(
          url, () => premierLeagueService.getTeamJson(id: id));
    });
  });
}
