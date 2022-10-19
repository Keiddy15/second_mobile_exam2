import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:second_mobile_exam/models/character_model.dart';
import 'package:second_mobile_exam/providers/character_provider.dart';
import 'package:second_mobile_exam/widgets/details_character_pop_up.dart';

class CharactersPage extends StatefulWidget {
  CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<CharacterModel> characters = [];
  var scrollcontroller = ScrollController();
  var page = 1;
  bool isLoading = false;


  //Function to call the provider and get all characters
  Future getAllCharacters(index) async {
    final data = await CharacterProvider().getAllCharacters(index);
    setState(() {
      if (index == 0) {
        characters = data;
      } else {
        for (var character in data) {
          characters.add(character);
        }
      }
    });
    return characters;
  }

  //Function to paginate
  pagination() {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (characters.length < 826)) {
      setState(() {
        isLoading = true;
        page += 1;
      });
      getAllCharacters(page);
    }
  }


  //Consuming endpoint to get all characters and adding listener to the scroll
  @override
  void initState() {
    super.initState();
    scrollcontroller.addListener(pagination);
    getAllCharacters(page);
  }

  @override
  Widget build(BuildContext context) {
    //Creating scaffold with a list view to display all characters
    //Adding scroller controller, to get more characters when scrolling
    return CupertinoPageScaffold(
        backgroundColor: const Color.fromARGB(255, 151, 206, 76),
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Colors.black,
          middle: Text('Ricky and Morty - CHARACTERS',
              style: TextStyle(color: CupertinoColors.white)),
        ),
        child: SafeArea(
            top: false,
            bottom: false,
            minimum: const EdgeInsets.only(
              left: 16,
              top: 30,
              bottom: 8,
              right: 8,
            ),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                controller: scrollcontroller,
                shrinkWrap: true,
                itemCount: characters.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(children: <Widget>[
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      color: CupertinoColors.white,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0)),
                      onPressed: () {
                        showCupertinoDialog(
                                            context: context,
                                            builder: (context) =>
                                                CharacterDetailsPopUp(location: characters[index].location.url, origin: characters[index].origin.url, name: characters[index].name));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Image.network(
                            characters[index].image,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(characters[index].name,
                                    style: const TextStyle(
                                        letterSpacing: 1.2,
                                        color: CupertinoColors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                const Padding(padding: EdgeInsets.only(top: 8)),
                                Row(children: <Widget>[
                                  FaIcon(FontAwesomeIcons.solidCircle,
                                      size: 10,
                                      color: characters[index].status == 'Alive'
                                          ? CupertinoColors.activeGreen
                                          : characters[index].status == "Dead"
                                              ? CupertinoColors.destructiveRed
                                              : CupertinoColors.systemGrey),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 8)),
                                  Text(
                                      "${characters[index].status} - ${characters[index].species}",
                                      style: const TextStyle(
                                          letterSpacing: 1.2,
                                          color: CupertinoColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ]),
                                Row(children: const <Widget>[
                                  FaIcon(FontAwesomeIcons.personHalfDress,
                                      size: 20,
                                      color: CupertinoColors.systemPurple),
                                  Padding(padding: EdgeInsets.only(right: 8)),
                                  Text("Male",
                                      style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: CupertinoColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ]);
                })));
  }
}
