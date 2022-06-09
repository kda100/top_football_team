import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:top_football_team/repositories/premier_league_repository.dart';
import 'package:top_football_team/services/premier_league_service.dart';

@GenerateMocks([PremierLeagueService])
void main() {
  group("Premier League Repository initialisation tests - ", () {
    test("Is a Singleton", () {
      final PremierLeagueRepository premierLeagueRepository =
          PremierLeagueRepository();
      expect(PremierLeagueRepository() == premierLeagueRepository, true);
    });
  });
}
