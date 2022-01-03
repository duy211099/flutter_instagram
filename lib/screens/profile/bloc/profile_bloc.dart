import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_instagram/blocs/blocs.dart';
import 'package:flutter_instagram/models/models.dart';
import 'package:flutter_instagram/repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  final AuthBloc _authBloc;

  ProfileBloc(
      {required UserRepository userRepository, required AuthBloc authBloc})
      : _authBloc = authBloc,
        _userRepository = userRepository,
        super(ProfileState.initial()) {
    on<ProfileLoadUser>((event, emit) async {
      emit(state.copyWith(status: ProfileStatus.loading));
      try {
        final user = await _userRepository.getUserWithId(userId: event.userId);
        final isCurrentUser = _authBloc.state.user!.uid == event.userId;

        emit(state.copyWith(
          user: user,
          isCurrentUser: isCurrentUser,
          status: ProfileStatus.loaded,
        ));
      } catch (err) {
        emit(state.copyWith(
            status: ProfileStatus.error,
            failure: const Failure(message: 'Unable to load the profile')));
      }
    });
  }
}
