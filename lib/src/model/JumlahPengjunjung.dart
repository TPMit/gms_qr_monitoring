
// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ListJumlahPengunjungService {
  static Future<List<ListJumlahVisitorModel>> get(String param) async {
    try {
      final response = await http.get(Uri.parse(
          "https://gmsnv.mindotek.com/attendance/countTamumonitor"));
      print(response.body);
      if (200 == response.statusCode) {
        final List<ListJumlahVisitorModel> data =
            listVisitorCountModelFromJson(response.body);
        return data;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

List<ListJumlahVisitorModel> listVisitorCountModelFromJson(String str) =>
    List<ListJumlahVisitorModel>.from(
        json.decode(str).map((x) => ListJumlahVisitorModel.fromJson(x)));

String listVisitorCountModelToJson(List<ListJumlahVisitorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListJumlahVisitorModel {
  ListJumlahVisitorModel({
    required this.total,
  });

  String total;

  factory ListJumlahVisitorModel.fromJson(Map<String, dynamic> json) =>
      ListJumlahVisitorModel(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}
