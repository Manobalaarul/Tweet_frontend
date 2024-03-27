import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tweet/features/create_tweet/repos/create_tweet_repos.dart';
import 'package:uuid/uuid.dart';

part 'create_tweet_event.dart';
part 'create_tweet_state.dart';

class CreateTweetBloc extends Bloc<CreateTweetEvent, CreateTweetState> {
  CreateTweetBloc() : super(CreateTweetInitial()) {
    on<CreateTweetPostEvent>(createTweetPostEvent);
  }

  FutureOr<void> createTweetPostEvent(
      CreateTweetPostEvent event, Emitter<CreateTweetState> emit) async {
    emit(CreateTweetLoadingState());
    String currentUSerId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final uuid = Uuid().v1();
    bool success = await CreateTweetRepo.postTweetRepo(
        uuid, currentUSerId, event.content, DateTime.now());
    if (success) {
      emit(CreateTweetSuccessState());
    } else {
      emit(CreateTweetErrorState());
    }
  }
}
