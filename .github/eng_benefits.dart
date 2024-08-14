import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EngBenefitsScreen extends StatelessWidget {
  final Map<String, dynamic>? benefitsData;
  final String plantName;

  const EngBenefitsScreen({
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
            'No benefits found for $plantName',
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    List<String>? skincareBenefits =
        benefitsData![plantName]['skincare_benefits'] != null
            ? List<String>.from(benefitsData![plantName]['skincare_benefits'])
            : null;

    List<String>? haircareBenefits =
        benefitsData![plantName]['haircare_benefits'] != null
            ? List<String>.from(benefitsData![plantName]['haircare_benefits'])
            : null;

    List<String>? healthTips =
        benefitsData![plantName]['health_tips'] != null
            ? List<String>.from(benefitsData![plantName]['health_tips'].values)
            : null;

    String? dietPlans =
        benefitsData![plantName]['diet_plans'] != null
            ? benefitsData![plantName]['diet_plans']
            : null;

    Map<String, dynamic>? plantGrowth =
        benefitsData![plantName]['plant_growth'] != null
            ? Map<String, dynamic>.from(benefitsData![plantName]['plant_growth'])
            : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('$plantName Benefits'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.network('https://projectify-files.web.app/medgrow/assets/images/skin.json'),
              if (skincareBenefits != null)
                ElevatedButton(
                  onPressed: () {
                    _showBenefitsDialog(
                        context, 'Skincare Benefits', skincareBenefits);
                  },
                  child: const Text(
                    'View Skincare Benefits',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
              if (haircareBenefits != null)
                ElevatedButton(
                  onPressed: () {
                    _showBenefitsDialog(
                        context, 'Haircare Benefits', haircareBenefits);
                  },
                  child: const Text(
                    'View Haircare Benefits',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
              if (healthTips != null)
                ElevatedButton(
                  onPressed: () {
                    _showBenefitsDialog(context, 'Health Tips', healthTips);
                  },
                  child: const Text(
                    'View Health Tips',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
              if (dietPlans != null)
                ElevatedButton(
                  onPressed: () {
                    _showDietPlansDialog(context, dietPlans);
                  },
                  child: const Text(
                    'View Diet Plans',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              const SizedBox(height: 20),
              if (plantGrowth != null)
                ElevatedButton(
                  onPressed: () {
                    _showPlantGrowthDialog(context, plantGrowth);
                  },
                  child: const Text(
                    'View Plant Care Tips',
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
                  leading: const Icon(
                      Icons.check_circle), // Add your desired icon here
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
                'Close',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showDietPlansDialog(BuildContext context, String dietPlans) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Diet Plans',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Text(
            dietPlans,
            style: const TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPlantGrowthDialog(BuildContext context, Map<String, dynamic> plantGrowth) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Plant Growth Tips',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: plantGrowth.entries.map((entry) {
              return ListTile(
                title: Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  entry.value.toString(),
                ),
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
