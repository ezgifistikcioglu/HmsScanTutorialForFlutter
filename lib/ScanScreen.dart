import 'package:flutter/material.dart';
import 'package:hms_scan_demo/BoardingPassParser.dart';
import 'package:hms_scan_demo/CustomUi.dart';
import 'package:hms_scan_demo/Passenger.dart';
import 'package:huawei_scan/hmsScanUtils/DefaultViewRequest.dart';
import 'package:huawei_scan/hmsScanUtils/HmsScanUtils.dart';
import 'package:huawei_scan/model/ScanResponse.dart';
import 'package:huawei_scan/utils/HmsScanTypes.dart';

import 'DateUtils.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String passengerNameSurnameSc;
  String pnrCodeSc;
  String fromCityAirportCodeSc;
  String toCityAirportCodeSc;
  String operatingCarrierDesignatorSc;
  String flightNumberSc;
  String dayOfFlightSc;
  String compartmentClassCodeSc;
  String seatNumberSc;
  String resultSc;
  Passenger passenger;
  String dateFromDay;
  @override
  void initState() {
    startScan();
    super.initState();
  }

  startScan() async {
    DefaultViewRequest request =
        new DefaultViewRequest(scanType: HmsScanTypes.AllScanType);
    ScanResponse response = await HmsScanUtils.startDefaultView(request);
    String result = response.originalValue;
    debugPrint("Detail Scan Result: " + result.toString());

    // TODO check camera permission and notify to user
    setState(() {
      passenger = BoardingPassParser().parseAndGetPassengerDetail(result);
      if (passenger != null) {
        setUiValuesFromPassengerObjectParsedByTicket(passenger);
        resultSc = result;
      } else {
        debugPrint("Please scan a Valid boardingPass ticket barcode!!!");
        resultSc = null;
      }
    });
  }

  setUiValuesFromPassengerObjectParsedByTicket(Passenger passenger) {
    passengerNameSurnameSc = passenger.nameSurname;
    pnrCodeSc = passenger.pnrCode;
    fromCityAirportCodeSc = passenger.flightFrom;
    toCityAirportCodeSc = passenger.flightTo;
    operatingCarrierDesignatorSc = passenger.iataCode;
    flightNumberSc = passenger.flightNo;
    dayOfFlightSc = passenger.flightDate;
    dateFromDay = DateUtils.getDateTimeFromDayOfYear(dayOfFlightSc);
    compartmentClassCodeSc = passenger.compartment;
    seatNumberSc = passenger.seatNo;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text('BOARDING PASS'),
          backgroundColor: Colors.deepPurple[200],
        ),
        body: resultSc != null
            ? Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.deepPurple[200],
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                  Positioned.fill(
                    top: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 100.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple,
                              blurRadius: 8.0,
                              offset: Offset(0, 4),
                            )
                          ],
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xfff7f9ff)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 25.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.deepPurple[200],
                                  Color(0xfff7f9ff)
                                ],
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      fromCityAirportCodeSc,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                          SizedBox(
                                            height: 9.0,
                                          ),
                                          Text(
                                            dateFromDay,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      toCityAirportCodeSc,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 15.0),
                                  height: 100,
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/cloud.png",
                                      ),
                                      Image.asset(
                                        "assets/plane.png",
                                        width: 500,
                                        height: 500,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FlightInfoRow(
                                  title: "PNR Code",
                                  content: pnrCodeSc,
                                ),
                              ),
                              Expanded(
                                child: FlightInfoRow(
                                  title: "Flight Designator",
                                  content: operatingCarrierDesignatorSc,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: FlightInfoRow(
                                  title: "Flight Number",
                                  content: flightNumberSc,
                                ),
                              ),
                              Expanded(
                                child: FlightInfoRow(
                                  title: "Compartment Class",
                                  content: compartmentClassCodeSc,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 15.0),
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                              Colors.white70,
                              Colors.deepPurple[100]
                            ])),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50.0))),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 30,
                                            child: Icon(Icons.person,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(
                                      flex: 1,
                                    ),
                                    FittedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            passengerNameSurnameSc,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(
                                      flex: 3,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25.0))),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 40,
                                            child: Icon(
                                                Icons
                                                    .airline_seat_recline_normal_rounded,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            seatNumberSc,
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : CustomAlertDialog(
                "Please scan a Valid boardingPass ticket barcode"));
  }
}
