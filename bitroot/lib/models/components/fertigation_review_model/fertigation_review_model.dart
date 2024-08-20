// To parse this JSON data, do
//
//     final fertigationReviewModel = fertigationReviewModelFromJson(jsonString);

import 'dart:convert';

FertigationReviewModel fertigationReviewModelFromJson(String str) =>
    FertigationReviewModel.fromJson(json.decode(str));

String fertigationReviewModelToJson(FertigationReviewModel data) =>
    json.encode(data.toJson());

class FertigationReviewModel {
  List<Sequential>? simultaneous;
  List<Sequential>? sequential;

  FertigationReviewModel({
    this.simultaneous,
    this.sequential,
  });

  FertigationReviewModel copyWith({
    List<Sequential>? simultaneous,
    List<Sequential>? sequential,
  }) =>
      FertigationReviewModel(
        simultaneous: simultaneous ?? this.simultaneous,
        sequential: sequential ?? this.sequential,
      );

  factory FertigationReviewModel.fromJson(Map<String, dynamic> json) =>
      FertigationReviewModel(
        simultaneous: json["simultaneous"] == null
            ? []
            : List<Sequential>.from(
            json["simultaneous"]!.map((x) => Sequential.fromJson(x))),
        sequential: json["sequential"] == null
            ? []
            : List<Sequential>.from(
            json["sequential"]!.map((x) => Sequential.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "simultaneous": simultaneous == null
            ? []
            : List<dynamic>.from(simultaneous!.map((x) => x.toJson())),
        "sequential": sequential == null
            ? []
            : List<dynamic>.from(sequential!.map((x) => x.toJson())),
      };
}

class Sequential {
  String? device;
  var volume;
  String? mode;
  var preMix;
  var postMix;
  double? fertigation;
  double? value;

  Sequential({
    this.device,
    this.volume,
    this.mode,
    this.preMix,
    this.postMix,
    this.fertigation,
    this.value,
  });

  Sequential copyWith({
    String? device,
    var volume,
    String? mode,
    var preMix,
    var postMix,
    double? fertigation,
    double? value,
  }) =>
      Sequential(
        device: device ?? this.device,
        volume: volume ?? this.volume,
        mode: mode ?? this.mode,
        preMix: preMix ?? this.preMix,
        postMix: postMix ?? this.postMix,
        fertigation: fertigation ?? this.fertigation,
        value: value ?? this.value,
      );

  factory Sequential.fromJson(Map<String, dynamic> json) =>
      Sequential(
        device: json["device"] ?? null,
        volume: json["volume"] ?? null,
        mode: json["mode"] ?? null,
        preMix: json["pre_mix"] ?? null,
        postMix: json["post_mix"] ?? null,
        fertigation: json["fertigation"]==null?null:double.tryParse(json["fertigation"].toString())??0.0,
        value: json["value"] ?? 0,
      );

  Map<String, dynamic> toJson() =>
      {
        "device": device,
        "volume": volume,
        "mode": mode,
        "pre_mix": preMix,
        "post_mix": postMix,
        "fertigation": fertigation,
        "value": value,
      };
}
