import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medgrow/pref.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {    bool isEnglish = true;Future<void> _checkLanguagePreference() async {
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
        title: isEnglish ?  Text(
          'About Us',
          style: TextStyle(fontWeight: FontWeight.bold),
        ) : Text(
          'ഞങ്ങളുടെ ടീം',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const SizedBox(
            height: 60,
          ),
          Lottie.network('https://projectify-files.web.app/medgrow/assets/images/about.json'),
          const Center(
            child: Text(
              'About Us',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildMemberCard(
            name: 'Amritha R',
            email: 'amrithanair2@gmail.com',
            avatarColor: Colors.orange,
          ),
          const SizedBox(height: 5),
          _buildMemberCard(
            name: 'Anjana V Nair',
            email: 'anjanavnair369@gmail.com',
            avatarColor: Colors.green,
          ),
          const SizedBox(height: 5),
          _buildMemberCard(
            name: 'Ann Mariya Jose',
            email: 'annjov313@gmail.com',
            avatarColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard({
    required String name,
    required String email,
    required Color avatarColor,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: avatarColor,
          child: Text(
            name.substring(0, 1),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(email),
      ),
    );
  }
}
