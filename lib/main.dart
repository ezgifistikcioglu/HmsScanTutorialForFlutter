import 'package:flutter/material.dart';
import 'package:hms_scan_demo/GenerateBarcodeScreen.dart';
import 'package:huawei_scan/hmsScanPermissions/HmsScanPermissions.dart';

import 'CustomUi.dart';
import 'ScanScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Scan Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    permissionRequest();
    super.initState();
  }

  permissionRequest() async {
    bool permissionResult =
        await HmsScanPermissions.hasCameraAndStoragePermission();
    if (permissionResult == false) {
      await HmsScanPermissions.requestCameraAndStoragePermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipPath(
                clipper: WaveClipper2(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepPurple[200], Colors.deepPurple])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper3(),
                child: Container(
                  child: Column(),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepPurple[50], Colors.deepPurple])),
                ),
              ),
              ClipPath(
                clipper: WaveClipper1(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        "assets/scan_kit_logo.png",
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Plane Ticket Scan",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.deepPurpleAccent[100],
                    Colors.purple[50]
                  ])),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.deepPurple[300]),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScanScreen(),
                          ),
                        );
                      },
                      color: Colors.deepPurpleAccent[100],
                      textColor: Colors.white,
                      splashColor: Colors.black45,
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Scan Barcode",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.deepPurple[300]),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GenerateBarcodeScreen(),
                          ),
                        );
                      },
                      color: Colors.deepPurpleAccent[100],
                      textColor: Colors.white,
                      splashColor: Colors.black45,
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Generate Barcode",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
