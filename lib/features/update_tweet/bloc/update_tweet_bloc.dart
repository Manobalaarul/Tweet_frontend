import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tweet/features/update_tweet/repos/updatetweet_repo.dart';

part 'update_tweet_event.dart';
part 'update_tweet_state.dart';

class UpdateTweetBloc extends Bloc<UpdateTweetEvent, UpdateTweetState> {
  UpdateTweetBloc() : super(UpdateTweetInitial()) {
    on<UpdateTweetPostEvent>(updateTweetPostEvent);
  }

  FutureOr<void> updateTweetPostEvent(
      UpdateTweetPostEvent event, Emitter<UpdateTweetState> emit) async {
    emit(UpdateTweetLoadingState());
    bool success = await UpdateTweetRepo.updateTweet(
        event.tweetId, event.content, DateTime.now());
    if (success) {
      emit(UpdateTweetSuccessState());
    } else {
      emit(UpdateTweetErrorState());
    }
  }
}
