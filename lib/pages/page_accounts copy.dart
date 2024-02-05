import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import '../functions/finctions.dart';
import '../functions/get_data.dart';
// import 'package:uttcabinet_plus/model/account.dart';
import '../model/account_plus.dart';
import '../model/user.dart';
// import '../pages/page_acc_services.dart';

// import '../widgets/promised_payments.dart';

class TabLayoutAccount extends StatefulWidget {
  final User currentUser;
  final String host;
  const TabLayoutAccount(
      {super.key, required this.currentUser, required this.host});

  @override
  State<TabLayoutAccount> createState() => _TabLayoutAccountState();
}

class _TabLayoutAccountState extends State<TabLayoutAccount>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Tab> acc = [];
  // List<AccountPlus> accounts = <AccountPlus>[];
  List<AccountPlus> accounts = <AccountPlus>[];
  bool events = false;
  // int _selectedTabbar = 0;

  @override
  void initState() {
    super.initState();
    events = true;
    _tabController = TabController(length: 0, vsync: this); //было убрано

    getAcc();
    // _tabController = TabController(length: accounts.length, vsync: this); //было убрано
    // _tabController.animateTo(2);
  }

  void getAcc() async {
    List<AccountPlus> accountsPlus = [];

    accountsPlus = await getUserAccounts(widget.host, widget.currentUser);
    if (accountsPlus.isNotEmpty) {
      accounts = accountsPlus;
    } else {
      accounts = widget.currentUser.accounts;
    }

    // accounts = widget.currentUser.accounts;
    for (var element in accounts) {
      acc.add(Tab(child: Text('л/счет ${element.id.toString()}')));
    }
    _tabController = TabController(length: accounts.length, vsync: this);
    // _tabController.animateTo(0);
    setState(() {
      events = false;
    });
    // events = false;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(acc.length);
    return Scaffold(
      appBar: AppBar(
        actions: const [
          IconButton(
            icon: Icon(Icons.message_outlined),
            onPressed: null,
            tooltip: 'Сообщения',
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Лицевые счета',
          style: TextStyle(
            letterSpacing: .3,
            fontWeight: FontWeight.w600,
          ),
        ),
        // backgroundColor: Colors.blue,
      ),
      body: events
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                return AccountCard(account: accounts[index]);
              },
            ),
    );
  }
}

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.account,
  });

  final AccountPlus account;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shadowColor: Colors.red,
        elevation: 10,
        // color: Colors.blue,
        clipBehavior: Clip.antiAlias,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              // leading: const Icon(Icons.account_balance_wallet_outlined),
              title: Column(
                children: [
                  Row(
                    children: [
                      Text('Лицевой счет ${account.id}'),
                    ],
                  ),
                  const Divider(),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.account_balance_wallet_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Баланс ${account.balance.ceilToDouble()}',
                        // style:  TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),

                      // Container(
                      //     width: double.infinity,
                      //     // color: Colors.grey,
                      //     child:
                      //         Text('по стостоянию на ' + account.actualDate)),
                    ],
                  ),
                  Text('по стостоянию на ${account.actualDate}',
                      style: const TextStyle(fontSize: 12)),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Текущий тариф: ',
                    style: TextStyle(fontSize: 14),
                    // style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    getTariff(account.id, account.tariffs),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    log(account.getActualDate);
                    account.actualDate = DateTime.now().toString();
                    log(account.actualDate);
                    // Perform some action
                  },
                  child: const Text('ACTION 1'),
                ),
                TextButton(
                  onPressed: () {
                    // Perform some action
                  },
                  child: Text(account.getActualDate),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
