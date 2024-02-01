import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'dart:async';

import '../pages/page_users.dart';
import '../provider/setting_app_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<SettingsAppProvider>(context, listen: true).isDarkTheme
          // ? ThemeData.dark()
          // : ThemeData.light(),
          ? ThemeData(
              cardTheme: const CardTheme(color: Colors.black),
              colorScheme: ColorScheme.fromSeed(

                  // background: Colors.grey[100],
                  seedColor: Colors.blueAccent,
                  brightness: Brightness.dark),
              useMaterial3: true,
            )
          : ThemeData(
              cardTheme: const CardTheme(color: Colors.blue),
              colorScheme: ColorScheme.fromSeed(
                  background: const Color.fromARGB(221, 165, 202, 248),
                  seedColor: Colors.blueAccent,
                  brightness: Brightness.light),
              useMaterial3: true,
            ),
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(
      //       seedColor: Colors.blueAccent,
      //       brightness: Provider.of<SettingsAppProvider>(context, listen: true)
      //               .isDarkTheme()
      //           ? Brightness.dark
      //           : Brightness.light),
      //   useMaterial3: true,
      // ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller = AnimationController(vsync: this);
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(
          seconds: 2,
        ),
        vsync: this,
        value: 0.1,
        lowerBound: 0.1);

    // _controller.repeat(reverse: true);
    // _controller.reverse(from: 1);
    // _controller.forward(from: 0.1);
    _controller.forward(from: 0.1).whenComplete(() {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext ctx) {
        return const UsersLoginPage(); //если без Priveder'а

        // return ChangeNotifierProvider(
        //   create: (context) => UserProvider(),
        //   child: const UsersLoginPage(),
        // );
      }));
    });

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 200,
        color: Colors.white38,
        child: ScaleTransition(
          scale: _animation,
          alignment: Alignment.center,
          child: Image.asset('assets/images/icon.png', fit: BoxFit.scaleDown),
        ));
  }
}
