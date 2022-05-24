import 'package:flutter/material.dart';
import 'package:top_football_team/constants/font_sizes.dart';

import '../models/team.dart';

///UI for presenting team in portrait mode.

class PortraitTeamWidget extends StatelessWidget {
  final Team team;

  const PortraitTeamWidget({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(team.crestLink,
              width: double.infinity,
              alignment: Alignment.center,
              fit: BoxFit.contain),
          Text(
            team.name,
            style: const TextStyle(
              fontSize: teamNameFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            team.venue,
            style: const TextStyle(fontSize: stadiumNameFontSize),
          ),
          Text(
            team.yearFounded.toString(),
            style: const TextStyle(fontSize: yearFoundedFontSize),
          ),
        ],
      ),
    );
  }
}
