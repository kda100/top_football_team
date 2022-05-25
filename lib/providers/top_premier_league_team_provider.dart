import 'package:flutter/material.dart';
import 'package:top_football_team/models/api_response.dart';
import 'package:top_football_team/repositories/premier_league_repository.dart';

import '../models/team.dart';

///This class handles the state of the UI and store team object of top performing premier league team.
///The class has a loading state while business logic is being performed by the repository class.
///when business logic has finished a Team object has been returned then class notifies UI of change and updates it.
class TopPremierLeagueTeamProvider with ChangeNotifier {
  @visibleForTesting
  PremierLeagueRepository premierLeagueRepository = PremierLeagueRepository();

  @visibleForTesting
  ApiResponse apiResponse = ApiResponse.loading(); //starts of as loading.

  @visibleForTesting
  Team? topPremierLeagueTeam;

  Team? get getTopPremierLeagueTeam => topPremierLeagueTeam;

  ApiResponse get getApiResponse => apiResponse;

  ///function sets the top performing team then sets response object as error or success.
  Future<void> setTopPremierLeagueTeam() async {
    try {
      topPremierLeagueTeam =
          await premierLeagueRepository.getTopPremierLeagueTeam();
      apiResponse = ApiResponse.success();
    } catch (e) {
      apiResponse = ApiResponse.error();
    }
    notifyListeners();
  }
}
