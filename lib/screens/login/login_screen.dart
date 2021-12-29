import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';
  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        transitionDuration: const Duration(seconds: 0),
        pageBuilder: (_, __, ___) => LoginScreen());
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
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
                          decoration: const InputDecoration(hintText: 'Email'),
                          onChanged: (value) => print(value),
                          validator: (value) => !value!.contains('@')
                              ? 'Please enter a valid email.'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          decoration:
                              const InputDecoration(hintText: 'Password'),
                          onChanged: (value) => print(value),
                          validator: (value) => value!.length < 6
                              ? 'Must be at least 6 characters.'
                              : null,
                        ),
                        const SizedBox(height: 28),
                        ElevatedButton(
                          onPressed: () {
                            print('Login');
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            elevation: 1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            print('Navigate to signup');
                          },
                          child: Text('No account? Sign up'),
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
        ),
      ),
    );
  }
}
