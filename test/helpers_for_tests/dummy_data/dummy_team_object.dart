import 'package:top_football_team/models/team.dart';

///class to generate dummy team object for testing

class DummyTeamObject {
  ///generates a fake team object.
  static Team genTeam() {
    return Team(
      id: 65,
      name: "Manchester City FC",
      crestLink: "https://crests.football-data.org/65.png",
      venue: "Etihad Stadium",
      yearFounded: 1880,
    );
  }
}
