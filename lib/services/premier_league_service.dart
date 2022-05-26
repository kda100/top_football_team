import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:top_football_team/helpers/premier_league_service_helper.dart';

import '../constants/football_data_api_resources.dart';

///Singleton service class that requests json data from the football api data on premier league info.
///It strictly only returns json data converted into dart objects once http requests are made.

class PremierLeagueService {
  static final PremierLeagueService _instance = PremierLeagueService._();

  PremierLeagueService._();

  factory PremierLeagueService() {
    return _instance;
  }

  @visibleForTesting
  http.Client client = http.Client();

  ///returns json data for current premier league standings.
  Future<dynamic> getStandingsJson() async {
    final http.Response response =
        await client.get(Uri.parse(standingsUrl), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get standings.");
    }
  }

  ///returns json data on the finished matches between two dates given in 'YYYY-MM-DD' format.
  Future<dynamic> getRecentMatchesJson({
    required String dateTo,
    required String dateFrom,
  }) async {
    final http.Response response = await client.get(
      Uri.parse(PremierLeagueServiceHelper.genMatchesQueryUrl(
          dateFrom: dateFrom, dateTo: dateTo)),
      headers: headers,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get recent matches.");
    }
  }

  ///returns json data on a single team given the id.
  Future<dynamic> getTeamJson({required id}) async {
    final http.Response response = await client.get(
        Uri.parse(PremierLeagueServiceHelper.genTeamQueryUrl(id: id)),
        headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to get team.");
    }
  }
}
