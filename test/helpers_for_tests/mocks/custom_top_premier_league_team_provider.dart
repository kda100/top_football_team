import 'package:top_football_team/providers/top_premier_league_team_provider.dart';

///fake TopPremierLeagueTeamProvider class for widget tester wrapper.
class CustomTopPremierLeagueTeamProvider extends TopPremierLeagueTeamProvider {
  @override
  Future<void> setTopPremierLeagueTeam() async {
    return;
  }
}
