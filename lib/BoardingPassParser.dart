import 'package:flutter/material.dart';
import 'package:hms_scan_demo/Passenger.dart';

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
          RegExp regExp = RegExp(r'^0+(?=.)');

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
          String dayOfYear = barcodeContent.substring(44, 47);
          passenger.compartment = barcodeContent.substring(47, 48);
          passenger.flight = passenger.iataCode + " " + passenger.flightNo;
          String seatNumber = barcodeContent.substring(48, 52).trim();
          seatNumber = seatNumber.replaceAll(regExp, "");
          passenger.seatNo = seatNumber;
          passenger.flightDate = dayOfYear;

          if (dayOfYear.contains(" ")) {
            dayOfYear = dayOfYear.trim();
          }
          passenger.flightDate = dayOfYear;
        } on Exception catch (ex) {
          passenger = null;
        }
      } else {
        passenger = null;
        if ((barcodeContent.contains("!") || barcodeContent.contains("?")) ||
            barcodeContent.contains(":")) {
        } else {
          debugPrint("barcodeContent is FAIL : " + barcodeContent);
        }
      }
    } else {
      passenger = null;
    }
    return passenger;
  }
}
