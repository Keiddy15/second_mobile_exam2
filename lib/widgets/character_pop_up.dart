import 'package:flutter/cupertino.dart';

//Widget to create a pop up
Widget characterPopUp(context, residents, dimension, type) {
  return CupertinoAlertDialog(
    title: Text('Characters in $type: $dimension '),
    content: Column(
        children: <Widget>[Text("Here lives ${residents.length} characters")]),
    actions: [
      CupertinoDialogAction(
          child: const Text('Close'), onPressed: () => Navigator.pop(context)),
    ],
  );
}
