import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import '../functions/convert.dart';
import '../model/abstract_object.dart';
import '../model/service.dart';
import 'package:flutter/foundation.dart';
import 'tariff.dart';

part 'account_plus.g.dart';

@HiveType(typeId: 2)
// class AccountPlus extends HiveObject {
class AccountPlus extends ObjectDatabase with ChangeNotifier {
  @HiveField(0)
  int id;
  @HiveField(1)
  double credit;
  @HiveField(2)
  double balance;
  @HiveField(3)
  int intStatus;
  @HiveField(4)
  int vatRate;
  @HiveField(5)
  String externalId;
  @HiveField(6)
  List<Service> services;
  @HiveField(7)
  List<AccountTariff> tariffs;
  @HiveField(8)
  int blockId;
  @HiveField(9)
  int blockType;
  @HiveField(10)
  String actualDate;

  AccountPlus(
      this.id,
      this.credit,
      this.balance,
      this.intStatus,
      this.vatRate,
      this.externalId,
      this.services,
      this.tariffs,
      this.blockId,
      this.blockType,
      this.actualDate);

  // set intStatus(int newintStatus) {
  //   intStatus = newintStatus;
  //   notifyListeners();
  // }

  set setIntStatus(int newintStatus) {
    intStatus = newintStatus;
    notifyListeners();
  }

  int get getIntStatus {
    return intStatus;
  }

  String get getActualDate {
    return actualDate;
  }

  var _count = 33;
  var _actualDateStr = 'actualDate';
  int get count => _count;
  String get actualDateStr => _actualDateStr;
  void updateProps() {
    _count++;
    _actualDateStr = actualDate;
    notifyListeners();
  }

  AccountPlus.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        credit = getNumsByString(json['credit'].toString()),
        balance = getNumsByString(json['balance'].toString()),
        intStatus = json['int_status'],
        vatRate = json['vat_rate'],
        externalId = json['external_id'].toString(),
        services = generateServiceList(json['services']),
        tariffs = generateTariffList(json['tariffs']),
        blockId = json['block_id'],
        blockType = json['block_type'],
        // actualDate = DateTime.now().convertToSqlFormat();
        // actualDate = DateFormat('d.M.y H:mm:ss').format(DateTime.now()
        //     .add(const Duration(hours: 3, minutes: 29, seconds: 22)));
        actualDate = DateFormat('d.M.y H:mm:ss')
            .format(DateTime.now().add(const Duration(hours: 3)));
}

List<Service> generateServiceList(json) {
  List<Service> serviceList = [];
  Service service;
  if (json != null) {
    for (var item in json) {
      service = Service.fromJson(item);
      serviceList.add(service);
    }
  }
  return serviceList;
}

List<AccountTariff> generateTariffList(json) {
  List<AccountTariff> serviceList = [];
  AccountTariff service;
  if (json != null) {
    for (var item in json) {
      service = AccountTariff.fromJson(item);
      serviceList.add(service);
    }
  }
  return serviceList;
}
