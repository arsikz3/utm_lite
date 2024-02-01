import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:utm_lite/pages/page_settings.dart';

import '../functions/boxes.dart';
import '../functions/get_data.dart';
import '../model/user.dart';
// import '../pages/menu_screen.dart';
// import '../pages/page_accounts.dart';
import '../pages/page_edit_profile.dart';

import '../provider/setting_app_provider.dart';
import '../widgets/dialog_adduser.dart';
import '../widgets/dialog_ask.dart';
import 'page_accounts.dart';

class UsersLoginPage extends StatefulWidget {
  const UsersLoginPage({super.key});

  @override
  State<UsersLoginPage> createState() => _UsersLoginPageState();
}

class _UsersLoginPageState extends State<UsersLoginPage> {
  String host = '';

  @override
  void initState() {
    host = Provider.of<SettingsAppProvider>(context, listen: false).getIpServer;
    log('host init' + host);
    updateUserToken(host);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // drawerScrimColor: Colors.transparent,
        // drawer: const MenuScreen(),
        // backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
                // Provider.of<SettingsAppProvider>(context, listen: false)
                //     .changeDartTheme();
              },
            ),
          ],
          // leading: IconButton(
          //   icon: const Icon(Icons.menu),
          //   onPressed: () {},
          // ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Image.asset(
              //   'assets/images/LogoUTTs265.png',
              //   fit: BoxFit.contain,
              //   height: 32,
              // ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('Договора'),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
        body: ValueListenableBuilder<Box<User>>(
          valueListenable: BoxUsers.getUsers().listenable(),
          builder: (context, box, _) {
            final users = box.values.toList().cast<User>();

            return buildContent(users);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (Provider.of<SettingsAppProvider>(context, listen: false)
                    .getIpServer ==
                '') {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                  content: Text('Укажите адрес сервера в настройках'),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) => AddUserDialog(),
              );
            }
          },
          tooltip: 'Добавить',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget buildContent(List<User> users) {
    if (users.isEmpty) {
      return const Center(
        child: Text(
          'Добавьте договора через кнопку +',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                final user = users[index];

                return Slidable(
                  // key: const ValueKey(0),
                  endActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    children: [
                      SlidableAction(
                        spacing: 10,
                        autoClose: true,
                        onPressed: ((context) async {
                          if (await showAskDialog(context,
                              'Вы уверены что хотите удалить аккаунт?')) {
                            deleteUser(user);
                          }
                        }),
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Удалить',
                      ),
                    ],
                  ),
                  key: UniqueKey(),
                  direction: Axis.horizontal,
                  // key: const ValueKey(0),
                  child: buildUserRow(context, user),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  void deleteUser(User user) {
    // final box = Boxes.getTransactions();
    // box.delete(transaction.key);
    user.delete();
  }

  Widget buildUserRow(
    BuildContext context,
    User user,
  ) {
    // const biggerFont = TextStyle(fontSize: 18.0);
    bool darkTheme =
        Provider.of<SettingsAppProvider>(context, listen: true).isDarkTheme;
    LinearGradient gradientcolor =
        const LinearGradient(colors: [Colors.blue, Colors.indigo]);
    if (darkTheme) {
      gradientcolor =
          const LinearGradient(colors: [Colors.grey, Colors.black12]);
    } else {
      gradientcolor =
          const LinearGradient(colors: [Colors.blue, Colors.indigo]);
    }

    return Card(
      // elevation: 4,
      shadowColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,

      // color:  Colors.blue.shade600 : Colors.blue.shade,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), gradient: gradientcolor),
        child: ListTile(
          onTap: () async {
            Navigator.of(context).push(MaterialPageRoute(

                // builder: (context) => AccountPage(currentUser: user)));
                builder: (context) =>
                    TabLayoutAccount(host: host, currentUser: user)));
          },
          textColor: Colors.white,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 22.0,
                ),
                const SizedBox(width: 10),
                Expanded(
                    child: Text(user.fullname,
                        style: const TextStyle(fontSize: 16.0))),
                // SizedBox(height: 50),
              ]),
          trailing: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EditProfilePage(host: host, user: user)),
              );
            },
            icon: const Icon(
              Icons.edit,
              size: 22.0,
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\nАдрес: '
                      '${user.actualAddress}',
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                    Text(
                      '\nЛогин: ${user.login}'
                      '\nТелефон: ${user.mobileTelephone}',
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void getUserAcc(String host, User user) async {
  //   log('до getUserAccounts${user.accounts[0].actualDate}');
  //   await getUserAccounts(host, user);
  //   log('после getUserAccounts${user.accounts[0].actualDate}');
  // }

  void updateUserToken(String host) async {
    List<User> users = [];
    users = BoxUsers.getUsers().values.toList();
    for (var user in users) {
      String token = '';
      token = await getUserTokenPlus(host, user.login, user.password);
      user.token = token;
      user.save();
    }
  }
}
