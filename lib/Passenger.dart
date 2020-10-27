import 'dart:convert';

class Passenger {
  String nameSurname;
  String iataCode;
  String flightNo;
  String flight;
  String flightDate;
  String flightFrom;
  String flightTo;
  String seatNo;
  String pnrCode;
  String compartment;
  String boardingData;

  Passenger(
      {this.nameSurname,
      this.iataCode,
      this.flightNo,
      this.flight,
      this.flightDate,
      this.flightFrom,
      this.flightTo,
      this.seatNo,
      this.pnrCode,
      this.compartment,
      this.boardingData});

  factory Passenger.fromMap(Map<String, dynamic> map) {
    return Passenger(
      nameSurname: map["nameSurname"] == null ? null : map["nameSurname"],
      iataCode: map["iataCode"] == null ? null : map["iataCode"],
      flightNo: map["flightNo"] == null ? null : map["flightNo"],
      flight: map["flight"] == null ? null : map["flight"],
      flightDate: map["flightDate"] == null ? null : map["flightDate"],
      flightFrom: map["flightFrom"] == null ? null : map["flightFrom"],
      flightTo: map["flightTo"] == null ? null : map["flightTo"],
      seatNo: map["seatNo"] == null ? null : map["seatNo"],
      pnrCode: map["pnrCode"] == null ? null : map["pnrCode"],
      compartment: map["compartment"] == null ? null : map["compartment"],
      boardingData: map["boardingData"] == null ? null : map["boardingData"],
    );
  }

  factory Passenger.fromJson(String source) =>
      Passenger.fromMap(json.decode(source));
}
