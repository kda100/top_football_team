//Sign up to https://www.football-data.org/ to get your API_KEY then add to header.

const Map<String, String> headers = {
  "X-Auth-Token": "c72b06bc90614e13a780910779372185"
}; //request header necessary for getting data. Add your API_KEY here.

const String baseUrl = "https://api.football-data.org/v4/";
const String standingsUrl =
    "${baseUrl}competitions/PL/standings"; //url to get details of premier league matches data can be filtered by adding query params.
const String matchesUrl =
    "${baseUrl}competitions/PL/matches"; //url to get current premier league standings, only used to get season end date.
const String teamsUrl =
    "$baseUrl/teams"; //used to get teams, an id parameter can be added to only retrieve data on team.
