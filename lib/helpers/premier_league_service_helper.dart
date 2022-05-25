import 'package:top_football_team/services/premier_league_service.dart';

import '../constants/football_data_api_resources.dart';

///helper class for generating football data api urls with query parameters.

class PremierLeagueServiceHelper {
  ///gen url for matches with dateFrom, dateTo and status FINISHED query parameters
  static String genMatchesQueryUrl(
      {required String dateFrom, required String dateTo}) {
    return "$matchesUrl?dateFrom=$dateFrom&dateTo=$dateTo&status=FINISHED";
  }

  ///gens url for querying one team.
  static String genTeamQueryUrl({required int id}) {
    return "$teamsUrl/$id";
  }
}
