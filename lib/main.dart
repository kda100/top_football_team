import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:top_football_team/providers/top_premier_league_team_provider.dart';
import 'package:top_football_team/screens/top_premier_league_team_screen.dart';

import 'constants/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TopPremierLeagueTeamProvider(),
      child: MaterialApp(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TopPremierLeagueTeamScreen(),
      ),
    );
  }
}
