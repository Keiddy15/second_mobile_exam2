import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Widget to add a bottom navidation bar
Widget bottomBarNavigation(data) {
  return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      backgroundColor: Colors.blueGrey,
      activeColor: Colors.white,
      inactiveColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: "Profile",
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
  );
}
