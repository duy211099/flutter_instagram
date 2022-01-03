import 'package:flutter_instagram/models/models.dart';

abstract class BaseUserRepository {
  Future<User> getUserWithId({required String userId});
  Future<void> updateUser({required User user});
}
