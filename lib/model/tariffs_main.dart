import 'package:hive/hive.dart';

part 'tariffs_main.g.dart';

@HiveType(typeId: 4)
class MainTariff {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String nextTariffName;
  @HiveField(3)
  int tariffLinkId;
  @HiveField(4)
  int accountId;

  MainTariff({
    required this.id,
    required this.name,
    required this.nextTariffName,
    required this.tariffLinkId,
    required this.accountId,
  });

  // MainTariff.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       name = json['name'],
  //       nextTariffName = json['next_tariff_name'],
  //       tariffLinkId = json['tariff_link_id'],
  //       accountId = json['account_id'];

  factory MainTariff.fromJson(Map<String, dynamic> json) {
    return MainTariff(
        id: json['id'],
        name: json['name'],
        nextTariffName: json['next_tariff_name'],
        tariffLinkId: json['tariff_link_id'],
        accountId: json['account_id']);
  }
}
