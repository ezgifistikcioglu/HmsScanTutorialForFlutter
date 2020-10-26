import 'dart:convert';

class Passenger {
  String nameSurname;
  String iataCode;
  String flightNo;
  String flight;
  String flightDate;
  var flightFrom;
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

/*
- M1 normal passenger
- M2 transfer passenger
 M1DONMEZ.MUSTAFAISMAILEX89CCB SAWTZXPC 2822 312Y026F0058 100
 M1ATES.MEHMET HAKAN   E4F9AAD SAWECNPC 1912 032Y004D0007 100

 eg. : M1AKGUL.UBEYDE        E5K8YY4 SAWADAPC 2092 047Y020B0078 100
 eg. : M1AKGUL.UBEYDE        ERTD5A7 SAWDLMTK 2992 276Y025A0025 150>10B2OO7276BTK 29235232530081801TK                    020K(30600000K0902       X
 eg. : M2AKGUL.UBEYDE        EDWRJU7 OSLSAWPC 1274 199Y002F0141 35D>5180O 0199BSK              2A62421652899800 PC                         (30600000K09         DWRJU7 SAWESBPC 2674 199Y002B0061 3372A62421652899800 PC

pieces for normalPassenger : M1

piece1 :  0 - 2  : (  2  ) : formatAndNumberOfLegEncoded : M1                    / M1
piece2 :  2 - 22 : (  20 ) : PassengerNameSurname        : DONMEZ.MUSTAFAISMAIL  / ATES.MEHMET HAKAN___
piece3 : 22 - 23 : (  1  ) : ElectronicTicketIndicator   : E                     / E
piece4 : 23 - 30 : (  7  ) : OperatingCarrier PNRCode    : X89CCB_               / 4F9AAD_
piece5 : 30 - 33 : (  3  ) : FromCityAirportCode         : SAW                   / SAW
piece6 : 33 - 36 : (  3  ) : ToCityAirportCode           : TZX                   / ECN
piece7 : 36 - 39 : (  3  ) : OperatingCarrierDesignator  : PC_                   / PC
piece8 : 39 - 44 : (  5  ) : FlightNumber                : 2822_                 / 1912_
piece9 : 44 - 47 : (  3  ) : DayOfFlight (DayOfYear)     : 312                   / 032
piece10: 47 - 48 : (  1  ) : CompartmentClassCode        : Y                     / Y
piece11: 48 - 52 : (  4  ) : SeatNumber                  : 026F                  / 004D
// not using
piece12: 52 - 57 : (  5  ) : Check-InSequenceNumber      : 0058_                 / 0007_
piece13: 57 - 58 : (  1  ) : PassengerStatus             : 1                     / 1
 */

  Passenger createTestPassenger() {
    Passenger passenger = new Passenger();
    passenger.nameSurname = "SCARLET JHONSON";
    passenger.iataCode = "TK";
    passenger.flightNo = "2244";
    passenger.flightDate = "125";
    passenger.flightFrom = "SAW";
    passenger.flightTo = "LAX";
    passenger.seatNo = "002A";
    passenger.pnrCode = "5K8YY4";
    passenger.compartment = "Y";
    passenger.boardingData =
        "M1JHONSON.SCARLET    E5K8YY4 SAWLAXTK 2244 125Y002A0078 100";
    return passenger;
  }
}
