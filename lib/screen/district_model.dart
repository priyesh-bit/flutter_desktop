// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

List<DistrictModel> districtModelFromJson(String str) => List<DistrictModel>.from(json.decode(str).map((x) => DistrictModel.fromJson(x)));

String districtModelToJson(List<DistrictModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
DistrictModel districtDataFromJson(String str) => DistrictModel.fromJson(jsonDecode(str));

class DistrictModel {
  DistrictModel({
    this.districtNameEnglish,
    this.districtId,
  });

  String districtNameEnglish;
  int districtId;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    districtNameEnglish: json["districtNameEnglish"],
    districtId: json["districtId"],
  );

  Map<String, dynamic> toJson() => {
    "districtNameEnglish": districtNameEnglish,
    "districtId": districtId,
  };
}
