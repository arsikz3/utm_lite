import 'package:flutter/material.dart';

Future<bool> showAskDialog(BuildContext context, String question) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return await showDialog(
      //barrierColor: Color(0x00ffffff),
      context: context,
      builder: (context) {
        // bool isChecked = false;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            // backgroundColor: Colors.transparent,
            elevation: 0.5,
            backgroundColor: Colors.white.withOpacity(0.7),
            content: Form(
                key: formKey,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [],
                )),
            title: Text(question,
                style: const TextStyle(fontSize: 14, color: Colors.indigo)),
            actions: <Widget>[
              FloatingActionButton.extended(
                label: const Text("   Да   "),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              FloatingActionButton.extended(
                label: const Text("  Нет   "),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        });
      });
}
