import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/repositories/auth/auth_repository.dart';
import 'package:flutter_instagram/screens/signup/cubit/signup_cubit.dart';
import 'package:flutter_instagram/widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeName = '/signup';

  SignUpScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (_) =>
            SignUpCubit(authRepository: context.read<AuthRepository>()),
        child: SignUpScreen(),
      ),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status == SignUpStatus.error) {
              ErrorDialog(content: state.failure.message);
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Instagram',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Username'),
                              onChanged: (value) =>
                                  cubit.usernameChanged(value),
                              validator: (value) => value!.trim().isEmpty
                                  ? 'Must not be empty.'
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                              onChanged: (value) => cubit.emailChanged(value),
                              validator: (value) => !value!.contains('@')
                                  ? 'Please enter a valid email.'
                                  : null,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              obscureText: true,
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                              onChanged: (value) =>
                                  cubit.passwordChanged(value),
                              validator: (value) => value!.length < 6
                                  ? 'Must be at least 6 characters.'
                                  : null,
                            ),
                            const SizedBox(height: 28),
                            ElevatedButton(
                              onPressed: () => _submitForm(
                                context,
                                state.status == SignUpStatus.submitting,
                              ),
                              child: const Text('Sign Up'),
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Back to Login'),
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                                primary: Colors.grey[200],
                                onPrimary: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState!.validate() && !isSubmitting) {
      context.read<SignUpCubit>().signUpWithCredential();
    }
  }
}
