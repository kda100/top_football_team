import 'package:flutter/material.dart';
import 'package:top_football_team/providers/top_premier_league_team_provider.dart';
import 'package:provider/provider.dart';

import 'mocks/custom_top_premier_league_team_provider.dart';

///wrapper to test widgets.

class WidgetTesterWrapper extends StatelessWidget {
  final TopPremierLeagueTeamProvider?
      topPremierLeagueTeamProvider; //testing provider class.
  final Widget widget;

  const WidgetTesterWrapper({
    Key? key,
    this.topPremierLeagueTeamProvider,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TopPremierLeagueTeamProvider>(
      create: (context) =>
          topPremierLeagueTeamProvider ?? CustomTopPremierLeagueTeamProvider(),
      child: MaterialApp(
        home: widget,
      ),
    );
  }
}
