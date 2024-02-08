import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../functions/get_data.dart';
import '../model/account_plus.dart';
import '../model/user.dart';
import '../widgets/account_card.dart';

class AccountsPage extends StatelessWidget {
  final User currentUser;
  final String host;
  const AccountsPage(
      {super.key, required this.currentUser, required this.host});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: FutureBuilder<List<AccountPlus>>(
        future: getUserAccounts(host, currentUser),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider(
                        create: (context) => snapshot.data![index],
                        child: AccountCard(account: snapshot.data![index]));
                  },
                );
              } else {
                return const Center(child: Text('не удалось загрузть данные'));
              }

            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
