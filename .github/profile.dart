import 'package:medgrow/pref.dart';
import 'package:medgrow/services/firestore_service.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {  bool isEnglish = true;
  Future<void> _checkLanguagePreference() async {
    setState(() {
      // Using the LanguagePreferences class to get the language preference
      LanguagePreferences.getLanguagePreference().then((value) {
        setState(() {
          isEnglish = value;
        });
      });
    });
  }  @override
  void initState() {
    super.initState();
    // Load data from assets

        _checkLanguagePreference();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEnglish ? Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ) : Text(
          'പ്രൊഫൈൽ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ProfileScreen(
        providers: [EmailAuthProvider()],
        actions: [
          AccountDeletedAction((context, user) {
            final FirestoreService firestoreService = FirestoreService();
            firestoreService.deleteDocument('medgrowUsers', user.uid);
          })
        ],
      ),
    );
  }
}
