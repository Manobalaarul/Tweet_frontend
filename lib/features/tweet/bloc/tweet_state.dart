part of 'tweet_bloc.dart';

@immutable
sealed class TweetState {}

final class TweetInitial extends TweetState {}

abstract class TweetActionState extends TweetState {}

class TweetLoadState extends TweetState {}

class TweetSuccessState extends TweetState {
  final List<TweetModal> tweets;
  TweetSuccessState({
    required this.tweets,
  });
}

class TweetErrorState extends TweetState {}
