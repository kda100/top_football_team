// ignore_for_file: constant_identifier_names

import 'package:top_football_team/helpers/enum_helper.dart';

///match winner enum.
enum MatchWinner { HOMETEAM, AWAYTEAM, DRAW }

///class to convert MatchWinner enum from string type to enum object.
class MatchWinnerConverter {
  static final EnumValues<MatchWinner> _matchWinner = EnumValues<MatchWinner>({
    "HOME_TEAM": MatchWinner.HOMETEAM,
    "AWAY_TEAM": MatchWinner.AWAYTEAM,
    "DRAW": MatchWinner.DRAW,
  });

  ///gets the string equivalent of enum.
  static String encode(MatchWinner matchWinner) =>
      _matchWinner.getTypeToValueMap[matchWinner]!;

  ///converts string value of enum to enum object
  static MatchWinner decode(String matchWinner) =>
      _matchWinner.getValueToTypeMap[matchWinner]!;
}
