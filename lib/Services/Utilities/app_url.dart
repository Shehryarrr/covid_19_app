class AppUrl {
  // this is our base Url

  static const String baseUrl = 'https://disease.sh/v3/covid-19/';

  //fetch World Covid States

  static String worldStatesApi = '${baseUrl}all';
  static String countriesList = '${baseUrl}countries';
}
