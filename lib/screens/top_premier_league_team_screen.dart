import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_football_team/models/api_response.dart';
import 'package:top_football_team/providers/top_premier_league_team_provider.dart';
import 'package:top_football_team/widgets/landscape_team_widget.dart';
import 'package:top_football_team/widgets/portrait_team_widget.dart';

import '../constants/strings.dart';
import '../models/team.dart';

///builds screen for to display ui for top performing premier league team (most wins in 30 days).

class TopPremierLeagueTeamScreen extends StatefulWidget {
  const TopPremierLeagueTeamScreen({Key? key}) : super(key: key);

  @override
  State<TopPremierLeagueTeamScreen> createState() =>
      _TopPremierLeagueTeamScreenState();
}

class _TopPremierLeagueTeamScreenState
    extends State<TopPremierLeagueTeamScreen> {
  @override
  void initState() {
    Provider.of<TopPremierLeagueTeamProvider>(context, listen: false)
        .setTopPremierLeagueTeam();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(appTitle)),
      body: Consumer<TopPremierLeagueTeamProvider>(
          builder: (context, topPremierLeagueTeamProvider, _) {
        final ApiResponse apiResponse =
            topPremierLeagueTeamProvider.getApiResponse;
        if (apiResponse.responseType == ApiResponseType.LOADING) {
          return const Center(child: CircularProgressIndicator());
        } else if (apiResponse.responseType == ApiResponseType.ERROR) {
          return Center(
            child: Text(apiResponse.message),
          );
        }
        final Team? team = topPremierLeagueTeamProvider.getTopPremierLeagueTeam;
        if (team != null) {
          return Card(
            child: OrientationBuilder(builder: (context, orientation) { //handles UI for different orientations.
              if (orientation == Orientation.portrait) {
                return PortraitTeamWidget(team: team);
              } else {
                return LandscapeTeamWidget(
                  team: team,
                );
              }
            }),
          );
        } else {
          return const Center(
            child: Text("No Top Team"),
          );
        }
      }),
    );
  }
}
