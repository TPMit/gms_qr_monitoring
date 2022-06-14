// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ListAccidentService {
  static Future<List<ListAccidentModel>> get(String param) async {
    try {
      final response = await http.get(Uri.parse(
          "https://gmsnv.mindotek.com/attendance/listinsidenmonitoring"));
      print(response.body);
      if (200 == response.statusCode) {
        final List<ListAccidentModel> data =
            listAccidentModelFromJson(response.body);
        return data;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}

List<ListAccidentModel> listAccidentModelFromJson(String str) =>
    List<ListAccidentModel>.from(
        json.decode(str).map((x) => ListAccidentModel.fromJson(x)));

String listAccidentModelToJson(List<ListAccidentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListAccidentModel {
  ListAccidentModel({
    required this.arid,
    required this.thetime,
    required this.thedate,
    required this.title,
    required this.idsite,
    required this.relatedfigure,
    required this.figuresremark,
    required this.chronology,
    required this.takenaction,
    required this.images,
    required this.kesimpulan,
    required this.name,
  });

  String arid;
  String thetime;
  String thedate;
  String title;
  String idsite;
  String relatedfigure;
  String figuresremark;
  String chronology;
  String takenaction;
  String images;
  String kesimpulan;
  String name;

  factory ListAccidentModel.fromJson(Map<String, dynamic> json) =>
      ListAccidentModel(
        arid: json["id_incident"],
        thetime: json["waktu"],
        thedate: json["tanggal"],
        title: json["subjek"],
        idsite: json["id_site"],
        relatedfigure: json["nama_pihak"] ?? '',
        figuresremark: json["pihak_terkait"],
        chronology: json["kronologi"],
        takenaction: json["tindakan"],
        images: json["dokumentasi"],
        kesimpulan: json["kesimpulan"],
        name: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "arid": arid,
        "thetime": thetime,
        "thedate": thedate,
        "title": title,
        "idsite": idsite,
        "relatedfigure": relatedfigure,
        "figuresremark": figuresremark,
        "chronology": chronology,
        "takenaction": takenaction,
        "images": images,
        "kesimpulan": kesimpulan,
        "name": name,
      };
}
