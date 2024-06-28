import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

import 'firstPage.dart';
import 'model/conf.dart';
import 'model/user_scanner.dart';
import 'model/setinuser.dart';
import 'syncrohn_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dropdownValue;
  var response;
  String _data = "";
  List<Conf> liteconf = [];
  Userscan user1 = Userscan('', '', '', '', '', '', '', '', '', '', '', '');
  InUser inUser1 = InUser('', '', '');

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _openbadge(BuildContext context) async{
    prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString("firstname");
    String? lastname = prefs.getString("lastname");
    String? ticket = prefs.getString("ticket");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(child: Text('${firstname.toString()}')),
                        Center(child: Text('${lastname.toString()}')),
                        SizedBox(height: 10), // Add spacing between texts and VIP status
                        Center(
                          child: Text(
                            '${ticket.toString()}',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green, // Changed button color to green
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Okay let's go!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }//user created in
  void _closebadge(BuildContext context) async{
    prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString("firstname");
    String? lastname = prefs.getString("lastname");
    String? ticket = prefs.getString("ticket");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(child: Text('${firstname.toString()}')),
                        Center(child: Text('${lastname.toString()}')),
                        SizedBox(height: 10), // Add spacing between texts and VIP status
                        Center(
                          child: Text(
                            '${ticket.toString()}',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red, // Changed button color to green
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Okay good by!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }//user created out
  void _Failedin(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString("firstname");
    String? lastname = prefs.getString("lastname");
    String? ticket = prefs.getString("ticket");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text('${firstname.toString()}')),
                      Center(child: Text('${lastname.toString()}')),
                      SizedBox(height: 10), // Add spacing between texts and VIP status
                      Center(
                        child: Text(
                          '${ticket.toString()}',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            //color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Le QR code que vous avez scanné a déjà été utilisé",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }//user has in event
  void _Failedout(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString("firstname");
    String? lastname = prefs.getString("lastname");
    String? ticket = prefs.getString("ticket");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text('${firstname.toString()}')),
                      Center(child: Text('${lastname.toString()}')),
                      SizedBox(height: 10), // Add spacing between texts and VIP status
                      Center(
                        child: Text(
                          '${ticket.toString()}',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Le QR code que vous avez scanné a déjà été out",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }//user has out of event
  void _Usernitfound(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ // Add spacing between texts and VIP status
                      Center(
                        child:Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 48.0,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Le QR code que vous avez scanné invalid",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }//user has not found
  void _Failedoutprior(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString("firstname");
    String? lastname = prefs.getString("lastname");
    String? ticket = prefs.getString("ticket");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          contentPadding: EdgeInsets.zero,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text('${firstname.toString()}')),
                      Center(child: Text('${lastname.toString()}')),
                      SizedBox(height: 10), // Add spacing between texts and VIP status
                      Center(
                        child: Text(
                          '${ticket.toString()}',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Le QR code que vous avez scanné Il doit entrer en premier",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }//user has out of event
  Future<void> _loadData() async {
    var url = "https://okydigital.com/buzz_login/loadconf.php";
    var res = await http.post(Uri.parse(url));
    if (res.statusCode == 200) {
      List<dynamic> confJson = json.decode(res.body);
      List<Conf> confList = confJson.map((e) => Conf.fromJson(e)).toList();
      setState(() {
        liteconf = confList;
        dropdownValue = liteconf.isNotEmpty ? liteconf[0].id_conf : null;
      });
    } else {
      print('Failed to load conferences: ${res.statusCode}');
    }
  }
  Future<void> _scan() async {
    String data = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Annuler",
      true,
      ScanMode.QR,
    );

    if (data == '-1') {
      Fluttertoast.showToast(
        msg: 'QR code invalid',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      List<String> list1 = data.split(":");
      if (list1.length == 6) {
        user1 = Userscan(
          list1[0],
          list1[1],
          list1[2],
          list1[3],
          list1[4],
          list1[5],
          '',
          '',
          '',
          '',
          '',
          '',
        );
        _checkUpdateState();
      } else {
        Fluttertoast.showToast(
          msg: 'QR code invalid',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  Future<void> _checkUpdateState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? conf = prefs.getString("conf");
    String? statut = prefs.getString("statut");
    var url = "https://okydigital.com/buzz_login/testsimpleapi.php";
    var dt = {
      "email": user1.email,
      "id_conf": conf,
      "statut": statut,
    };

    try {
      var res2 = await http.post(Uri.parse(url), body: dt);
      var jsonResponse2 = json.decode(res2.body);

      if (jsonResponse2.containsKey("message")) {
        String message = jsonResponse2["message"];

        switch (message) {
          case "No user found":
            _Usernitfound(context);
            break;
          case "Failed in":
            _Failedin(context);
            break;
          case "Failed out, no prior out":
            _Failedoutprior(context);
            break;
          case "Created in":
            user1 = Userscan.fromJson(jsonResponse2["user"]);
            prefs.setString('firstname', user1.firstname ?? '');
            prefs.setString('lastname', user1.lastname ?? '');
            prefs.setString('ticket', user1.ticket ?? '');
            _openbadge(context);
            break;
          case "Created out":
            user1 = Userscan.fromJson(jsonResponse2["user"]);
            prefs.setString('firstname', user1.firstname ?? '');
            prefs.setString('lastname', user1.lastname ?? '');
            prefs.setString('ticket', user1.ticket ?? '');
            _closebadge(context);
            break;
          case "Failed out":
            _Failedout(context);
            break;
          default:
          // Handle unknown response or error
            break;
        }
      } else {
        // Handle unexpected response format
      }
    } catch (e) {
      // Handle network or server errors
      print("Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[],
        ),
        drawer: Drawer(
          child: Container(
            color: Color(0xfff7f2f7),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/back.png.png"),
                      fit: BoxFit.cover,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(103, 33, 96, 1.0),
                        Colors.black,
                      ],
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Image.asset("assets/logo15.png"),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('parametre'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstPage()),
                    );
                  },
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(200, 100),
                    ),
                    child: Image.asset(
                      "assets/background-buz2.png",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "bienvenue !",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 35,
              child: Column(
                children: <Widget>[
                  Text(
                    'Vous pouvez  scanner maintenant',
                    style: TextStyle(
                      height: 6,
                      color: Color(0xff803b7a),
                      fontWeight: FontWeight.w800,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.grey.withOpacity(0.05),
                          Colors.grey.withOpacity(0.5),
                          Colors.grey.withOpacity(0.05),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 50,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.height * 0.1,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(103, 33, 96, 1.0),
                                  Colors.yellow.shade100,
                                ],
                              ),
                            ),
                            child: IconButton(
                              hoverColor: Color.fromRGBO(103, 33, 96, 1.0),
                              onPressed: ()  async{
                                await _scan();
                                //_openbadge(context);
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: MediaQuery.of(context).size.height * 0.05,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Êtes-vous sûr'),
        content: Text('Voulez-vous quitter une application'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Non'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: Text('Oui '),
          ),
        ],
      ),
    )) ??
        false;
  }
}
