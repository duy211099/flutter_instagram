import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/blocs/blocs.dart';
import 'package:flutter_instagram/screens/profile/widgets/widgets.dart';
import 'package:flutter_instagram/widgets/widgets.dart';

import 'bloc/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(content: state.failure.message),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              if (state.isCurrentUser)
                IconButton(
                  onPressed: () =>
                      context.read<AuthBloc>().add(AuthLogOutRequested()),
                  icon: Icon(Icons.exit_to_app),
                )
            ],
            title: Text(state.user.username),
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
                    child: Row(
                      children: [
                        UserProfileImage(
                          radius: 40,
                          profileImageUrl: state.user.profileImageUrl,
                        ),
                        ProfileStats(
                          isCurrentUser: state.isCurrentUser,
                          isFollowing: state.isFollowing,
                          posts: 0,
                          followers: state.user.followers,
                          following: state.user.following,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: ProfileInfo(
                      username: state.user.username,
                      bio: 'aaa', //state.user.bio,
                    ),
                  )
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
