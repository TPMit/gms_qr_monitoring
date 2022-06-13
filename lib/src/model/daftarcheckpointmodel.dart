import 'dart:convert';
import 'package:http/http.dart' as http;

class ListCheckPointService {
  static Future<List<ListCheckPointModel>> get(String param) async {
    try {
      final response = await http.get(Uri.parse(
          "https://gmsnv.mindotek.com/attendance/listcheckpointmonitoring/"));
      if (200 == response.statusCode) {
        final List<ListCheckPointModel> data =
            listCheckPointModelFromJson(response.body);
        return data;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

List<ListCheckPointModel> listCheckPointModelFromJson(String str) =>
    List<ListCheckPointModel>.from(
        json.decode(str).map((x) => ListCheckPointModel.fromJson(x)));

String listCheckPointModelToJson(List<ListCheckPointModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListCheckPointModel {
  ListCheckPointModel({
    required this.cheId,
    required this.currentdatetime,
    required this.location,
    required this.name,
  });

  String cheId;
  DateTime currentdatetime;
  String location;
  String name;

  factory ListCheckPointModel.fromJson(Map<String, dynamic> json) =>
      ListCheckPointModel(
        cheId: json["id_check"],
        currentdatetime: DateTime.parse(json["updated_at"]),
        location: json["lokasi"],
        name: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id_check": cheId,
        "updated_at": currentdatetime.toIso8601String(),
        "lokasi": location,
        "username": name,
      };
}
