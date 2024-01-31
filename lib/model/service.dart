import '../functions/convert.dart';
import 'package:hive/hive.dart';
import '../model/abstract_object.dart';

part 'service.g.dart';

@HiveType(typeId: 3)
class Service extends ObjectDatabase {
  @HiveField(0)
  int id;
  @HiveField(1)
  int serviceId;
  @HiveField(2)
  String name;
  @HiveField(3)
  int tariffLinkId;
  @HiveField(4)
  double costWithTaxes;
  @HiveField(5)
  double cost;
  @HiveField(6)
  double costCoef;
  @HiveField(7)
  int discountPeriodStart;
  @HiveField(8)
  int discountPeriodEnd;
  @HiveField(9)
  Service(
      this.id,
      this.serviceId,
      this.name,
      this.tariffLinkId,
      this.costWithTaxes,
      this.cost,
      this.costCoef,
      this.discountPeriodStart,
      this.discountPeriodEnd);

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        serviceId = json['service_id'],
        name = json['name'].toString(),
        tariffLinkId = json['tariff_link_id'],
        costWithTaxes = getNumsByString(json['cost_with_taxes'].toString()),
        cost = getNumsByString(json['cost'].toString()),
        costCoef = getNumsByString(json['cost_coef'].toString()),
        discountPeriodStart = json['discount_period_start'],
        discountPeriodEnd = json['discount_period_end'];
}
