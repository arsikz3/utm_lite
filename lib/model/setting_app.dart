import 'package:hive/hive.dart';

part 'setting_app.g.dart';

@HiveType(typeId: 1)
class SettingsApp extends HiveObject {
  @HiveField(0)
  String portServer;
  @HiveField(1)
  String serverIP;
  @HiveField(2)
  bool darkTheme;

  SettingsApp(
      {required this.portServer,
      required this.serverIP,
      required this.darkTheme});
}
