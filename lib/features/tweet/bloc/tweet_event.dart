part of 'tweet_bloc.dart';

@immutable
sealed class TweetEvent {}

class CreateTweetInitialFetchEvent extends TweetEvent {}

class DeleteTweetEvent extends TweetEvent {
  final String tweetId;

  DeleteTweetEvent({required this.tweetId});
}
