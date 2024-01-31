import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../functions/convert.dart';
import '../model/account_plus.dart';
import '../model/tariffs_main.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject with ChangeNotifier {
  @HiveField(0)
  final int id;
  @HiveField(1)
  String login;
  @HiveField(2)
  String password;
  @HiveField(3)
  String actualAddress;
  @HiveField(4)
  String fullname;
  @HiveField(5)
  String email;
  @HiveField(6)
  String homeTelephone;
  @HiveField(7)
  String mobileTelephone;
  @HiveField(8)
  String created;
  @HiveField(9)
  String memo;
  @HiveField(10)
  String token;
  @HiveField(11)
  bool isactive;
  @HiveField(12)
  int basicAccount;
  @HiveField(13)
  double balance;
  @HiveField(14)
  double credit;
  @HiveField(15)
  double paymentInMonth;
  @HiveField(16)
  List<MainTariff> tariffs;
  @HiveField(17)
  List<AccountPlus> accounts;
  @HiveField(18)
  List<dynamic> groups;
  @HiveField(19)
  int encrypted;
  @HiveField(20)
  int isJuridical;
  @HiveField(21)
  bool isSendKeepAlive;
  @HiveField(22)
  String hotspotLogin;

  User(
      {required this.id,
      required this.login,
      required this.password,
      required this.actualAddress,
      required this.fullname,
      required this.email,
      required this.homeTelephone,
      required this.mobileTelephone,
      required this.created,
      required this.memo,
      required this.token,
      required this.isactive,
      required this.basicAccount,
      required this.balance,
      required this.credit,
      required this.paymentInMonth,
      required this.tariffs,
      required this.accounts,
      required this.groups,
      required this.encrypted,
      required this.isJuridical,
      required this.isSendKeepAlive,
      required this.hotspotLogin});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        login: json['login'].toString(),
        password: json['password'].toString(),
        actualAddress: json['actual_address'].toString(),
        email: json['email'].toString(),
        fullname: json['full_name'].toString(),
        homeTelephone: '',
        mobileTelephone: json['mobile_telephone'].toString(),
        created: '',
        memo: '',
        token: '',
        isactive: json['is_active'],
        basicAccount: json['basic_account'],
        balance: getNumsByString(json['balance'].toString()),
        credit: getNumsByString(json['credit'].toString()),
        paymentInMonth: getNumsByString(json['payment_in_month'].toString()),
        // tariffs: json['tariffs'].toString(),
        tariffs: generateMainTariff(json['tariffs']),
        // tariffs: json['tariffs'].toList(),
        // accounts: [], //json['accounts'].toString(),
        accounts: generateAccountList(json['accounts']),
        groups: json['groups'],
        encrypted: json['encrypted'],
        isJuridical: json['is_juridical'],
        isSendKeepAlive: json['is_send_keep_alive'],
        hotspotLogin: json['HotspotLogin'].toString());
  }
}

List<AccountPlus> generateAccountList(json) {
  List<AccountPlus> accountList = [];
  AccountPlus account;
  // print(json.toString());
  for (var item in json) {
    if (item != null) {
      account = AccountPlus.fromJson(item);
      accountList.add(account);
      // print(item.toString());
    }
  }
  return accountList;
}

List<MainTariff> generateMainTariff(json) {
  List<MainTariff> mainTariffList = [];
  MainTariff mainTariff;
  // print(json.toList());

  for (var item in json) {
    if (json != null) {
      mainTariff = MainTariff.fromJson(item);
      mainTariffList.add(mainTariff);
      // print(item.toString());
    }
  }
  return mainTariffList;
}
