import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'model/account_plus.dart';
import 'model/service.dart';
import 'model/setting_app.dart';
import 'model/tariff.dart';
import 'model/tariffs_main.dart';
import 'model/user.dart';
import 'pages/page_splash.dart';
import 'provider/setting_app_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SettingsAppAdapter());
// Hive.deleteBoxFromDisk("users");
  Hive.registerAdapter(MainTariffAdapter());
  Hive.registerAdapter(AccountTariffAdapter());
  Hive.registerAdapter(ServiceAdapter());
  Hive.registerAdapter(AccountPlusAdapter());
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<SettingsApp>('settingsAppBox');
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsAppProvider(), child: const MyApp()));
}
