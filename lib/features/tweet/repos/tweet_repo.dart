import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tweet/core/config.dart';
import 'package:tweet/features/tweet/modals/tweet_modal.dart';

class TweetRepo {
  static Future<List<TweetModal>> getAllTweets() async {
    try {
      Dio dio = Dio();

      final response = await dio.get(Config.server_url + 'getAllTweets');
      List<TweetModal> tweets = [];
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        for (int i = 0; i < response.data['data'].lenght; i++) {
          tweets.add(TweetModal.fromMap(response.data['data']['i']));
        }
      }
      return tweets;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
