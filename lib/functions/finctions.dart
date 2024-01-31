import '../model/tariff.dart';

String getTariff(accountID, List<AccountTariff> tarrifs) {
  String tName;
  tName = 'не указан';
  for (var element in tarrifs) {
    if (element.accountId == accountID) {
      tName = element.name;
    }
  }

  return tName;
}
