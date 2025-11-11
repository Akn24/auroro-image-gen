import 'dart:convert';

GeneratedImageModel generatedImageModelFromJson(String str) =>
    GeneratedImageModel.fromJson(json.decode(str));

String generatedImageModelToJson(GeneratedImageModel data) =>
    json.encode(data.toJson());

class GeneratedImageModel {
  String url;

  GeneratedImageModel({
    required this.url,
  });

  factory GeneratedImageModel.fromJson(Map<String, dynamic> json) =>
      GeneratedImageModel(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
