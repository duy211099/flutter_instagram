import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final bool isCurrentUser;
  final bool isFollowing;

  const ProfileButton({
    Key? key,
    required this.isCurrentUser,
    required this.isFollowing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isCurrentUser
        ? TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              primary: Colors.white,
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 16),
            ),
          )
        : TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: isFollowing
                  ? Colors.grey[300]
                  : Theme.of(context).primaryColor,
              primary: isFollowing ? Colors.black : Colors.white,
            ),
            child: Text(
              isFollowing ? 'Unfollow' : 'Follow',
              style: const TextStyle(fontSize: 16),
            ),
          );
  }
}
