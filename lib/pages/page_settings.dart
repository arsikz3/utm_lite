import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/setting_app_provider.dart';

// import 'package:dart_config/package_info.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ipServerController = TextEditingController();
    final portServerController = TextEditingController();

    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String version = packageInfo.version;
    // String buildNumber = packageInfo.buildNumber;

    ipServerController.text =
        Provider.of<SettingsAppProvider>(context, listen: true).getIpServer;
    // ipServerController.text =
    //     'Provider.of<SettingsAppProvider>(context, listen: true).getIpServer';
    // print(Provider.of<SettingsAppProvider>(context, listen: true).isDarkTheme);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Настройки'),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Темная тема приложения',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Checkbox(
                    value:
                        Provider.of<SettingsAppProvider>(context, listen: true)
                            .isDarkTheme,
                    onChanged: (val) {
                      Provider.of<SettingsAppProvider>(context, listen: false)
                          .changeDartTheme();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
                child: Divider(),
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(' Адрес сервера')),
              TextField(
                  controller: ipServerController,
                  // style: const TextStyle(
                  //   fontSize: 14,
                  // ),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      //border: InputBorder.none,
                      hintText: "укажите адрес",
                      // labelText: 'Адрес сервера',
                      // fillColor: Colors.black12,
                      filled: true)),
              const Align(alignment: Alignment.centerLeft, child: Text(' ')),
              const SizedBox(
                height: 20,
                child: Divider(),
              ),
              // const Align(
              //     alignment: Alignment.centerLeft, child: Text('порт сервера')),
              // TextField(
              //     controller: portServerController,
              //     style: const TextStyle(
              //       fontSize: 16,
              //     ),
              //     decoration: const InputDecoration(
              //         border: OutlineInputBorder(),
              //         // border: InputBorder.none,
              //         hintText: "укажите порт сервера",
              //         filled: true)),
              // const SizedBox(
              //   height: 15,
              // ),
              ElevatedButton.icon(
                onPressed: () {
                  Provider.of<SettingsAppProvider>(context, listen: false)
                      .setSettingApp(
                          ipServerController.text, portServerController.text);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save),
                label: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
