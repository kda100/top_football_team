import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

///Singleton service class that requests json data from the football api data.
///It strictly only returns json data converted into dart objects once http requests are made.

class PremierLeagueService {
  static final PremierLeagueService _instance = PremierLeagueService._();

  PremierLeagueService._();

  factory PremierLeagueService() {
    return _instance;
  }

  //request header necessary for getting data.
  static const _headers = {"X-Auth-Token": "c72b06bc90614e13a780910779372185"};

  static const _baseUrl = "https://api.football-data.org/v4/";

  @visibleForTesting //url to get details of premier league matches data can be filtered by adding query params.
  static const matchesUrl = "${_baseUrl}competitions/PL/matches";

  @visibleForTesting //url to get current premier league standings, only used to get season end date.
  static const standingsUrl = "${_baseUrl}competitions/PL/standings";

  @visibleForTesting //used to get teams, an id parameter can be added to only retrieved on team.
  static const teamsUrl = "$_baseUrl/teams";

  @visibleForTesting
  http.Client client = http.Client();

  ///returns json data for current premier league standings.
  Future<dynamic> getStandings() async {
    final http.Response response =
        await client.get(Uri.parse(standingsUrl), headers: _headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get standings.");
    }
  }

  ///returns json data on a single team given the id.
  Future<dynamic> getTeam({required id}) async {
    final http.Response response =
        await client.get(Uri.parse("$teamsUrl/$id"), headers: _headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get team.");
    }
  }

  ///returns json data on the finished matches between two dates given in 'YYYY-MM-DD' format.
  Future<dynamic> getRecentMatchesJson({
    required String dateTo,
    required String dateFrom,
  }) async {
    final http.Response response = await client.get(
      Uri.parse(
          "$matchesUrl?dateFrom=$dateFrom&dateTo=$dateTo&status=FINISHED"),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get recent matches.");
    }
  }
}
