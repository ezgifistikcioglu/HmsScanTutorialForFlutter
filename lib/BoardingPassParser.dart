import 'package:flutter/material.dart';
import 'package:hms_scan_demo/Passenger.dart';
import 'package:intl/intl.dart';

class BoardingPassParser {
  Passenger parseAndGetPassengerDetail(String barcodeContent) {
    Passenger passenger;

    barcodeContent = barcodeContent.toUpperCase();

    if (barcodeContent.length > 51) {
      if (barcodeContent.contains(".") || barcodeContent.contains("/")) {
        if (barcodeContent.contains("/")) {
          barcodeContent = barcodeContent.replaceAll("/", ".");
        }
        if (barcodeContent.startsWith("Ç")) {
          barcodeContent = barcodeContent.replaceAll("Ç", ">");
        }
        if (barcodeContent.startsWith("\\000010")) {
          barcodeContent = barcodeContent.replaceAll("\\000010", "");
        }

        try {
          passenger = new Passenger();

          passenger.boardingData = barcodeContent;

          String formatAndNumberOfLegEncoded = barcodeContent.substring(0, 2);
          String nameSurname =
              barcodeContent.substring(2, 22).toUpperCase().trim();
          if (nameSurname.contains(".")) {
            nameSurname = nameSurname.replaceAll(".", " ");
          }
          passenger.nameSurname = nameSurname.substring(
                  nameSurname.indexOf(" ") + 1, nameSurname.length) +
              " " +
              nameSurname.substring(0, nameSurname.indexOf(" "));

          String electronicTicketIndicator = barcodeContent.substring(22, 23);
          passenger.pnrCode = barcodeContent.substring(23, 30);
          passenger.flightFrom = barcodeContent.substring(30, 33);
          passenger.flightTo = barcodeContent.substring(33, 36);
          passenger.flightNo = barcodeContent.substring(39, 44);
          passenger.iataCode = barcodeContent.substring(36, 39); // piece7
          var piece9 = barcodeContent.substring(44, 47);
          passenger.compartment = barcodeContent.substring(47, 48);
          passenger.flight = passenger.iataCode + " " + passenger.flightNo;
          String seatNumber = barcodeContent.substring(48, 52).trim();

          RegExp regExp = RegExp(r'^0+(?=.)');
          seatNumber = seatNumber.replaceAll(regExp, "");
          passenger.seatNo = seatNumber;

          if (piece9.contains(" ")) {
            piece9 = piece9.trim();
          }
          // TODO check it out
          var now = new DateTime.now();
          var dateFormat = new DateFormat('dd-MM-yyyy');
          String formattedDate = dateFormat.format(now);
          print("*******************************" + formattedDate);
          var day = int.parse(piece9);
          var myvalue = dateFormat.format(DateTime(day * 1000));
          print("*******************************" + myvalue.toString());

          passenger.flightDate = piece9;

          bool isLeapYear(int year) =>
              (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
          print("*******************************" + print.toString());

          // TODO : piece9 --> dayOfFlight

        } on Exception catch (ex) {
          passenger = null;
          debugPrint(
              "Passenger information was not received..!! An error occurred while parsing the barcode... : " +
                  ex.toString());
        }
      } else {
        passenger = null;
        if ((barcodeContent.contains("!") || barcodeContent.contains("?")) ||
            barcodeContent.contains(":")) {
          debugPrint("barcodeContent is FAIL : " + barcodeContent);
        } else {
          debugPrint("barcodeContent is FAIL : " + barcodeContent);
        }
      }
    } else {
      passenger = null;

      debugPrint("HERHANGİ BİR TARAMA VERİSİ ALINAMADI....İÇERİK : " +
          barcodeContent.length.toString());
    }
    // TODO checkt and edit with passneger object return statement
    return passenger;
  }
}
