import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:second_mobile_exam/pages/characters_page.dart';
import 'package:second_mobile_exam/pages/episodes_page.dart';
import 'package:second_mobile_exam/pages/locations_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    List<Widget> data = [CharactersPage(), LocationsPage(), EpisodesPage()];
  //Creating material app
  //Adding scafall with the bottom navigation bar
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            inactiveColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.users),
                label: "Characters",
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.locationDot),
                label: "Location",
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.film),
                label: "Episodes",
              )
            ],
          ),
          tabBuilder: (context, index) {
            return CupertinoTabView(
              builder: (context) {
                return data[index];
              },
            );
          },
        )));
  }
}
