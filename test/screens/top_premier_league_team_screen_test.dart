import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:top_football_team/constants/strings.dart';
import 'package:top_football_team/models/api_response.dart';
import 'package:top_football_team/screens/top_premier_league_team_screen.dart';
import 'package:top_football_team/widgets/landscape_team_widget.dart';
import 'package:top_football_team/widgets/portrait_team_widget.dart';

import '../helpers_for_tests/dummy_data/dummy_team_object.dart';
import '../helpers_for_tests/mocks/custom_top_premier_league_team_provider.dart';
import '../helpers_for_tests/widget_tester_wrapper.dart';

void main() {
  group("TopPremierLeagueTeamScreen tests - ", () {
    late CustomTopPremierLeagueTeamProvider customTopPremierLeagueTeamProvider;
    setUp(() {
      customTopPremierLeagueTeamProvider = CustomTopPremierLeagueTeamProvider();
      HttpOverrides.global = null;
    });
    testWidgets(
        "When screen is first built a circular progress indicator is displayed",
        (tester) async {
      await tester.pumpWidget(
        WidgetTesterWrapper(
          topPremierLeagueTeamProvider: customTopPremierLeagueTeamProvider,
          widget: const TopPremierLeagueTeamScreen(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        "When api response is an error screen rebuilds to show an error message",
        (tester) async {
      await tester.pumpWidget(
        WidgetTesterWrapper(
          topPremierLeagueTeamProvider: customTopPremierLeagueTeamProvider,
          widget: const TopPremierLeagueTeamScreen(),
        ),
      );
      customTopPremierLeagueTeamProvider.apiResponse = ApiResponse.error();
      customTopPremierLeagueTeamProvider.notifyListeners();
      await tester.pump();

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets(
        "When api response is a success and there is no team to display a message is displayed.",
        (tester) async {
      await tester.pumpWidget(
        WidgetTesterWrapper(
          topPremierLeagueTeamProvider: customTopPremierLeagueTeamProvider,
          widget: const TopPremierLeagueTeamScreen(),
        ),
      );
      customTopPremierLeagueTeamProvider.apiResponse = ApiResponse.success();
      customTopPremierLeagueTeamProvider.notifyListeners();
      await tester.pump();

      expect(find.text(noTeamMessage), findsOneWidget);
    });

    testWidgets(
        "When api response is an success, there is a team to display and the phone is in portrait mode, PortraitTeamWidget is shown",
        (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(20, 42);
      await tester.pumpWidget(
        WidgetTesterWrapper(
          topPremierLeagueTeamProvider: customTopPremierLeagueTeamProvider,
          widget: const TopPremierLeagueTeamScreen(),
        ),
      );
      customTopPremierLeagueTeamProvider.apiResponse = ApiResponse.success();
      customTopPremierLeagueTeamProvider.topPremierLeagueTeam =
          DummyTeamObject.genTeam();
      customTopPremierLeagueTeamProvider.notifyListeners();
      await tester.pump();

      expect(find.byType(PortraitTeamWidget), findsOneWidget);
    });

    testWidgets(
        "When api response is an success, there is a team to display and the phone is in portrait mode, PortraitTeamWidget is shown",
        (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(42, 20);
      await tester.pumpWidget(
        WidgetTesterWrapper(
          topPremierLeagueTeamProvider: customTopPremierLeagueTeamProvider,
          widget: const TopPremierLeagueTeamScreen(),
        ),
      );
      customTopPremierLeagueTeamProvider.apiResponse = ApiResponse.success();
      customTopPremierLeagueTeamProvider.topPremierLeagueTeam =
          DummyTeamObject.genTeam();
      customTopPremierLeagueTeamProvider.notifyListeners();
      await tester.pump();

      expect(find.byType(LandscapeTeamWidget), findsOneWidget);
    });
  });
}
