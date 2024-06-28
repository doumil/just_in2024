import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:just_in2024/home_screen.dart';
import 'package:just_in2024/model/conf.dart';

class FirstPageSlide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late SharedPreferences prefs;
  List<Conf> liteconf = [];
  String _selectedOption = "in"; // Default radio button value
  String dropdownValue = ""; // Default dropdown value

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Save the selected option to SharedPreferences
  Future<void> _saveSelectedOption(String option) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('statut', option);
  }

  // Load configuration data from API and SharedPreferences
  Future<void> _loadData() async {
    var url = "https://okydigital.com/buzz_login/loadconf.php";
    var res = await http.post(Uri.parse(url));
    List<Conf> conf = (json.decode(res.body) as List)
        .map((data) => Conf.fromJson(data))
        .toList();
    liteconf = conf;

    // Load saved values from SharedPreferences
    prefs = await SharedPreferences.getInstance();
    String? savedConf = prefs.getString("conf");
    String? savedStatut = prefs.getString("statut");

    setState(() {
      dropdownValue = savedConf ?? liteconf[0].id_conf;
      _selectedOption = savedStatut ?? "in";
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return OnBoardingSlider(
      finishButtonText: 'Commencez',
      onFinish: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: const Color(0xff682062),
      ),
      skipTextButton: const Text(
        'Ignorer',
        style: TextStyle(
          fontSize: 16,
          color: const Color(0xff682062),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Text(
        'Ignorer',
        style: TextStyle(
          fontSize: 16,
          color: const Color(0xff682062),
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
      controllerColor: const Color(0xff682062),
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      imageHorizontalOffset: width * 0.25,
      imageVerticalOffset: height * 0.2,
      background: [
        Image.asset('assets/intro_photo1.png', width: 200, height: 200),
        Image.asset('assets/intro_photo2.png', width: 250, height: 250),
        Image.asset('assets/intro_photo3.png', width: 300, height: 300),
      ],
      speed: 2,
      pageBodies: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Scannez',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff682062),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Vous pouvez scanner le code QR\n ou le code-barre de votre visiteur',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff682062),
                  fontSize: 15.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          margin: EdgeInsets.only(top: height * 0.63),
          padding: EdgeInsets.only(bottom: height * 0.01),
          width: width * 0.9,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Vous pouvez choisir in ou out',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff682062),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: const Text('In'),
                    leading: Radio<String>(
                      value: "in",
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                          _saveSelectedOption(value);
                        });
                      },
                      activeColor: Color(0xff682062),
                    ),
                  ),
                  ListTile(
                    title: const Text('Out'),
                    leading: Radio<String>(
                      value: "out",
                      groupValue: _selectedOption,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedOption = value!;
                          _saveSelectedOption(value);
                        });
                      },
                      activeColor: Color(0xff682062),
                    ),
                  ),
                ],
              ),
            ],
          ),
          margin: EdgeInsets.only(top: height * 0.63),
          padding: EdgeInsets.only(bottom: height * 0.01),
          width: width * 0.9,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Vous pouvez choisir la configuration',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xff682062),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Container(
                  child: Center(
                    child: Wrap(
                      children: <Widget>[
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black38, width: 1),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.57),
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: DropdownButton(
                              underline: Container(),
                              iconEnabledColor: const Color(0xff682062),
                              style: TextStyle(
                                color: const Color(0xff682062),
                                fontSize: 18,
                              ),
                              value: dropdownValue,
                              items: liteconf.map((list) {
                                return DropdownMenuItem<String>(
                                  value: list.id_conf,
                                  child: Text(list.name),
                                );
                              }).toList(),
                              onChanged: (value) async {
                                var _v = value as String; // Cast 'value' to String
                                prefs = await SharedPreferences.getInstance();
                                prefs.setString("conf", _v); // Use '_v' instead of 'value!'
                                setState(() {
                                  dropdownValue = _v;
                                });
                              },

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          margin: EdgeInsets.only(top: height * 0.63),
          padding: EdgeInsets.only(bottom: height * 0.01),
          width: width * 0.9,
        ),
      ],
    );
  }
}

void main() => runApp(FirstPageSlide());
