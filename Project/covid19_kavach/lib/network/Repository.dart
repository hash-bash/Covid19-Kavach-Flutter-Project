import 'package:covid19_kavach/models/ModelGlobal.dart';
import 'package:covid19_kavach/models/ModelLatest.dart';
import 'package:covid19_kavach/models/ModelNews.dart';
import 'package:covid19_kavach/network/ApiProvider.dart';

class Repository {
  var apiProvider = ApiProvider();

  Future<RpLatest> getGloballyLatestData() =>
      apiProvider.getGloballyLatestData();

  Future<List<Country>> getAllCountriesData() =>
      apiProvider.getAllCountriesData();

  Future<Country> getUserCountryData(String countryCode) =>
      apiProvider.getUserCountryData(countryCode);

  Future<RpNews> getNewses() => apiProvider.getNewses();
}
