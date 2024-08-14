import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medgrow/home/eng_benefits.dart';
import 'package:medgrow/pref.dart'; // Import your BenefitsScreen here

class DiseaseListPage extends StatefulWidget {
  const DiseaseListPage({Key? key}) : super(key: key);

  @override
  _DiseaseListPageState createState() => _DiseaseListPageState();
}

class _DiseaseListPageState extends State<DiseaseListPage> {
  bool isEnglish = true;
  Future<void> _checkLanguagePreference() async {
    setState(() {
      // Using the LanguagePreferences class to get the language preference
      LanguagePreferences.getLanguagePreference().then((value) {
        setState(() {
          isEnglish = value;
        });
      });
    });
  }



  List<String> diseases = [];
  late Map<String, dynamic> remediesData;

  @override
  void initState() {
    super.initState();
    // Load data from assets
    loadAssetsData();
        _checkLanguagePreference();
  }

  Future<void> loadAssetsData() async {
    String data = await rootBundle.loadString('assets/images/remedies.json');
    remediesData = json.decode(data);
    // Extract disease names
    setState(() {
      diseases = remediesData.keys.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isEnglish ?  Text(
          'Disease Remedies',
          style: TextStyle(fontWeight: FontWeight.bold),
        ): Text(
          'രോഗ പരിഹാരങ്ങൾ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: diseases.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: diseases.length,
                      itemBuilder: (context, index) {
                        String diseaseName = diseases[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RemediesScreen(
                                  remediesData: remediesData,
                                  diseaseName: diseaseName,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                diseaseName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class RemediesScreen extends StatelessWidget {
  final Map<String, dynamic> remediesData;
  final String diseaseName;

  const RemediesScreen({
    Key? key,
    required this.remediesData,
    required this.diseaseName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String>? remedies =
        remediesData[diseaseName]['remedies'] != null
            ? List<String>.from(remediesData[diseaseName]['remedies'])
            : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('$diseaseName Remedies'),
      ),
      body: remedies == null
          ? Center(
              child: Text(
                'No remedies found for $diseaseName',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Remedies for $diseaseName',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: remedies.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              remedies[index],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
