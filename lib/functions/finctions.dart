import '../model/tariff.dart';

String getTariff(tariffLinkID, List<AccountTariff> tarrifs) {
  String tName;
  tName = 'не указан';
  for (var element in tarrifs) {
    if (element.tariffLinkId == tariffLinkID) {
      tName = element.name;
    }
  }

  return tName;
}
