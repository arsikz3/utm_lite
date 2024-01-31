import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utm_lite/model/setting_app.dart';
import '../functions/boxes.dart';
import '../functions/get_data.dart';
import '../model/user.dart';
import '../provider/setting_app_provider.dart';

class AddUserDialog extends StatelessWidget {
  AddUserDialog({super.key});

  final myController = TextEditingController();
  final mypassController = TextEditingController();
  final ValueNotifier<bool> userisExists = ValueNotifier(false);
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Добавить договор',
          style: TextStyle(fontSize: 14, color: Colors.indigo)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
              onChanged: (String value) {},
              controller: myController,
              style: const TextStyle(fontSize: 14, color: Colors.indigo),
              maxLines: 1,
              minLines: 1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Логин не указан';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), //UnderlineInputBorder(),
                  hintText: "Номер договора",
                  labelText: 'Логин от личного кабинета',
                  fillColor: Colors.black12,
                  filled: true)),
          const SizedBox(width: 50.0, height: 10.0),
          TextFormField(
              controller: mypassController,
              style: const TextStyle(fontSize: 14, color: Colors.indigo),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Пароль не указан';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //border: InputBorder.none,
                  hintText: "Пароль",
                  labelText: 'Пароль от личного кабинета',
                  fillColor: Colors.black12,
                  filled: true)),
          const SizedBox(width: 50.0, height: 10.0),
          const Text("* используйте логин и пароль от доступа в личный кабинет",
              style: TextStyle(fontSize: 12, color: Colors.indigo)),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Добавить'),
          onPressed: () {
            // if (_formKey.currentState.validate()) {
            //
            // }
            final box = BoxUsers.getUsers();
            for (var elem in box.values) {
              if ((elem.login == myController.text) &&
                  (elem.password == mypassController.text)) {
                userisExists.value = true;
              }
            }
            if (userisExists.value == true) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 1),
                  backgroundColor: Colors.yellow,
                  content: Text('Договор уже существует...')));
              // Navigator.of(context).pop();
            } else {
              SettingsApp settingsApp =
                  Provider.of<SettingsAppProvider>(context, listen: false)
                      .getSettingsApp();
              Future<List<User>> user = getUserPlus(settingsApp.serverIP,
                  myController.text, mypassController.text);
              user.then((value) {
                if (value.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red,
                      content:
                          Text('Договор не найден. Проверьте логин и пароль')));

                  // Navigator.of(context).pop();
                }
              });
            }
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Закрыть'),
          onPressed: () {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Договор не добавлен...'),
              ),
            );
          },
        ),
      ],
    );
  }
}
