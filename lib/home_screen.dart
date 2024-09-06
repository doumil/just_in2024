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
import 'model/userScan.dart';
import 'model/setinuser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dropdownValue;
  var response;
  String _data = "";
  //List<Conf> liteconf = [];
  Userscan24 user = Userscan24(nom:'', prenom: '', email: '', societe: '', tel: '', profession: '', hashedOrderId: '', ticket: '',);
  Userscan24 user1 = Userscan24(nom:'', prenom: '', email: '', societe: '', tel: '', profession: '', hashedOrderId: '', ticket: '',);
  var order;
  InUser inUser1 = InUser('', '', '');
  String ticketscan="";

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    //_loadData();
  }
  void _openbadge(BuildContext context) async{
    prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString("prenom");
    String? lastname = prefs.getString("nom");
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
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,4.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 50,
                          ),
                          Center(child: Text('${firstname.toString()} ${lastname.toString()}',
                            style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),)),
                          //Center(child: Text()),
                          SizedBox(height: 10), // Add spacing between texts and VIP status
                          Center(
                            child: Text(
                              '${ticket.toString()}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
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
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              "Check-in réussi !",
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
    String? firstname = prefs.getString("prenom");
    String? lastname = prefs.getString("nom");
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
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,4.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 50,
                          ),
                          Center(child: Text('${firstname.toString()} ${lastname.toString()}',              style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),)),
                          //Center(child: Text('')),
                          SizedBox(height: 10), // Add spacing between texts and VIP status
                          Center(
                            child: Text(
                              '${ticket.toString()}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
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
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              "Check-out réussi !",
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
  }//user created out
  void _Failedin(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString("prenom");
    String? lastname = prefs.getString("nom");
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
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                      Center(child: Text('${firstname.toString()} ${lastname.toString()}',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),)),
                      //Center(child: Text('')),
                      SizedBox(height: 10), // Add spacing between texts and VIP status
                      Center(
                        child: Text(
                          '${ticket.toString()}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            //color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
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
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "QR code déjà utilisé!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
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
    String? firstname = prefs.getString("prenom");
    String? lastname = prefs.getString("nom");
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
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                      Center(child: Text('${firstname.toString()} ${lastname.toString()}',
                        style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),)),
                      //Center(child: Text('')),
                      SizedBox(height: 10), // Add spacing between texts and VIP status
                      Center(
                        child: Text(
                          '${ticket.toString()}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
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
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Check-out déjà effectué!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
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
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,4.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [ // Add spacing between texts and VIP status
                        Center(
                          child:Icon(
                            Icons.warning,
                            color: Colors.orangeAccent,
                            size: 48.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.orangeAccent,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Qrcode invalid !",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
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
    String? firstname = prefs.getString("prenom");
    String? lastname = prefs.getString("nom");
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
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text('${firstname.toString()} ${lastname.toString()}')),
                      //Center(child: Text('')),
                      SizedBox(height: 10), // Add spacing between texts and VIP status
                      Center(
                        child: Text(
                          '${ticket.toString()}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
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
                      padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,4.0),
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
  }
  void _AccesFailed(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    String? firstname = prefs.getString("prenom");
    String? lastname = prefs.getString("nom");
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
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0,0.0,0.0,4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.not_interested,
                          color: Colors.red,
                          size: 50,
                        ),
                      ),
                      Center(child: Text('${firstname.toString()} ${lastname.toString()}')),
                      //Center(child: Text('')),
                      SizedBox(height: 10), // Add spacing between texts and VIP status
                      Center(
                        child: Text(
                          '${ticket.toString()}',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
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
                          SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              "Check-in non autorisé",
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
  }//user has non acces ticket
/*  Future<void> _loadData() async {
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
  }*/
  Future<void> _scan() async {
    String data = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Annuler",
      true,
      ScanMode.QR,
    );

    if (data == '-1') {
      // Fluttertoast.showToast(
      //   msg: 'QR code invalid',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      // );
    } else {
      List<String> list1 = data.split(";");
      if (list1.length == 8) { // Ensure the length matches the number of fields
        user = Userscan24(
          nom: list1[0],
          prenom: list1[1],
          societe: list1[2],
          profession: list1[3],
          ticket: list1[4],
          email: list1[5],
          tel: list1[6],
          hashedOrderId: list1[7],
        );
        ticketscan=user.ticket.toString();
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
    order=user.hashedOrderId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? conf = prefs.getString("conf") ?? "1";
    String statut = prefs.getString("statut") ?? "in";
    if(statut=="in"){
      print("conferance  :${conf}");
        if(conf=="3") {
           if(ticketscan=="VIP TICKET"){
             var url = "https://badging-ticket.jcloud-ver-jpe.ik-server.com/api/handle-in";
             var dt = {
               "order":order.substring(1, order.length - 1),
               "edition_id":"104",
               "id_conf": conf,
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
                   case "Created in":
                     user1 = Userscan24.fromJson(jsonResponse2["user"]);
                     print(user1);
                     // Fluttertoast.showToast(
                     //   msg: '${user1}',
                     //   toastLength: Toast.LENGTH_SHORT,
                     //   gravity: ToastGravity.CENTER,
                     // );
                     prefs.setString('prenom', user1.prenom ?? '');
                     prefs.setString('nom', user1.nom ?? '');
                     prefs.setString('ticket', user1.ticket ?? '');
                     _openbadge(context);
                     break;
                   default:
                   // Fluttertoast.showToast(
                   //   msg: 'default',
                   //   toastLength: Toast.LENGTH_SHORT,
                   //   gravity: ToastGravity.CENTER,
                   // );
                   // Handle unknown response or error
                     break;
                 }
               } else {
                 // Handle unexpected response format
               }
             } catch (e) {
               // Handle network or server errors
               print("Error: $e");
               // Fluttertoast.showToast(
               //   msg: 'error $e',
               //   toastLength: Toast.LENGTH_SHORT,
               //   gravity: ToastGravity.CENTER,
               // );
             }
           }
           else{
             _AccesFailed(context);
           }
         }
        else if(conf=="2"){
          if(ticketscan=="VIP TICKET" || ticketscan=="ADVANCED TICKET"){
            var url = "https://badging-ticket.jcloud-ver-jpe.ik-server.com/api/handle-in";
            var dt = {
              "order":order.substring(1, order.length - 1),
              "edition_id":"104",
              "id_conf": conf,
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
                  case "Created in":
                    user1 = Userscan24.fromJson(jsonResponse2["user"]);
                    print(user1);
                    // Fluttertoast.showToast(
                    //   msg: '${user1}',
                    //   toastLength: Toast.LENGTH_SHORT,
                    //   gravity: ToastGravity.CENTER,
                    // );
                    prefs.setString('prenom', user1.prenom ?? '');
                    prefs.setString('nom', user1.nom ?? '');
                    prefs.setString('ticket', user1.ticket ?? '');
                    _openbadge(context);
                    break;
                  default:
                  // Fluttertoast.showToast(
                  //   msg: 'default',
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.CENTER,
                  // );
                  // Handle unknown response or error
                    break;
                }
              } else {
                // Handle unexpected response format
              }
            } catch (e) {
              // Handle network or server errors
              print("Error: $e");
              // Fluttertoast.showToast(
              //   msg: 'error $e',
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.CENTER,
              // );
            }
          }
          else{
            _AccesFailed(context);
          }
        }
        else {
          var url = "https://badging-ticket.jcloud-ver-jpe.ik-server.com/api/handle-in";
          var dt = {
            "order":order.substring(1, order.length - 1),
            "edition_id":"104",
            "id_conf": conf,
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
                case "Created in":
                  user1 = Userscan24.fromJson(jsonResponse2["user"]);
                  print(user1);
                  // Fluttertoast.showToast(
                  //   msg: '${user1}',
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.CENTER,
                  // );
                  prefs.setString('prenom', user1.prenom ?? '');
                  prefs.setString('nom', user1.nom ?? '');
                  prefs.setString('ticket', user1.ticket ?? '');
                  _openbadge(context);
                  break;
                default:
                // Fluttertoast.showToast(
                //   msg: 'default',
                //   toastLength: Toast.LENGTH_SHORT,
                //   gravity: ToastGravity.CENTER,
                // );
                // Handle unknown response or error
                  break;
              }
            } else {
              // Handle unexpected response format
            }
          } catch (e) {
            // Handle network or server errors
            print("Error: $e");
            // Fluttertoast.showToast(
            //   msg: 'error $e',
            //   toastLength: Toast.LENGTH_SHORT,
            //   gravity: ToastGravity.CENTER,
            // );
          }
        }
      // print("in 1");
      // print("--------handle in${conf}");
      // Fluttertoast.showToast(
      //   msg: '--------handle in${conf}',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      // );

    }
    else{
      print("--------handle out${conf}");
      // Fluttertoast.showToast(
      //   msg: '--------handle out${conf}',
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      // );
      var url = "https://badging-ticket.jcloud-ver-jpe.ik-server.com/api/handle-out";
      var dt = {
        "order": order.substring(1, order.length - 1),
        "edition_id": "104",
        "id_conf": conf.toString(),

      };
      try {
        var res2 = await http.post(Uri.parse(url), body: dt);
        var jsonResponse2 = json.decode(res2.body);
        print("res out --------------${res2.body}");
        // Fluttertoast.showToast(
        //   msg: 'res out --------------${res2.body}',
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        // );
        if (jsonResponse2.containsKey("message")) {
          String message = jsonResponse2["message"];

          switch (message) {
            case "No user found":
              _Usernitfound(context);
              break;
            case "Failed out, no prior out":
              _Failedoutprior(context);
              break;
            case "Created out":
              user1 = Userscan24.fromJson(jsonResponse2["user"]);
              prefs.setString('prenom', user1.prenom ?? '');
              prefs.setString('nom', user1.nom ?? '');
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
        // Fluttertoast.showToast(
        //   msg: 'Error: $e',
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        // );
      }
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
                        child: Image.asset(
                          'assets/logoemec.png', // Make sure this path is correct
                          width: 250, // Adjust the size as needed
                          height: 250,
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
