part of 'update_tweet_bloc.dart';

@immutable
sealed class UpdateTweetState {}

final class UpdateTweetInitial extends UpdateTweetState {}

abstract class UpdateTweetActionState extends UpdateTweetState {}

class UpdateTweetLoadingState extends UpdateTweetActionState {}

class UpdateTweetSuccessState extends UpdateTweetActionState {}

class UpdateTweetErrorState extends UpdateTweetActionState {}
