import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:second_mobile_exam/models/character_model.dart';

const url = "https://rickandmortyapi.com/api/character/";

class CharacterProvider {
  //Function to get all characters from the api
  Future<List<CharacterModel>> getAllCharacters(index) async {
    final response = await http.get(Uri.parse("$url?page=$index"));
    List<CharacterModel> characters = [];
    //Decoding data to use it
    final decode = jsonDecode(response.body);
    for (var character in decode['results']) {
      characters.add(CharacterModel.fromJson(character));
    }
    return characters;
  }

  //Function to get multiple characters from the api
  Future<List<CharacterModel>> getMultipleCharacter(ids) async {
    final response = await http.get(Uri.parse('$url$ids'));
    List<CharacterModel> characters = [];
    //Decoding data to use it
    final decode = jsonDecode(response.body);
    for (var character in decode) {
      characters.add(CharacterModel.fromJson(character));
    }
    return characters;
  }
}
