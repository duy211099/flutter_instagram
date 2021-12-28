import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_instagram/config/paths.dart';
import 'package:flutter_instagram/models/models.dart';
import 'package:flutter_instagram/repositories/repositories.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseFirestore _fireBaseFireStore;
  final auth.FirebaseAuth _firebaseAuth;

  @override
  Stream<auth.User?> get user => _firebaseAuth.userChanges();

  AuthRepository(
      {FirebaseFirestore? firebaseFirestore, auth.FirebaseAuth? firebaseAuth})
      : _fireBaseFireStore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Future<auth.User?> signUpWithEmailAndPassword(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = credential.user;
      _fireBaseFireStore.collection(Paths.users).doc(user!.uid).set(
        {
          'username': username,
          'email': email,
          'followers': 0,
          'following': 0,
        },
      );
      return user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
  }

  @override
  Future<auth.User?> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message!);
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
