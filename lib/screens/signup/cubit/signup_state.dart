part of 'signup_cubit.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignUpState extends Equatable {
  final String username;
  final String email;
  final String password;
  final Failure failure;
  final SignUpStatus status;

  bool get isFormValid =>
      username.isNotEmpty && email.isNotEmpty && password.isNotEmpty;

  const SignUpState({
    required this.username,
    required this.email,
    required this.password,
    required this.failure,
    required this.status,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      email: '',
      password: '',
      username: '',
      failure: Failure(),
      status: SignUpStatus.initial,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [email, password, failure, status, username];

  SignUpState copyWith({
    String? email,
    String? username,
    String? password,
    Failure? failure,
    SignUpStatus? status,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
