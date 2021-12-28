import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_instagram/repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late StreamSubscription<auth.User?> _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthState.unknown()) {
    _userSubscription =
        _authRepository.user.listen((user) => add(AuthUserChanged(user: user)));
    on<AuthUserChanged>((event, emit) async {
      event.user != null
          ? emit(AuthState.authenticated(user: event.user!))
          : emit(AuthState.unauthenticated());
    });
    on<AuthLogOutRequested>(
        (event, emit) async => await _authRepository.logOut());
  }

  // Stream<AuthState> _mapAuthUserChangeToState(AuthUserChanged event) async* {
  //   yield event.user != null
  //       ? AuthState.authenticated(user: event.user!)
  //       : AuthState.unauthenticated();
  // }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
