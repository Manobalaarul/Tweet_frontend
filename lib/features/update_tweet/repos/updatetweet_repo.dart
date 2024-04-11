import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweet/core/config.dart';

class UpdateTweetRepo {
  static Future<bool> updateTweet(String tweetId, content,DateTime updatedAt) async {
    try {
      Dio dio = Dio();
      final response = await dio.put(Config.server_url + 'tweet', data: {
        "tweetId": tweetId,
        "content": content,
        "createdAt": updatedAt.toIso8601String()
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
