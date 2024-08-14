import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:medgrow/constants.dart';
import 'package:medgrow/data/plant_data.dart';

class Plant {
  final String name;
  final String biologicalName;
  final String description;
  final String uses;
  final String benefits;
  final String sideEffects;
  final String safetyWarnings;
  final String medicationAllergies;

  Plant({
    required this.name,
    required this.biologicalName,
    required this.description,
    required this.uses,
    required this.benefits,
    required this.sideEffects,
    required this.safetyWarnings,
    required this.medicationAllergies,
  });

  factory Plant.fromJson(String name, Map<String, dynamic> json) {
    return Plant(
      name: name,
      biologicalName: json['biological_name'],
      description: json['description'],
      uses: json['uses'],
      benefits: json['benefits'],
      sideEffects: json['side_effects'],
      safetyWarnings: json['safety_warnings'],
      medicationAllergies: json['medication_allergies'],
    );
  }
}

class PlantListPage extends StatefulWidget {
  const PlantListPage({super.key});

  @override
  _PlantListPageState createState() => _PlantListPageState();
}

class _PlantListPageState extends State<PlantListPage> {
  late List<Plant> plants;
  late List<Plant> filteredPlants;

  @override
  void initState() {
    super.initState();

    Map<String, dynamic> plantData = jsonDecode(jsonEnglishPlantData);
    plants = plantData.entries
        .map((entry) =>
            Plant.fromJson(entry.key, Map<String, dynamic>.from(entry.value)))
        .toList();
    filteredPlants = List.from(plants);
  }

  void _filterPlants(String query) {
    setState(() {
      filteredPlants = plants
          .where(
              (plant) => plant.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Encyclopedia'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by plant name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterPlants,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPlants.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Text(filteredPlants[index].name),
                    onTap: () {
                      
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(filteredPlants[index].name),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Biological Name:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(filteredPlants[index]
                                            .biologicalName),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Description:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(filteredPlants[index].description),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Uses:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(filteredPlants[index].uses),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Benefits:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(filteredPlants[index].benefits),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Side Effects:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(filteredPlants[index].sideEffects),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Safety Warnings:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(filteredPlants[index]
                                            .safetyWarnings),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.all(5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Medication Allergies:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(filteredPlants[index]
                                            .medicationAllergies),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
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
