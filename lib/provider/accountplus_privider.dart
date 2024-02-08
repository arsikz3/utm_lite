import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:utm_lite/model/account_plus.dart';
import '../model/setting_app.dart';
import 'package:hive/hive.dart';

class AccountPlusProvider extends ChangeNotifier {
  AccountPlus? _accountPlus;
  AccountPlusProvider();

  AccountPlus? get accountPlus => _accountPlus;
//  ProfileModel? _profileModel;

//   ProfileProvider();

//   Future<void> fetchProfileData() async {
//     await _simulateAPIFetch(); // Simulate API call

//     _profileModel = ProfileModel(name: 'John Doe', email: 'john@example.com');

//     notifyListeners();
//   }

//   ProfileModel? get profileModel => _profileModel;

//   bool isProfileDataFetched() => _profileModel != null;

//   Future<void> _simulateAPIFetch() async {
//     await Future.delayed(Duration(seconds: 1));
//   }
}
