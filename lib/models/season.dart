import 'package:flutter/material.dart';
import 'package:top_football_team/constants/json_keys.dart';

///models for season
class Season {
  final int id; //not necessary
  final DateTime endDate;

  Season.fromJson(Map<String, dynamic> json)
      : id = json[JsonKeys.id],
        endDate = DateTime.parse(json[JsonKeys.endDate]);
}
