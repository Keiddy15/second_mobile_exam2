import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:second_mobile_exam/models/episode_model.dart';
import 'package:second_mobile_exam/providers/episode_provider.dart';
import 'package:second_mobile_exam/widgets/character_pop_up.dart';

class EpisodesPage extends StatefulWidget {
  EpisodesPage({Key? key}) : super(key: key);

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  List<EpisodeModel> episodes = [];
  var scrollcontroller = ScrollController();
  var page = 1;
  bool isLoading = false;

  //Function to call the provider and get all episodes
  Future getAllEpisodes(index) async {
    final data = await EpisodeProvider.getAllEpisodes(index);
    setState(() {
      if (index == 0) {
        episodes = data;
      } else {
        for (var episode in data) {
          episodes.add(episode);
        }
      }
    });
    return episodes;
  }

  //Function to paginate
  pagination() {
    if ((scrollcontroller.position.pixels ==
            scrollcontroller.position.maxScrollExtent) &&
        (episodes.length < 826)) {
      setState(() {
        isLoading = true;
        page += 1;
      });
      getAllEpisodes(page);
    }
  }

  //Consuming endpoint to get all episodes and adding listener to the scroll
  @override
  void initState() {
    super.initState();
    scrollcontroller.addListener(pagination);
    getAllEpisodes(page);
  }

  @override
  Widget build(BuildContext context) {
    const headerTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFFFEFFFE),
      fontSize: 12.0,
    );
    const dataTextStyle = TextStyle(
      fontSize: 12.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
//Creating scaffold with a data table to display all episodes
    //Adding scroller controller, to get more episodes when scrolling
    return CupertinoPageScaffold(
        backgroundColor: const Color.fromARGB(255, 151, 206, 76),
        navigationBar: const CupertinoNavigationBar(
          backgroundColor: Colors.black,
          middle: Text('Ricky and Morty - EPISODES',
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
            child: SingleChildScrollView(
                controller: scrollcontroller,
                child: DataTable(
                    sortColumnIndex: 0,
                    headingTextStyle: headerTextStyle,
                    horizontalMargin: 15.0,
                    columnSpacing: 10.0,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    headingRowHeight: 36.0,
                    columns: <DataColumn>[
                      DataColumn(
                        label: headerText('ID'),
                      ),
                      DataColumn(label: headerText('Name')),
                      DataColumn(label: headerText('Air Date')),
                      DataColumn(label: headerText('Characters')),
                    ],
                    rows: List.generate(
                        episodes.length,
                        (int index) => DataRow(
                                color: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (index % 2 == 0)
                                    return Color.fromARGB(255, 230, 67, 162);
                                  return const Color(0xFFe89ac7);
                                }),
                                cells: [
                                  DataCell(Text(episodes[index].id.toString(),
                                      style: dataTextStyle)),
                                  DataCell(Text(episodes[index].name.toString(),
                                      style: dataTextStyle)),
                                  DataCell(Text(episodes[index].airDate.toString(),
                                      style: dataTextStyle)),
                                  DataCell(IconButton(
                                      icon: const FaIcon(
                                          FontAwesomeIcons.solidEye,
                                          color: Colors.white,
                                          size: 20.0),
                                      onPressed: () {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (context) =>
                                                characterPopUp(
                                                    context,
                                                    episodes[index].characters,
                                                    episodes[index].name,
                                                    "episode"));
                                      })),
                                ]))))));
  }
}

Widget headerText(headerTitle) {
  return Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
    Text(headerTitle, textAlign: TextAlign.center),
  ]);
}
