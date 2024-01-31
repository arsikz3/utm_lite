//import 'package:flutter/Animation/FadeAnimation.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:utm_lite/model/allowed_edit_profile.dart';
// import 'package:uttcabinet_plus/model/edit_profile.dart';
import '../functions/get_data.dart';
import '../model/user.dart';

// import '../functions/api_service.dart';

// import '../widgets/auth_animatiob.dart';

// import 'Animation/FadeAnimation.dart';

class EditProfilePage extends StatefulWidget {
  final String host;
  final User user;
  const EditProfilePage({super.key, required this.host, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  double opacity = 0.1;
  AllowedEditProfile editProfile =
      AllowedEditProfile(id: 0, groupId: 0, isEnabled: 1, availableFields: 0);
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // getEditConfig();
    // editProfile =getAllowedEditProfile(widget.host, widget.user) as AllowedEditProfile;
    // Future<EditProfile> editProfile = getEditConfig as Future<EditProfile>;
    // getData();

    emailController.text = widget.user.email;
    nameController.text = widget.user.fullname;
    phoneController.text = widget.user.mobileTelephone;
    passwordController.text = widget.user.password;
    super.initState();
    // log(editProfile.isEnabled.toString());
    opacity = 1;
  }

  // Future<EditProfile> getEditConfig() async {
  //   _editProfile = await getEditProfileApi(widget.user.token);
  //   return _editProfile;
  //   print(_editProfile.id);
  // }
  // void getData() async {
  //   final editProfile2 = await getAllowedEditProfile(widget.host, widget.user);
  //   if (editProfile2.isNotEmpty) {
  //     editProfile = editProfile2[0];
  //   }
  // }

  Future<AllowedEditProfile> getWriterName() async {
    final editProfile2 = await getAllowedEditProfile(widget.host, widget.user);
    if (editProfile2.isNotEmpty) {
      editProfile = editProfile2[0];
    }
    return editProfile;
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Редактирование профиля',
              style: TextStyle(fontSize: 16.0)),
        ),
        // backgroundColor: Colors.white,
        // backgroundColor: Colors.blueGrey,
        body: FutureBuilder(
            future: getWriterName(),
            initialData: "Code sample",
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'An ${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  );
                } else if (snapshot.hasData) {
                  // final data = snapshot.data as AllowedEditProfile;
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: <Widget>[
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Ф.И.О.:')),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                readOnly: editProfile.isEnabled == 0,
                                controller: nameController,
                                style: const TextStyle(color: Colors.indigo),
                                decoration: InputDecoration(
                                  fillColor: Colors.blue[100],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Телефон:')),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                readOnly: editProfile.isEnabled == 0,
                                controller: phoneController,
                                style: const TextStyle(color: Colors.indigo),
                                decoration: InputDecoration(
                                  fillColor: Colors.blue[100],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('E-mail:')),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                readOnly: editProfile.isEnabled == 0,
                                controller: emailController,
                                style: const TextStyle(color: Colors.indigo),
                                decoration: InputDecoration(
                                  fillColor: Colors.blue[100],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text('Пароль:')),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                readOnly: editProfile.isEnabled == 0,
                                controller: passwordController,
                                obscureText: true,
                                style: const TextStyle(color: Colors.indigo),
                                decoration: InputDecoration(
                                  fillColor: Colors.blue[100],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              (editProfile.isEnabled == 0
                                  ? const Text('Редактирование запрещено')
                                  : (InkWell(
                                      onTap: () {
                                        log('object');
                                        log(editProfile.isEnabled.toString());
                                        // print(_editProfile.groupId);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 5,
                                                blurRadius: 7,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient:
                                                const LinearGradient(colors: [
                                              Color.fromRGBO(63, 81, 181, 1),
                                              Colors.blue,
                                              Colors.indigo
                                            ])),
                                        child: const Center(
                                          child: Text(
                                            "Сохранить",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ))),
                              const SizedBox(
                                height: 10,
                              ),
                              (editProfile.isEnabled == 0
                                  ? const Text('')
                                  : const Align(
                                      alignment: Alignment.topCenter,
                                      child: Text('Сохранить изменения'))),
                              // child: Text(snapshot.data ?? 'null' : '' ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
