import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_mobile_exam/models/location_model.dart';
import 'package:second_mobile_exam/providers/location_provider.dart';

class CharacterDetailsPopUp extends StatefulWidget {
  final String location;
  final String origin;
  final String name;
  CharacterDetailsPopUp(
      {Key? key,
      required this.location,
      required this.origin,
      required this.name})
      : super(key: key);

  @override
  State<CharacterDetailsPopUp> createState() => _CharacterDetailsPopUpState();
}

class _CharacterDetailsPopUpState extends State<CharacterDetailsPopUp> {
  List<LocationModel> locations = [];
  //Function to get multiple locations
  Future getMultipleLocations() async {
    final lct = widget.location
        .replaceAll("https://rickandmortyapi.com/api/location/", "");
    final orgn = widget.origin
        .replaceAll("https://rickandmortyapi.com/api/location/", "");
    final data = await LoacationProvider().getMultipleLocations("$lct,$orgn");
    setState(() {
      locations = data;
    });
    return locations;
  }

  @override
  void initState() {
    super.initState();
    getMultipleLocations();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('${widget.name} details'),
      content: Column(children: <Widget>[
        const Text("Location:"),
        const SizedBox(height: 20.0),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Name: "),
              Text(locations.isEmpty || locations[0].type == "null" ? "unknow" : locations[0].name)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Type: "),
              Text(locations.isEmpty || locations[0].type == "null" ? "unknow" : locations[0].type)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Dimension"),
              Text(locations.isEmpty || locations[0].type == "null" ? "unknow" : locations[0].dimension)
            ]),
        const Divider(color: Colors.black),
        const Text("Origin:"),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Name: "),
              Text(locations.isEmpty || locations.length == 1 || locations[1].type == "null" ? "unknow" : locations[1].name)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Type: "),
              Text(locations.isEmpty || locations.length == 1 || locations[1].type == "null" ? "unknow" : locations[1].type)
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text("Dimension"),
              Text(locations.isEmpty  || locations.length == 1 || locations[1].type == "null" ? "unknow" : locations[1].dimension)
            ]),
      ]),
      actions: [
        CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context)),
      ],
    );
  }
}
