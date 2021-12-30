import 'package:flutter/material.dart';
import 'package:flutter_instagram/screens/login/login_screen.dart';

class FeedScreen extends StatelessWidget {
  static const String routeName = '/feed';
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Feed'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text('Hi')),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
