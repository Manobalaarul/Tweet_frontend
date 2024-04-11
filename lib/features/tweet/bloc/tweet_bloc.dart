import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tweet/features/tweet/modals/tweet_modal.dart';
import 'package:tweet/features/tweet/repos/tweet_repo.dart';

part 'tweet_event.dart';
part 'tweet_state.dart';

class TweetBloc extends Bloc<TweetEvent, TweetState> {
  TweetBloc() : super(TweetInitial()) {
    on<CreateTweetInitialFetchEvent>(createTweetInitialFetchEvent);
    on<DeleteTweetEvent>(deleteTweetEvent);
  }

  FutureOr<void> createTweetInitialFetchEvent(
      CreateTweetInitialFetchEvent event, Emitter<TweetState> emit) async {
    emit(TweetLoadState());
    List<TweetModal> tweets = await TweetRepo.getAllTweets();
    emit(TweetSuccessState(tweets: tweets));
  }

  FutureOr<void> deleteTweetEvent(
      DeleteTweetEvent event, Emitter<TweetState> emit) async {
    emit(TweetLoadState());
    await TweetRepo.deleteTweet(event.tweetId);
    List<TweetModal> tweets = await TweetRepo.getAllTweets();
    emit(TweetSuccessState(tweets: tweets));
  }
}
