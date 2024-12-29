import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../model/user/user_model.dart';
import '../storage/local_stroage.dart';

class SessionController {

  final LocalStorage sharedPreferenceClass = LocalStorage();

  static final SessionController _session = SessionController._internal();

  static bool? isLogin;

  static UserModel user = UserModel();

  SessionController._internal() {
    // Initialize default values
    isLogin = false;
  }


  factory SessionController() {
    return _session;
  }


  Future<void> saveUserInPreference(dynamic user) async {
    sharedPreferenceClass.setValue('token', jsonEncode(user));
    // Storing value to check login
    sharedPreferenceClass.setValue('isLogin', 'true');
  }

  Future<void> getUserFromPreference() async {
    try {
      var userData = await sharedPreferenceClass.readValue('token');
      var isLogin = await sharedPreferenceClass.readValue('isLogin');

      if (userData.isNotEmpty) {
        SessionController.user = UserModel.fromJson(jsonDecode(userData));
      }
      SessionController.isLogin = isLogin == 'true' ? true : false;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}