import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static String today = "today";

  static Future<List<WebtoonModel>> getTodayToons() async {
    List<WebtoonModel> webtoonInstances = [];

    final url = Uri.parse("$baseUrl/$today");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webtoonList = jsonDecode(response.body);

      for (var webtoon in webtoonList) {
        final toon = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(toon);
      }
      return webtoonInstances;
    }
    throw Error;
  }

  static Future<WebtoonDetailModel> getDetailById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final detail = jsonDecode(response.body);
      print(WebtoonDetailModel.fromJson(detail));
      return WebtoonDetailModel.fromJson(detail);
    }
    throw Error;
  }

  static Future<List<WebtoonEpisodeModel>> getEpisodesById(String id) async {
    List<WebtoonEpisodeModel> episodeInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> episodeList = jsonDecode(response.body);
      for (var episode in episodeList) {
        episodeInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodeInstances;
    }
    throw Error;
  }
}
