import 'package:hive/hive.dart';
import '../model/user.dart';

class BoxUsers {
  static Box<User> getUsers() => Hive.box<User>('users');
}

// class BoxAccounts {
//   static Box<AccountPlus> getUsers() => Hive.box<AccountPlus>('AccountPlus');
// }

// class Boxes {
//   static Box<SettingsApp> getDatabases() => Hive.box<SettingsApp>('databases');
// }


