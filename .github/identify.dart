import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:medgrow/constants.dart';
import 'package:medgrow/data/plant_data.dart';
import 'package:medgrow/pref.dart';

class IdentifyScreen extends StatefulWidget {
  const IdentifyScreen({Key? key}) : super(key: key);

  @override
  _IdentifyScreenState createState() => _IdentifyScreenState();
}

class _IdentifyScreenState extends State<IdentifyScreen> {
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

  Future<void> _toggleLanguage() async {
    setState(() {
      isEnglish = !isEnglish;
    });
    // Using the LanguagePreferences class to set the language preference
    LanguagePreferences.setLanguagePreference(isEnglish);
  }

  bool _isLoading = false;
  Map<String, dynamic>? _response;
  Map<String, dynamic>? _benefitsData;

  @override
  void initState() {
    super.initState();
    _checkLanguagePreference();
  }

  Future<void> _selectImage(BuildContext context, bool isCamera) async {
    setState(() {
      _isLoading = true;
    });

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      var url = Uri.http('$serverIp:5000', '/upload_image');

      var request = http.MultipartRequest('POST', url);
      var takenPicture = await http.MultipartFile.fromPath("image", image.path);
      request.files.add(takenPicture);
      var response = await request.send();
      if (response.statusCode == 200) {
        print('Image uploaded!');
        var responseData = await response.stream.bytesToString();
        print(responseData);

        // Parse JSON response
        _response = jsonDecode(responseData);

// Assuming jsonPlantData is the JSON string you provided
        Map<String, dynamic> plantData = isEnglish
            ? json.decode(jsonEnglishPlantData)
            : json.decode(jsonMalPlantData);

        Map<String, String> englishToMalayalam = {
          'Aloevera': 'കറ്റാർ വാഴ',
          'Amla': 'നെല്ലിക്ക',
          'Arali': 'ആരാളി',
          'Brahmi': 'ബ്രഹ്മി',
          'Chilly': 'മുളക്',
          'Jackfruit': 'ചക്ക',
          'Bringaraja': 'ബ്രിങ്ങരാജ',
          'Coffee': 'കോഫി',
          'Curry Leaves': 'മല്ലിയില',
          'Eucalyptus': 'യൂക്കലിപ്ത്തസ്',
          'Ginger': 'ഇഞ്ചി',
          'Guava': 'പേരക്ക',
          'Henna': 'ഹെന്ന',
          'Hibiscus': 'ഹൈബിസ്കസ്',
          'Lemon': 'നാരങ്ങ',
          'Mint': 'പുതിന',
          'Neem': 'വേപ്പ',
          'Pepper': 'മഞ്ഞ',
          'Tamarind': 'പുളിയരിപ്പാളം',
          'Tulasi': 'മഞ്ഞേരി',
          'Turmeric': 'ബാംബൂ',
          'Bamboo': 'മല്ലി',
          'Coriander': 'പപ്പായ',
          'Pappaya': 'ചില്ലി',
          'Drum Stick': 'ചക്ക',
          'Tomato': 'തക്കാളി',
          'Jasmine': 'ജാസ്മിൻ',
          'Rose': 'മാങ്ങ'
        };

        String malayalamPrediction =
            englishToMalayalam[_response!['prediction']] ?? '';

        isEnglish
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: const Text('Prediction Result'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Image

                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 16.0),
                            child: Text(
                              'Prediction: ${_response!['prediction']}',
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),

                          Text(
                            'Biological Name: ${plantData[_response!['prediction']]['biological_name']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Divider(),
                          Text(
                              'Description: ${plantData[_response!['prediction']]['description']}'),
                          const Divider(),
                          Text(
                              'Uses: ${plantData[_response!['prediction']]['uses']}'),
                          const Divider(),
                          Text(
                              'Benefits: ${plantData[_response!['prediction']]['benefits']}'),
                          const Divider(),
                          Text(
                              'Side Effects: ${plantData[_response!['prediction']]['side_effects']}'),
                          const Divider(),
                          Text(
                              'Medication Allergy: ${plantData[_response!['prediction']]['medication_allergies']}'),
                          const Divider(),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              )
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: AlertDialog(
                      title: const Text('പ്രവചന ഫലം'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Image
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 16.0),
                            child: Text(
                              'പ്രവചന: $malayalamPrediction',
                              textAlign: TextAlign.center,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'ജൈവിക പേരുംപ്രദർശനം: ${plantData[malayalamPrediction]['ജൈവ നാമം']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Divider(),
                          Text(
                              'വിവരണം: ${plantData[malayalamPrediction]['വിവരണം']}'),
                          const Divider(),
                          Text(
                              'ഉപയോഗങ്ങൾ: ${plantData[malayalamPrediction]['ഉപയോഗങ്ങൾ']}'),
                          const Divider(),
                          Text(
                              'പ്രയോജനങ്ങൾ: ${plantData[malayalamPrediction]['പ്രയോജനങ്ങൾ']}'),
                          const Divider(),
                          Text(
                              'പാർശ്വഫലങ്ങൾ: ${plantData[malayalamPrediction]['പാർശ്വഫലങ്ങൾ']}'),
                          const Divider(),
                          Text(
                              'മരുന്ന് അലർജികൾ: ${plantData[malayalamPrediction]['മരുന്ന് അലർജികൾ']}'),
                          const Divider(),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('ശരി'),
                        ),
                      ],
                    ),
                  );
                },
              );
      } else {
        print('Image not uploaded');
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isEnglish ? Text('SmartMedGrow') : Text('സ്മാർട്ട് മെഡ് ഗ്രോ'),
        actions: [
          IconButton(
            onPressed: _toggleLanguage,
            icon: Icon(Icons.translate_outlined),
          ),
          SizedBox(height: 20),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.network(
                'https://projectify-files.web.app/medgrow/assets/images/plant2.json',
                height: 250),
            !isEnglish
                ? Text('സ്മാർട്ട് മെഡ് ഗ്രോലേക്ക് സ്വാഗതം')
                : Text(
                    'Welcome to SmartMedGrow',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
            const SizedBox(height: 20),
            isEnglish
                ? Text(
                    'Take a photo of a plant or select an image from your gallery to identify plant.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  )
                : Text(
                    'ചെടിയെ തിരിച്ചറിയാൻ ഒരു ചെടിയുടെ ഫോട്ടോ എടുക്കുക അല്ലെങ്കിൽ നിങ്ങളുടെ ഗാലറിയിൽ നിന്ന് ഒരു ചിത്രം തിരഞ്ഞെടുക്കുക.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed:
                      _isLoading ? null : () => _selectImage(context, false),
                  icon: const Icon(Icons.browse_gallery),
                  label: _isLoading
                      ? const CircularProgressIndicator()
                      : isEnglish
                          ? Text('Upload from gallery')
                          : Text('ഗാലറി'),
                ),
                ElevatedButton.icon(
                  onPressed:
                      _isLoading ? null : () => _selectImage(context, true),
                  icon: const Icon(Icons.photo_camera),
                  label: _isLoading
                      ? const CircularProgressIndicator()
                      : isEnglish
                          ? Text('Capture Image')
                          : Text('ക്യാമറ'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
