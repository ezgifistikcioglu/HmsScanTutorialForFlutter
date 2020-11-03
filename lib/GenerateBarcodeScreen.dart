import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_scan/HmsScanLibrary.dart';

import 'CustomUi.dart';
import 'DateUtils.dart';
import 'Utils.dart';

class GenerateBarcodeScreen extends StatefulWidget {
  @override
  _GenerateBarcodeScreenState createState() => _GenerateBarcodeScreenState();
}

class _GenerateBarcodeScreenState extends State<GenerateBarcodeScreen> {
  Image _image = new Image.asset('barcode.png');
  String scanTypeValue = 'QRCode';
  String airlineIata = "PC";
  String flightFrom = "SAW";
  String flightTo = "TZX";
  String compartmentCode = "Y";
  String barcodeContentManually = "";
  BuildBitmapRequest bitmapRequest;
  int scanTypeValueFromDropDown = HmsScanTypes.QRCode;

  //M1DONMEZ.MUSTAFAISMAILEX89CCB SAWTZXPC 2832 312Y026F0058 100

  final TextEditingController contentController = TextEditingController();
  final TextEditingController surnameController =
      TextEditingController(text: "DONMEZ");
  final TextEditingController nameController =
      TextEditingController(text: "MUSTAFA ISMAIL");
  final TextEditingController flightNumberController =
      TextEditingController(text: "2822");
  final TextEditingController selectedDateController =
      TextEditingController(text: "2020-10-25");
  DateTime selectedDateTime = DateUtils.getTodayDateTime();
  final TextEditingController seatNumberController =
      TextEditingController(text: "026F");
  final TextEditingController pnrCodeController =
      TextEditingController(text: "X89CCB");
  final TextEditingController sequenceNumberController =
      TextEditingController(text: "0058");

  // Get Ui TextEditingController contents
  BuildBitmapRequest getContentDetail(String barcodeContent) {
    barcodeContent = contentController.text;

    bitmapRequest = BuildBitmapRequest(content: barcodeContent);
    bitmapRequest.type = scanTypeValueFromDropDown;

    String surname = surnameController.text;
    String name = nameController.text;
    String pnrNo = pnrCodeController.text;
    String flightNo = flightNumberController.text;
    String flightDate = selectedDateController.text;
    String seatNumber = seatNumberController.text;
    String sequenceNumber = sequenceNumberController.text;

    // Validation must not be null
    if (surname.isEmpty ||
        name.isEmpty ||
        pnrNo.isEmpty ||
        flightNo.isEmpty ||
        flightDate.isEmpty ||
        seatNumber.isEmpty ||
        surname.isEmpty ||
        sequenceNumber.isEmpty) {
      bitmapRequest = null;
    } else {
      if ((surname.length + name.length) > 18) {
        if (surname.length > 9) {
          surname = surname.substring(0, 9);
        }
        if (name.length > 9) {
          name = name.substring(0, 9);
        }
      }
      //Create content suitable for flight tickets with barcodeContentManually
      barcodeContentManually = "M1" + surname + "/" + name;

      while (barcodeContentManually.length < 22) {
        barcodeContentManually = barcodeContentManually + " ";
      }
      barcodeContentManually = barcodeContentManually + "E";
      barcodeContentManually = barcodeContentManually + pnrNo + " ";

      if (airlineIata.length == 2) {
        airlineIata = airlineIata + " ";
      }
      barcodeContentManually =
          barcodeContentManually + flightFrom + flightTo + airlineIata;
      while (flightNo.length < 4) {
        flightNo = "0" + flightNo;
      }
      if (flightNo.length == 4) {
        flightNo = flightNo + " ";
      }

      // Transform date to dayOfYear
      flightDate = DateUtils.getDayOfYearFromDateTime(selectedDateTime);

      barcodeContentManually = barcodeContentManually + flightNo;
      barcodeContentManually = barcodeContentManually + flightDate;
      barcodeContentManually = barcodeContentManually + compartmentCode;
      barcodeContentManually = barcodeContentManually + seatNumber;
      barcodeContentManually = barcodeContentManually + sequenceNumber + " ";
      barcodeContentManually = barcodeContentManually + " 10";
      bitmapRequest.content = barcodeContentManually;

      // debugPrint("******* barcodeContentManually : " + barcodeContentManually.toString());

      return bitmapRequest;
    }
  }

  // Show date picker in the ui.
  void callDatePicker() async {
    selectedDateTime = await DateUtils.getDatePickerDialog(context);
    selectedDateController.text = selectedDateTime.toString().substring(0, 10);
    setState(() {});
  }

  generateBarcode() async {
    //Constructing request object with contents from getContentDetail.
    bitmapRequest = getContentDetail(barcodeContentManually);
    if (bitmapRequest == null) {
      ShowMyDialog.showCustomDialog(context, "INFORMATION VALIDATION ERROR ",
          "You should input properly values for flight and passenger information");
      _image = null;
    } else {
      Image image;
      try {
        //Call buildBitmap API with request object.
        image = await HmsScanUtils.buildBitmap(bitmapRequest);
      } on PlatformException catch (err) {
        debugPrint(err.details);
      }
      _image = image;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text("Generate Boarding Barcode"),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepPurple[50], Colors.deepPurple[200]]),
                  borderRadius: new BorderRadius.circular(30.0)),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        child: Stack(
                          children: [
                            Image.asset(
                              "assets/plane.png",
                              width: 200,
                              height: 160,
                            ),
                            Image.asset(
                              "assets/barcode.png",
                            ),
                          ],
                        )),
                    CustomTextFormField(
                      text: "Surname Content",
                      controller: surnameController,
                    ),
                    CustomTextFormField(
                      text: "Name Width",
                      controller: nameController,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              CustomTextFormField(
                                prefixIcon: Icon(Icons.calendar_today),
                                text: 'Date',
                                controller: selectedDateController,
                                keyboardType: TextInputType.datetime,
                                suffixIcon: new IconButton(
                                  icon: new Icon(Icons.chevron_right),
                                  tooltip: 'Choose Date',
                                  onPressed: callDatePicker,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            text: "Flight Number",
                            controller: flightNumberController,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            text: "Seat Number",
                            controller: seatNumberController,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            text: "Pnr Number",
                            controller: pnrCodeController,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      text: "Sequence Number",
                      controller: sequenceNumberController,
                    ),
                    CustomDropdown(
                      label: "Airline IATA Code",
                      onChanged: (String newValue) {
                        setState(() {
                          airlineIata = newValue;
                        });
                      },
                      list: airlineStringList,
                      value: airlineIata.trim(),
                    ),
                    CustomDropdown(
                      label: "From City Airport Code: ",
                      onChanged: (String newValue) {
                        setState(() {
                          flightFrom = newValue;
                        });
                      },
                      list: cityStringList,
                      value: flightFrom,
                    ),
                    CustomDropdown(
                      label: "To City Airport Code: ",
                      onChanged: (String newValue) {
                        setState(() {
                          flightTo = newValue;
                        });
                      },
                      list: cityStringList,
                      value: flightTo,
                    ),
                    CustomDropdown(
                      label: "Compartment Class Code: ",
                      onChanged: (String newValue) {
                        setState(() {
                          compartmentCode = newValue;
                        });
                      },
                      list: compartmentDiscountStringList,
                      value: compartmentCode,
                    ),
                    CustomDropdown(
                      label: "Scan Type : ",
                      onChanged: (String newValue) {
                        setState(() {
                          scanTypeValue = newValue;
                          scanTypeValueFromDropDown =
                              dropdownController(scanTypeValue);
                        });
                      },
                      list: scanTypeStringList,
                      value: scanTypeValue,
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(text: "Generate Barcode", onPressed: generateBarcode),
            _image != null
                ? _image
                : CustomAlertDialog(
                    "Please fill in all fields according to flight barcode rules!"),
          ],
        ),
      ),
    );
  }
}
