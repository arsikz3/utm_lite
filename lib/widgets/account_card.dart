import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../functions/finctions.dart';
import '../model/account_plus.dart';
import '../functions/convert.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.account,
  });

  final AccountPlus account;

  @override
  Widget build(BuildContext context) {
    // AccountPlus acc = Provider.of<AccountPlus>(context, listen: true);
    // final dateFormatter = DateFormat('d MMMM yyyy hh:mm');
    int period;
    DateTime dateTimeStart;
    DateTime dateTimeEnd;
    return ExpansionTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Лицевой счет ${account.id}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.account_balance_wallet_outlined),
                const SizedBox(width: 5),
                Text('Баланс ${account.balance.toStringAsFixed(2)}'),
                // Text('Баланс ${account.balance}'),

                // Container(
                //     width: double.infinity,
                //     // color: Colors.grey,
                //     child:
                //         Text('по стостоянию на ' + account.actualDate)),
              ],
            ),

            Text('по стостоянию на ${account.actualDate}',
                style: const TextStyle(fontSize: 12)),
            Text('блокировки ${account.blockId}',
                style: const TextStyle(fontSize: 12)),
            Text('тип блокировки ${account.blockType}',
                style: const TextStyle(fontSize: 12)),
            Text('статус ${account.intStatus}',
                style: const TextStyle(fontSize: 12)),
            // Center( child:  if (account.blockId == 0) { Text('блокировки')})
          ],
        ),
      ),
      initiallyExpanded: true,
      children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         children: [
        //           Text('Баланс ${account.balance.ceilToDouble()}'),
        //           // Container(
        //           //     width: double.infinity,
        //           //     // color: Colors.grey,
        //           //     child:
        //           //         Text('по стостоянию на ' + account.actualDate)),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: account.services.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                period = account.services[index].discountPeriodEnd -
                    account.services[index].discountPeriodStart;
                dateTimeStart = DateTime.fromMillisecondsSinceEpoch(account
                    .services[index].discountPeriodStart
                    .toMilliseconds());
                dateTimeEnd = DateTime.fromMillisecondsSinceEpoch(
                    account.services[index].discountPeriodEnd.toMilliseconds());
                return Card(
                  shadowColor: Colors.red,
                  elevation: 10,
                  // color: Colors.blue,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        // leading: const Icon(Icons.account_balance_wallet_outlined),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Текущий тариф: ',
                              style: TextStyle(fontSize: 14),
                              // style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                            Text(
                              getTariff(account.services[index].tariffLinkId,
                                  account.tariffs),
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('услуга ${account.services[index].name}'),
                            Text(
                                'стоимость: ${account.services[index].cost}руб. за  ${dateTimeEnd.difference(dateTimeStart).inDays} д.',
                                style: const TextStyle(fontSize: 12)),
                            paymentDay(
                                account.balance,
                                account.services[index].cost,
                                dateTimeEnd.difference(dateTimeStart).inDays,
                                DateTime.fromMillisecondsSinceEpoch(account
                                        .services[index].discountPeriodEnd
                                        .toMilliseconds())
                                    .toLocal(),
                                account.services[index].costCoef),
                            discountRepcent(account.services[index].costCoef),
                            // Text(
                            //     'Период ${dateTimeEnd.difference(dateTimeStart).inDays} '),
                            // Text(
                            //     'Следующее списание ${DateTime.fromMillisecondsSinceEpoch(account.services[index].discountPeriodEnd.toMilliseconds(), isUtc: false)}'),
                            // Text('Начало ${DateTime.fromMillisecondsSinceEpoch(account.services[index].discountPeriodStart.toMilliseconds()).toLocal()}'),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

Widget paymentDay(
    double balace, double cost, int days, DateTime nextpaydate, double koeff) {
  int intday;
  String paydate;

  if (balace <= 0) {
    return const Text('оплачено 0 дней');
  }

  if (cost == 0 || days == 0 || koeff == 0) {
    return const Text('оплачено ~ дней');
  } else {
    if (DateTime.now().daysInMonth == days) {
      int qtymounth;
      double restMoney;
      int restDays;
      DateTime paymounth;

      qtymounth = 0;
      if (balace >= cost) {
        qtymounth = (balace / cost).floor();
        restMoney = balace / qtymounth - cost;
      } else {
        restMoney = balace;
      }
      restDays = (restMoney * days / 100).floor();

      paymounth = (DateTime(
          nextpaydate.year,
          nextpaydate.month + qtymounth,
          DateTime(nextpaydate.year, nextpaydate.month + qtymounth)
              .lastDayOfMonth));

      paydate =
          DateFormat('dd.MM.y').format(paymounth.add(Duration(days: restDays)));

      intday = paymounth
          .add(Duration(days: restDays, hours: DateTime.now().hour))
          .difference(DateTime.now().getDateOnly)
          .inDays;

      return Text('оплачено $intday дн., до $paydate');
    } else {
      intday = (balace / (cost / days) * koeff).floor();

      paydate = DateFormat('dd.MM.y')
          .format(nextpaydate.add(Duration(days: intday.floor())));
      return Text('оплачено $intday дн., до $paydateг.');
    }
  }
}

Widget discountRepcent(double discountKofficient) {
  if (discountKofficient == 1) {
    return const Text('');
  } else {
    return Text('Скидка ${100 - discountKofficient * 100}%');
  }
}
