import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/setting_app.dart';
import 'package:hive/hive.dart';

class SettingsAppProvider extends ChangeNotifier {
  // final String _boxName = "settingsAppBox";
  // Hive.openBox<SettingsApp>('settingsAppBox');
  final box = Hive.box<SettingsApp>('settingsAppBox');

  bool _dartTheme = false;
  String _serverIP = '127.0.0.1';
  String _serverPort = '';

  SettingsApp _settingsApp =
      SettingsApp(portServer: '', serverIP: '', darkTheme: false);

  // void initSettingsAppBox() {
  //   if (box.containsKey('settings')) {
  //     _settingsApp = SettingsApp(
  //         portServer: '',
  //         serverIP: box.get('settings')!.serverIP,
  //         darkTheme: box.get('settings')!.darkTheme);
  //     // _serverIP =Hive.box<SettingsApp>('settingsAppBox').get('settings')!.serverIP;
  //     _serverPort =
  //         Hive.box<SettingsApp>('settingsAppBox').get('settings')!.portServer;
  //   } else {
  //     _settingsApp = SettingsApp(
  //         portServer: '', serverIP: 'www.cabinet.net', darkTheme: false);
  //   }

  //   // _settingsApp = box.get('settings', defaultValue: SettingsApp(portServer: '', serverIP: '', darkTheme: false))!;
  // }

  void setDartTheme() {
    _settingsApp.darkTheme = true;
    box.put('settings', _settingsApp);
    notifyListeners();
  }

  void changeDartTheme() {
    _settingsApp.darkTheme = !_settingsApp.darkTheme;
    box.put('settings', _settingsApp);
    notifyListeners();
  }

  bool get isDarkTheme {
    // _dartTheme = box.get('settings')!.darkTheme;
    if (box.get('settings') == null) {
      _settingsApp.darkTheme = false;
    } else {
      _settingsApp.darkTheme = box.get('settings')!.darkTheme;
    }
    _dartTheme = _settingsApp.darkTheme;
    return _dartTheme;
  }

  String getIpServer2() {
    _serverIP = box.get('settings')!.serverIP;

    return _serverIP;
  }

  String get getIpServer {
    if (box.get('settings') == null) {
      _serverIP = '';
    } else {
      _serverIP = box.get('settings')!.serverIP;
    }
    return _serverIP;
  }

  String getPortServer() {
    if (box.get('settings') == null) {
      _serverPort = '';
    } else {
      _serverPort = box.get('settings')!.portServer;
    }
    return _serverPort;
  }

  void setSettingApp(String ipServer, String portServer) {
    _settingsApp.serverIP = ipServer;
    _settingsApp.portServer = portServer;
    box.put('settings', _settingsApp);
    _settingsApp.save();
    notifyListeners();
  }

  SettingsApp getSettingsApp() {
    if (box.get(
          'settings',
        ) ==
        null) {
      _settingsApp =
          SettingsApp(portServer: '', serverIP: '', darkTheme: false);
    } else {
      _settingsApp = box.get(
        'settings',
      )!;
    }
    return _settingsApp;
  }
}
