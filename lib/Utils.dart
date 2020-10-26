import 'package:huawei_scan/utils/HmsScanTypes.dart';

/*
** compartment codes **
         // Discount Economy: K,L,Q,V,W,U,T,X,N,O,S
         // Full Fare Economy: Y,B,M,H
         // Premium Economy: W,E
         // Discounted Business: D,I,Z
         // Full Fare Business: J,C,D
         // First: A,F
 */
List<String> compartmentDiscountStringList = [
  "K",
  "L",
  "Q",
  "V",
  "W",
  "U",
  "T",
  "X",
  "N",
  "O",
  "S",
  "Y",
  "B",
  "M",
  "H",
  "W",
  "E",
  "D",
  "I",
  "Z",
  "J",
  "C",
  "D",
  "A",
  "F",
];

List<int> scanTypeList = [
  HmsScanTypes.QRCode,
  HmsScanTypes.Aztec,
  HmsScanTypes.Pdf417,
];
List<String> scanTypeStringList = [
  "QRCode",
  "Aztec",
  "Pdf417",
];
List<String> airlineStringList = [
  "PC",
  "B6",
  "KL",
  "THY",
  "TK",
  "XQ",
  "TU",
  "AZ",
];
List<String> cityStringList = [
  "SAW",
  "ASR",
  "AYT",
  "ESB",
  "FCO",
  "LIN",
  "UNK",
  "ADB",
  "TZX",
  "ERZ",
  "FRA",
  "FCO",
  "JFK",
  "IST",
  "LGW",
  "CRL",
  "STN",
  "DLM",
  "OSL",
  "TBS",
  "VKO",
  "BLQ",
  "ARN",
  "BOS",
];
//Dropdown Controllers
dropdownController(String value) {
  int result = scanTypeStringList.indexOf(value);
  return scanTypeList[result];
}
