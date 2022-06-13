// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ListVisitorCountService {
  static Future<List<ListVisitorCountModel>> get(String param) async {
    try {
      final response = await http.get(Uri.parse(
          "https://gmsnv.mindotek.com/attendance/countTamumonitoring"));
      print(response.body);
      if (200 == response.statusCode) {
        final List<ListVisitorCountModel> data =
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

List<ListVisitorCountModel> listVisitorCountModelFromJson(String str) =>
    List<ListVisitorCountModel>.from(
        json.decode(str).map((x) => ListVisitorCountModel.fromJson(x)));

String listVisitorCountModelToJson(List<ListVisitorCountModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListVisitorCountModel {
  ListVisitorCountModel({
    required this.vid,
    required this.tamu,
    required this.blok,
    required this.thedate,
    required this.thetime,
    required this.statusKunjungan,
    required this.namaPenjaga,
    required this.perlu,
    required this.keteranganPerlu,
    required this.images,
  });

  String vid;
  String tamu;
  String blok;
  String thedate;
  String thetime;
  String statusKunjungan;
  String namaPenjaga;
  String perlu;
  String keteranganPerlu;
  String images;

  factory ListVisitorCountModel.fromJson(Map<String, dynamic> json) =>
      ListVisitorCountModel(
        vid: json["id_tamu"],
        tamu: json["tamu"],
        thedate: json["tanggal"],
        thetime: json['jam'],
        statusKunjungan: json['status'],
        images: json['images'],
        namaPenjaga: json['nama'],
        blok: json["blok"],
        perlu: json['perlu'],
        keteranganPerlu: json['keterangan_perlu'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "vid": vid,
        "tamu": tamu,
        "blok": blok,
        "tanggal": thedate,
        "jam": thetime,
        "status": statusKunjungan,
        "nama": namaPenjaga,
        "perlu": perlu,
        "keterangan_perlu": keteranganPerlu,
        "images": images,
      };
}
