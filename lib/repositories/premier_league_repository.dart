import 'package:flutter/material.dart';
import 'package:top_football_team/helpers/datetime_helper.dart';
import 'package:top_football_team/models/match_winner.dart';

import '../constants/json_keys.dart';
import '../models/season.dart';
import '../models/team.dart';
import '../models/match.dart';
import '../services/premier_league_service.dart';

///Singleton.
///This class handles the business logic of the application.
///Data json is retrieved from the premier league service and converted into objects.
///Then further processed to extract the recent top performing premier league team based on their number of wins. (30 days).

class PremierLeagueRepository {
  static final PremierLeagueRepository _instance = PremierLeagueRepository._();

  PremierLeagueRepository._();

  factory PremierLeagueRepository() {
    return _instance;
  }

  @visibleForTesting
  PremierLeagueService premierLeagueService = PremierLeagueService();

  ///returns the most recent premier league season.
  @visibleForTesting
  Future<Season> getRecentSeason() async {
    final standingsJson = await premierLeagueService.getStandingsJson();
    return Season.fromJson(standingsJson[JsonKeys.season]);
  }

  ///function to get 'dateTo' query parameter for matches that is dependant on the season finishing date.
  @visibleForTesting
  DateTime getDateTo(DateTime seasonEndDate) {
    DateTime dateTo = DateTimeHelper.today();
    if (dateTo.isAfter(seasonEndDate)) {
      //if season is finished, use season end date.
      dateTo = seasonEndDate;
    }
    return dateTo;
  }

  ///returns 'dateFrom' query parameter for matches, that is 30 days less than 'dateTo parameter.
  @visibleForTesting
  DateTime getDateFrom(DateTime dateTo) {
    return dateTo.subtract(const Duration(days: 30)); // last 30 days.
  }

  ///returns the most recent matches that occurred in the last 30 days as a list of match objects.
  ///based on the end date of the most recent season.
  @visibleForTesting
  Future<List<Match>> getRecentMatches(Season season) async {
    DateTime dateTo = getDateTo(season.endDate);
    final dateFrom = getDateFrom(dateTo);
    final recentMatchesJson = await premierLeagueService.getRecentMatchesJson(
      dateTo: DateTimeHelper.dateTimeToString(dateTo),
      dateFrom: DateTimeHelper.dateTimeToString(dateFrom),
    );
    final List<Match> matches = [];
    for (var recentMatchJson in recentMatchesJson[JsonKeys.matches]) {
      matches.add(Match.fromJson(recentMatchJson));
    }
    return matches;
  }

  ///function to increment number of wins for a given teams id
  @visibleForTesting
  incrementTeamTally({
    required int winnersId,
    required Map<int, int> tally,
  }) {
    if (tally.containsKey(winnersId)) {
      tally[winnersId] = tally[winnersId]! + 1;
    } else {
      tally[winnersId] = 1;
    }
  }

  ///function that returns the id of the team with the greatest number of wins,
  ///based on the current team that won a match (winnersId) and the current team with the most wins (topTeamsId)
  @visibleForTesting
  int setTopTeamId({
    required int winnersId,
    required int topTeamsId,
    required Map<int, int> tally,
  }) {
    if (topTeamsId != -1) {
      if (tally[winnersId]! >= tally[topTeamsId]!) {
        //most recent winner has more or same wins as current top team, then topTeamsIds replaced.
        topTeamsId = winnersId;
      }
    } else {
      //topTeamsId initialised as -1 then first winning team becomes topTeamsId.
      topTeamsId = winnersId;
    }
    return topTeamsId;
  }

  ///returns the teams id with the most number of wins
  ///or if teams have same wins the team with most recent win
  ///or win later in the database are prioritised.
  ///if no team wins or if there are no matches -1 is returned.
  @visibleForTesting
  int getTopTeamsId(List<Match> recentMatches) {
    int topTeamsId = -1; //top team id initialised to -1.
    Map<int, int> tally = {}; //tally to keep track of team ids and their wins.
    for (Match match in recentMatches) {
      int? winnersId;
      if (match.winner == MatchWinner.HOMETEAM) {
        winnersId = match.homeTeamId;
      } else if (match.winner == MatchWinner.AWAYTEAM) {
        winnersId = match.awayTeamId;
      }
      if (winnersId != null) {
        incrementTeamTally(
          //increments tally of winners id
          winnersId: winnersId,
          tally: tally,
        );
        topTeamsId = setTopTeamId(
          //assigns new top teams id if necessary.
          winnersId: winnersId,
          tally: tally,
          topTeamsId: topTeamsId,
        );
      }
    }
    return topTeamsId;
  }

  ///returns a team object for team with most number of wins based on the id of team.
  @visibleForTesting
  Future<Team> getTopTeam(int id) async {
    final topTeamJson = await premierLeagueService.getTeamJson(id: id);
    return Team.fromJson(topTeamJson);
  }

  ///returns the top recent performing premier league team in the last 30 days.
  ///In the extreme case where all teams draw or there are no matches available a null value is returned.
  ///Where more than one team has the highest number of wins, the team that has won the most recent match.
  ///or has won a match that is retrieved later in the 'matches' database resource is prioritised (matches can have same time).
  Future<Team?> getTopPremierLeagueTeam() async {
    final Season season = await getRecentSeason();
    final List<Match> recentMatches = await getRecentMatches(season);
    final int topTeamId = getTopTeamsId(recentMatches);
    if (topTeamId != -1) {
      return await getTopTeam(topTeamId);
    }
    return null;
  }
}
