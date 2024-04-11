part of 'update_tweet_bloc.dart';

@immutable
sealed class UpdateTweetEvent {}

class UpdateTweetPostEvent extends UpdateTweetEvent {
  final String tweetId;
  final String content;

  UpdateTweetPostEvent({
    required this.tweetId,
    required this.content,
  });
}
