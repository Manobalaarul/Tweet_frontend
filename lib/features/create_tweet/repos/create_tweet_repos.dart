import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweet/core/config.dart';

class CreateTweetRepo {
  static Future<bool> postTweetRepo(
      String tweetId, adminId, content, DateTime createdAt) async {
    try {
      Dio dio = Dio();

      final response = await dio.post(Config.server_url + 'tweet', data: {
        "tweetId": tweetId,
        "adminId": adminId,
        "content": content,
        "createdAt": createdAt.toIso8601String()
      });
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
