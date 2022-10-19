import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:second_mobile_exam/models/episode_model.dart';

const url = "https://rickandmortyapi.com/api/episode/";

class EpisodeProvider {
  //Function to get all locations from the api
  static Future<List<EpisodeModel>> getAllEpisodes(index) async {
    final response = await http.get(Uri.parse("$url?page=$index"));
    List<EpisodeModel> episodes = [];
    //Decoding data to use it
    final decode = jsonDecode(response.body);
    for (var episode in decode['results']) {
      episodes.add(EpisodeModel.fromJson(episode));
    }
    return episodes;
  }
}
