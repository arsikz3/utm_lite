import 'package:hive/hive.dart';

part 'tariff.g.dart';

@HiveType(typeId: 5)
class AccountTariff {
  @HiveField(0)
  int id;
  @HiveField(1)
  int accountId;
  @HiveField(2)
  String name;
  @HiveField(3)
  String nextTariffName;
  @HiveField(4)
  int tariffLinkId;
  @HiveField(5)
  String currentTariffComment;
  @HiveField(6)
  String nextTariffComment;
  @HiveField(7)
  int currentTariffCreateDate;
  @HiveField(8)
  int currentTariffChangeDate;
  @HiveField(9)
  int currentTariffExpireDate;
  @HiveField(10)
  int nextTariffCreateDate;
  @HiveField(11)
  int nextTariffChangeDate;
  @HiveField(12)
  int nextTariffExpireDate;

  AccountTariff(
    this.id,
    this.accountId,
    this.name,
    this.nextTariffName,
    this.tariffLinkId,
    this.currentTariffComment,
    this.nextTariffComment,
    this.currentTariffCreateDate,
    this.currentTariffChangeDate,
    this.currentTariffExpireDate,
    this.nextTariffCreateDate,
    this.nextTariffChangeDate,
    this.nextTariffExpireDate,
  );

  AccountTariff.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        accountId = json['account_id'],
        name = json['name'],
        nextTariffName = json['next_tariff_name'],
        tariffLinkId = json['tariff_link_id'],
        currentTariffComment = json['current_tariff_comment'],
        nextTariffComment = json['next_tariff_comment'],
        currentTariffCreateDate = json['current_tariff_create_date'],
        currentTariffChangeDate = json['current_tariff_change_date'],
        currentTariffExpireDate = json['current_tariff_expire_date'],
        nextTariffCreateDate = json['next_tariff_create_date'],
        nextTariffChangeDate = json['next_tariff_change_date'],
        nextTariffExpireDate = json['next_tariff_expire_date'];
}
