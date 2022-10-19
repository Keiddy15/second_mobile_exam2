import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:second_mobile_exam/models/location_model.dart';

const url = "https://rickandmortyapi.com/api/location/";

class LoacationProvider {
  //Function to get all locations from the api
  Future<List<LocationModel>> getAllLocations(index) async {
    final response = await http.get(Uri.parse("$url?page=$index"));
    List<LocationModel> locations = [];
    //Decoding data to use it
    final decode = jsonDecode(response.body);
    for (var location in decode['results']) {
      locations.add(LocationModel.fromJson(location));
    }
    return locations;
  }

//Function to get multiple locations from the api
  Future<List<LocationModel>> getMultipleLocations(ids) async {
    final response = await http.get(Uri.parse('$url$ids'));
    List<LocationModel> locations = [];
    //Decoding data to use it
    final decode = jsonDecode(response.body);
    for (var location in decode) {
      locations.add(LocationModel.fromJson(location));
    }
    return locations;
  }
}
