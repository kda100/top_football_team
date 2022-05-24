import 'package:flutter/material.dart';
import 'package:top_football_team/models/team.dart';

import '../constants/font_sizes.dart';

///UI for presenting team in landscape mode.

class LandscapeTeamWidget extends StatelessWidget {
  final Team team;

  const LandscapeTeamWidget({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(
            team.crestLink,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(team.name,
                  style: const TextStyle(
                      fontSize: teamNameFontSize, fontWeight: FontWeight.bold)),
              Text(team.venue,
                  style: const TextStyle(fontSize: stadiumNameFontSize)),
              Text(team.yearFounded.toString(),
                  style: const TextStyle(fontSize: yearFoundedFontSize)),
            ],
          ),
        ],
      ),
    );
  }
}
