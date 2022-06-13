import 'dart:convert';
import 'package:http/http.dart' as http;

class ListAbsenService {
  static Future<List<ListAbsenModel>> get(String param) async {
    try {
      final response = await http.get(Uri.parse(
          "https://gmsnv.mindotek.com/attendance/listabsenmonitoring/"));
      print(response.body);
      if (200 == response.statusCode) {
        final List<ListAbsenModel> data = listAbsenModelFromJson(response.body);
        return data;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}

List<ListAbsenModel> listAbsenModelFromJson(String str) =>
    List<ListAbsenModel>.from(
        json.decode(str).map((x) => ListAbsenModel.fromJson(x)));

String listAbsenModelToJson(List<ListAbsenModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListAbsenModel {
  ListAbsenModel({
    required this.attid,
    required this.currentdatetime,
    required this.attStatus,
    required this.keterangan,
    required this.nik,
    required this.hours,
    required this.name,
  });

  String attid;
  DateTime currentdatetime;
  String attStatus;
  String keterangan;
  String nik;
  String hours;
  String name;

  factory ListAbsenModel.fromJson(Map<String, dynamic> json) => ListAbsenModel(
        attid: json["id_att"],
        currentdatetime: DateTime.parse(json["datetime_in"]),
        attStatus: json["is_in"],
        keterangan: json["lokasi"],
        nik: json["id_user"],
        hours: json["thetime"],
        name: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "attid": attid,
        "currentdatetime": currentdatetime.toIso8601String(),
        "att_status": attStatus,
        "keterangan": keterangan,
        "nik": nik,
        "hours": hours,
        "name": name,
      };
}
