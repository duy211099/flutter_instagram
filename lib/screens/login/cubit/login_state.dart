part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

class LoginState extends Equatable {
  final String email;
  final String password;
  final Failure failure;
  final LoginStatus status;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const LoginState({
    required this.email,
    required this.password,
    required this.failure,
    required this.status,
  });

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      failure: Failure(),
      status: LoginStatus.initial,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [email, password, failure, status];

  LoginState copyWith({
    String? email,
    String? password,
    Failure? failure,
    LoginStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      failure: failure ?? this.failure,
      status: status ?? this.status,
    );
  }
}
