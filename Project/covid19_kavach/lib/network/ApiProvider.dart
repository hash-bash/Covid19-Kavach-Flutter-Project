import 'dart:convert';
import 'dart:io';

import 'package:covid19_kavach/models/ModelGlobal.dart';
import 'package:covid19_kavach/models/ModelLatest.dart';
import 'package:covid19_kavach/models/ModelNews.dart';
import 'package:http/http.dart';

class ApiProvider {
  Client client = new Client();

  Future<List<Country>> getAllCountriesData() async {
    var response = await client.get(
        'https://corona.lmao.ninja/v2/countries?sort=cases',
        headers: {HttpHeaders.acceptHeader: "application/json"});

    if (response.statusCode == 200) {
      return rpAllCountriesFromJson((response.body));
    } else {
      throw Exception('Failed to get global data');
    }
  }

  Future<RpLatest> getGloballyLatestData() async {
    var response = await client.get('https://corona.lmao.ninja/v2/all',
        headers: {HttpHeaders.acceptHeader: "application/json"});

    if (response.statusCode == 200) {
      return RpLatest.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get global data');
    }
  }

  Future<RpNews> getNewses() async {
    var response = await client.get(
        'https://newsapi.org/v2/everything?q=vaccine&from=2021-04-10&sortBy=popularity&apiKey=a8e98ea61ecc4aa69be04b13de6508bd&language=en',
        headers: {HttpHeaders.acceptHeader: "application/json"});

    if (response.statusCode == 200) {
      return RpNews.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get newses');
    }
  }

  Future<Country> getUserCountryData(String country) async {
    var response = await client.get(
        'https://corona.lmao.ninja/v2/countries/$country',
        headers: {HttpHeaders.acceptHeader: "application/json"});

    if (response.statusCode == 200) {
      return Country.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get global data');
    }
  }
}
