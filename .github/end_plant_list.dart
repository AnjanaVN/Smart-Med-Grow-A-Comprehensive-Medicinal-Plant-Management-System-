import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:medgrow/home/eng_benefits.dart';
import 'package:medgrow/home/mal_benefits.dart';
import 'package:medgrow/pref.dart';
import 'package:http/http.dart' as http;

class EnglishPlantListHome extends StatefulWidget {
  const EnglishPlantListHome({super.key});

  @override
  _EnglishPlantListHomeState createState() => _EnglishPlantListHomeState();
}

class _EnglishPlantListHomeState extends State<EnglishPlantListHome> {
  List<String>? plants;
  late Map<String, dynamic> benefitsData;
  bool isEnglish = true;
  Future<void> _checkLanguagePreference() async {
    setState(() {
      // Using the LanguagePreferences class to get the language preference
      LanguagePreferences.getLanguagePreference().then((value) {
        setState(() {
          isEnglish = value;
        });
        if (isEnglish) {
          loadEnglishAssetsData();
        } else {
          loadMalAssetsData();
        }
      });
    });
  }

  Future<void> _toggleLanguage() async {
    setState(() {
      isEnglish = !isEnglish;
    });
  
    LanguagePreferences.setLanguagePreference(isEnglish);
  }

  @override
  void initState() {
    super.initState();
    _checkLanguagePreference();
  }

  Future<void> loadEnglishAssetsData() async {
    String data = '';
    try {
      var response = await http.get(Uri.parse(
          'https://projectify-files.web.app/medgrow/assets/images/data.json'));

      if (response.statusCode == 200) {
        data = response.body;
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading data: $error');
    }

    benefitsData = json.decode(data);

    setState(() {
      plants = benefitsData.keys.toList();
    });
  }

  Future<void> loadMalAssetsData() async {
    String data = await rootBundle.loadString('assets/images/malayalam.json');
    benefitsData = json.decode(data);
    setState(() {
      plants = benefitsData.keys.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEnglish
            ? Text(
                'SmartMedGrow',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            : Text(
                'സ്മാർട്ട് മെഡ് ഗ്രോ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: isEnglish
                  ? Text(
                      'In every plant, a remedy; in every leaf, a story of healing.',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      'എല്ലാ ചെടികളിലും, ഒരു പ്രതിവിധി; ഓരോ ഇലയിലും രോഗശാന്തിയുടെ കഥ.',
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Lottie.network(
                'https://projectify-files.web.app/medgrow/assets/images/plant.json',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            flex: 2,
            child: plants == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: plants!.length,
                    itemBuilder: (context, index) {
                      String plantName = plants![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 16,
                        ),
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              plantName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            trailing: const Icon(
                                Icons.arrow_forward_ios), // Add arrow icon
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => isEnglish
                                        ? EngBenefitsScreen(
                                            benefitsData: benefitsData,
                                            plantName: plantName,
                                          )
                                        : MalBenefitsScreen(
                                            benefitsData: benefitsData,
                                            plantName: plantName,
                                          )),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
