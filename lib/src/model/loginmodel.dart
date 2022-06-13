import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<AdminAuthModel?> fetchData(
      String email, String password) async {
    final response = await http.post(
        Uri.parse('https://hris.tpm-facility.com/rest/admin_auth'),
        body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return AdminAuthModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

class AdminAuthModel {
  AdminAuthModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.idRole,
    required this.idSite,
    required this.idArea,
    required this.adminAuthModelNew,
    required this.siteId,
    required this.site,
  });

  String id;
  String email;
  String password;
  String name;
  String idRole;
  String idSite;
  String idArea;
  String adminAuthModelNew;
  String siteId;
  String site;

  factory AdminAuthModel.fromJson(Map<String, dynamic> json) => AdminAuthModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        idRole: json["id_role"],
        idSite: json["id_site"],
        idArea: json["id_area"],
        adminAuthModelNew: json["new"],
        siteId: json["site_id"],
        site: json["site"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "id_role": idRole,
        "id_site": idSite,
        "id_area": idArea,
        "new": adminAuthModelNew,
        "site_id": siteId,
        "site": site,
      };
}
