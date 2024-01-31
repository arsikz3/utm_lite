import 'dart:async';

import 'dart:developer';

// import 'package:flutter/material.dart';

import '../consts.dart';
import '../functions/boxes.dart';
import '../model/account_plus.dart';
import '../model/allowed_edit_profile.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'dart:io';

Future<String> getUserTokenPlus(
    String host, String prmLogin, String prmPasswd) async {
  // var url = Uri.http('192.109.243.13:8000', '/customer_api/login');
  var url = Uri.https(host, customerApiLogin);
  Map data = {'login': prmLogin, 'password': prmPasswd};
  // print(data);
  // Fluttertoast.showToast(msg: data.toString());

  var body = convert.json.encode(data);
  try {
    // http.Response response =await http.post(url, body: body).timeout(const Duration(seconds: 10));
    http.Response response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      var jsonResponse = convert.json.decode(response.body);
      return (jsonResponse["sid_customer"]);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } on TimeoutException catch (e) {
    log('Timeout get token: ${e.toString()}');

    return ('Timeout');
  } on Error catch (e) {
    print('Error: $e');
  }

  return '';
}

Future<List<User>> getUserPlus(
    String hostUTM, String prmLogin, String prmPasswd) async {
  // final String _currentDate = DateTime.now().convertToSqlFormat();
  String token = '';
  List<User> users = [];
  AccountPlus accPlus;
  List<AccountPlus> accountsPlus = [];
  User user;

  // var url = Uri.http('192.109.243.13:8000', '/customer_api/auth/profile');
  var url = Uri.https(hostUTM, customerApiProfile);

  token = await getUserTokenPlus(hostUTM, prmLogin, prmPasswd);
  // headers = {'"sid_customer"': '"bfeeebee-9b86-4767-8ef7-fa9352d8d075"'};
  // print(token);
  try {
    // print(url);
    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.cookieHeader: 'sid_customer=$token',
      },
    ); //.timeout(const Duration(seconds: 8));

    // print(response.request);
    // print(http.Response);
    // print(response.statusCode);
    // print(response.request?.headers.toString());

    // log(response.statusCode.toString());

    if (response.statusCode == 200) {
      // print(convert.utf8.decode(response.bodyBytes));
      // var jsonResponse = convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      // var jsonResponse = convert.utf8.decode(response.bodyBytes);
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      var accountRespons = jsonResponse['accounts'];
      for (var item in accountRespons) {
        // log('999999999999999999999999999999');
        // log(item.toString());
        accPlus = AccountPlus.fromJson(item);
        accountsPlus.add(accPlus);
      }
      log('2222');
      user = User.fromJson(jsonResponse);
      user.token = token;
      user.accounts = accountsPlus;
      users.add(user);

      final box = BoxUsers.getUsers();
      box.add(user);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } on TimeoutException catch (e) {
    log('Timeout: ${e.toString()}');
  } on Error catch (e) {
    log('test error1 $e');

    //   print('Error: $e');
  }

  // print(users.length);
  return users;
}

Future<List<AccountPlus>> getUserAccounts(String utmHost, User user) async {
  // final String _currentDate = DateTime.now().convertToSqlFormat();
  String token = '';
  AccountPlus accPlus;
  List<AccountPlus> accountsPlus = [];

  var url = Uri.https(utmHost, customerApiProfile);

  token = user.token;
  // log('Service Link Get. Token: $token');
  try {
    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.cookieHeader: 'sid_customer=$token',
      },
    ).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      var accountRespons = jsonResponse['accounts'];
      for (var item in accountRespons) {
        accPlus = AccountPlus.fromJson(item);
        accountsPlus.add(accPlus);
      }

      user.accounts = accountsPlus;
      user.tariffs = generateMainTariff(jsonResponse['tariffs']);
      user.save();

      // BoxUsers.getUsers().put(0, user);
      // final box = BoxUsers.getUsers();
      // box.add(user);
      // box.putAt(2, user);
      // print(box.getAt(0)!.id.toString());

      // print(user.accounts[0].actualDate.toString());
      // final box = BoxUsers.getUsers();
      // final res = box.values;
      // print('после getData: ' + res.first.accounts[0].actualDate.toString());
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
  } on TimeoutException catch (e) {
    log(e.toString());

    return accountsPlus;
  } on Error catch (e) {
    log('Error getUserAccounts: ${e.toString()}');
  }
  return accountsPlus;
}

Future<List<AllowedEditProfile>> getAllowedEditProfile(
    String utmHost, User user) async {
  String token = '';
  AllowedEditProfile allowedEditProfile;
  List<AllowedEditProfile> allowedsEditProfile = [];

  // List<Service> serviceList = [];
  var url = Uri.https(utmHost, isAllowedEditProfile);

  token = user.token;
  // log('Service Link Get. Token: $token');
  try {
    http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.cookieHeader: 'sid_customer=$token',
      },
    ).timeout(const Duration(seconds: 5));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));
      log(jsonResponse.toString());
      allowedEditProfile = AllowedEditProfile.fromJson(jsonResponse);
      allowedsEditProfile.add(allowedEditProfile);
    } else {
      log('Request failed with status: ${response.statusCode}.');
    }
  } on TimeoutException catch (e) {
    log(e.toString());

    return allowedsEditProfile;
  } on Error catch (e) {
    log('Error: ${e.toString()}');
  }
  return allowedsEditProfile;
}
