part of 'tweet_bloc.dart';

@immutable
sealed class TweetEvent {}

class CreateTweetInitialFetchEvent extends TweetEvent{}