import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:tweet/app.dart';
import 'package:tweet/core/local_db/shared_pref_manager.dart';
import 'package:tweet/features/auth/modals/user_modal.dart';
import 'package:tweet/features/auth/repos/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

enum AuthType { google, login, register }

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthenticationEvent>(authenticationEvent);
  }

  FutureOr<void> authenticationEvent(
      AuthenticationEvent event, Emitter<AuthState> emit) async {
    UserCredential? credential;
    switch (event.authType) {
      case AuthType.google:
        try {
          credential = await AuthRepo.signWithGoogle();
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email.');
            emit(AuthErrorState(error: "No user found!"));
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user.');
            emit(AuthErrorState(error: "Wrong Password"));
          }
        }

        break;
      case AuthType.login:
        try {
          credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          log(credential.toString());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            log('No user found for that email.');
            emit(AuthErrorState(error: "No user found!"));
          } else if (e.code == 'wrong-password') {
            log('Wrong password provided for that user.');
            emit(AuthErrorState(error: "Wrong Password"));
          }
        }
        break;
      case AuthType.register:
        try {
          credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
            emit(AuthErrorState(error: "The password provided is too weak."));
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
            emit(AuthErrorState(
                error: "The account already exists for that email."));
          }
        } catch (e) {
          log(e.toString());
          emit(AuthErrorState(error: "Something went wrong"));
        }
    }
    if (credential != null) {
      if (event.authType == AuthType.login) {
        emit(AuthLoadingState());
        UserModal? userModal =
            await AuthRepo.getUserRepo(credential.user?.uid ?? "");
        if (userModal != null) {
          await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
          DecidePage.authStream.add(credential.user?.uid ?? "");

          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState(error: "Something went wrong"));
        }
      } else if (event.authType == AuthType.register) {
        emit(AuthLoadingState());
        bool success = await AuthRepo.createUserRepo(UserModal(
            uid: credential.user?.uid ?? "",
            tweets: [],
            firstname: event.firstname,
            lastname: event.lastname,
            email: event.email,
            createdAt: DateTime.now().toString()));
        if (success) {
          await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
          DecidePage.authStream.add(credential.user?.uid ?? "");
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState(error: "Something went wrong"));
        }
      } else if (event.authType == AuthType.google) {
        emit(AuthLoadingState());
        UserModal? userModal =
            await AuthRepo.getUserRepo(credential.user?.uid ?? "");
        if (userModal != null) {
          await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
          DecidePage.authStream.add(credential.user?.uid ?? "");
          emit(AuthSuccessState());
        } else {
          emit(AuthLoadingState());
          bool success1 = await AuthRepo.createUserRepo(UserModal(
              uid: credential.user?.uid ?? "",
              tweets: [],
              firstname: credential.user?.displayName ?? "",
              lastname: "",
              email: credential.user?.email ?? "",
              createdAt: DateTime.now().toString()));
          if (success1) {
            await SharedPreferencesManager.saveUid(credential.user?.uid ?? "");
            DecidePage.authStream.add(credential.user?.uid ?? "");
            emit(AuthSuccessState());
          } else {
            emit(AuthErrorState(error: "Something went wrong"));
          }
        }
      }
    } else {
      log("Credintial is not coming");
      emit(AuthErrorState(error: "Something went wrong"));
    }
  }
}
