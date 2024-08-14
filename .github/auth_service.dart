import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to register a new user
  Future<UserCredential?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      if (kDebugMode) {
        if (kDebugMode) {
          print('Error registering user: $e');
        }
      }
      return null;
    }
  }

  // Function to sign in an existing user
  Future<UserCredential?> signInUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      if (kDebugMode) {
        print('Error signing in user: $e');
      }
      return null;
    }
  }

  // Function to sign out the current user
  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print('Error signing out user: $e');
      }
    }
  }

  // Function to get the current user
  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current user: $e');
      }
      return null;
    }
  }

  String? getCurrentUserUID() {
    try {
      return _auth.currentUser!.uid;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current user: $e');
      }
      return null;
    }
  }

  String? getCurrentUserEmail() {
    try {
      return _auth.currentUser!.email;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current user: $e');
      }
      return null;
    }
  }

  String? getCurrentUserDisplayName() {
    try {
      return _auth.currentUser!.displayName;
    } catch (e) {
      if (kDebugMode) {
        print('Error getting current user: $e');
      }
      return null;
    }
  }

  // Function to check if a user is currently signed in
  bool isUserSignedIn() {
    try {
      return _auth.currentUser != null;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking if user is signed in: $e');
      }
      return false;
    }
  }

  // Function to send a password reset email to the user
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      if (kDebugMode) {
        print('Error sending password reset email: $e');
      }
    }
  }

  // Function to update the user's password
  Future<void> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser!.updatePassword(newPassword);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating password: $e');
      }
    }
  }
}
