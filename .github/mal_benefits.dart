import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MalBenefitsScreen extends StatelessWidget {
  final Map<String, dynamic>? benefitsData;
  final String plantName;

  const MalBenefitsScreen({
    Key? key,
    required this.benefitsData,
    required this.plantName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (benefitsData == null || !benefitsData!.containsKey(plantName)) {
      return Scaffold(
        appBar: AppBar(
          title: Text('$plantName'),
        ),
        body: Center(
          child: Text(
            '$plantName കൊണ്ട് എന്തെങ്കിലും മാനം കണ്ടെത്തിയില്ല',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    Map<String, dynamic>? plantData = benefitsData![plantName];

    List<String>? uses = plantData!['ഉപയോഗങ്ങൾ'] != null
        ? List<String>.from(plantData['ഉപയോഗങ്ങൾ'])
        : null;

    List<String>? benefits = plantData['പ്രയോജനങ്ങൾ'] != null
        ? List<String>.from(plantData['പ്രയോജനങ്ങൾ'])
        : null;

    List<String>? sideEffects = plantData['പാർശ്വഫലങ്ങൾ'] != null
        ? List<String>.from(plantData['പാർശ്വഫലങ്ങൾ'])
        : null;

    String? precautions = plantData['സുരക്ഷ മുന്നറിയിപ്പുകൾ'] != null
        ? plantData['സുരക്ഷ മുന്നറിയിപ്പുകൾ']
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('$plantName '),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.network('https://projectify-files.web.app/medgrow/assets/images/skin.json'),
              if (uses != null)
                ElevatedButton(
                  onPressed: () {
                    _showBenefitsDialog(context, 'ഉപയോഗങ്ങൾ', uses);
                  },
                  child: const Text(
                    'ഉപയോഗങ്ങൾ കാണുക',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
              if (benefits != null)
                ElevatedButton(
                  onPressed: () {
                    _showBenefitsDialog(context, 'പ്രയോജനങ്ങൾ', benefits);
                  },
                  child: const Text(
                    'പ്രയോജനങ്ങൾ കാണുക',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
              if (sideEffects != null)
                ElevatedButton(
                  onPressed: () {
                    _showBenefitsDialog(context, 'പാർശ്വഫലങ്ങൾ', sideEffects);
                  },
                  child: const Text(
                    'പാർശ്വഫലങ്ങൾ കാണുക',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
              if (precautions != null)
                ElevatedButton(
                  onPressed: () {
                    _showPrecautionsDialog(context, precautions);
                  },
                  child: const Text(
                    'സുരക്ഷ മുന്നറിയിപ്പുകൾ കാണുക',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showBenefitsDialog(
      BuildContext context, String title, List<String> benefits) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: benefits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.check_circle),
                  title: Text(
                    benefits[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'അടയ്ക്കുക',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrecautionsDialog(BuildContext context, String precautions) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'സുരക്ഷ മുന്നറിയിപ്പുകൾ',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Text(
            precautions,
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'അടയ്ക്കുക',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
