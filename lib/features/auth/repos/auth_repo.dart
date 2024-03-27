import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweet/core/config.dart';
import 'package:tweet/features/auth/modals/user_modal.dart';

class AuthRepo {
  static Future<UserModal?> getUserRepo(String uid) async {
    try {
      Dio dio = Dio();
      final response = await dio.get(Config.server_url + "user/$uid");
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        UserModal userModal = UserModal.fromMap(response.data);
        return userModal;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> createUserRepo(UserModal userModal) async {
    Dio dio = Dio();
    final response =
        await dio.post(Config.server_url + "user", data: userModal.toMap());
    if (response.statusCode! >= 200 && response.statusCode! <= 300) {
      return true;
    } else {
      return false;
    }
  }
}
