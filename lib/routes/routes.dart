import 'package:flutter/material.dart';
import 'package:tpm_security_monitoring/screen/daftarabsen.dart';
import 'package:tpm_security_monitoring/screen/daftaraktifitas.dart';
import 'package:tpm_security_monitoring/screen/daftarinsiden.dart';
import 'package:tpm_security_monitoring/screen/home.dart';

import '../screen/daftarPengunjung.dart';
import '../screen/daftarjumlahpengunjung.dart';
import '../screen/daftarpatroli.dart';
import '../screen/login.dart';

final routes = {
  '/': (BuildContext context) => const Login(),
  '/home': (BuildContext context) => const Home(),
  '/patroli': (BuildContext context) => const DaftarPatroli(),
  '/absensi': (BuildContext context) => const DaftarAbsensi(),
  '/aktifitas': (BuildContext context) => const DaftarAktifitas(),
  '/pengunjung': (BuildContext context) => const DaftarPengunjung(),
  '/daftarPengunjung' : (BuildContext context) => const DaftarJumlahPengunjung(),
  '/DaftarInsiden' : (BuildContext context) => const DaftarInsiden(),
};
