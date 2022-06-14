// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:tpm_security_monitoring/helper/getStorage.dart' as constants;
import 'package:tpm_security_monitoring/screen/fragment/components/dialogmessage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
// Future<bool> isOnline() async {
//   var connectivityResult = await (ConnectionStatus.connected)
// }

class _HomeState extends State<Home> {
  GetStorage session = GetStorage();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: size.height * 0.27,
                width: size.width,
                color: const Color(0xFF406C6B),
              )
            ],
          ),
          Positioned(
              top: -80,
              left: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF507677)),
              )),
          Positioned(
              top: 20,
              right: -10,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color:Color(0xFF507677)),
              )),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Selamat Datang",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Guard Management System (Monitoring)",
                            style: TextStyle(color: Colors.white, fontSize: 14))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 4,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // CircleAvatar(
                            //   backgroundImage: NetworkImage(
                            //       'https://hris.tpm-facility.com/assets/images/photo/3528111109770014.jpg'),
                            // ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  GetStorage().read(constants.namaUser),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                // Text(session.read(constants.idSite))
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(
                            color: Colors.black45,
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // GetStorage().remove('id');
                                  GetStorage().erase();
                                  Navigator.pushNamed(context, "/");
                                },
                                child: Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.blue[800]),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.angleRight,
                                size: 16,
                                color: Colors.black26,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                    child: Text(
                      "Menu",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      primary: false,
                      // padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      crossAxisCount: 3,
                      children: <Widget>[
                        MainMenu(
                          icon: FaIcon(
                            FontAwesomeIcons.mapMarked,
                            color: Colors.orange[800],
                            size: 20,
                          ),
                          bgColor: Colors.orange.shade100,
                          title: "Daftar Patroli",
                          onTap: () {
                             Navigator.pushNamed(context, '/patroli');
                          },
                        ),
                        MainMenu(
                          icon: FaIcon(
                            FontAwesomeIcons.recycle,
                            color: Colors.redAccent[800],
                            size: 20,
                          ),
                          bgColor: Colors.redAccent.shade100,
                          title: "Daftar Absensi",
                          onTap: () {
                            Navigator.pushNamed(context, '/absensi');
                            // Get.to(() => const DaftarAbsensi());
                          },
                        ),
                        MainMenu(
                          icon: FaIcon(
                            FontAwesomeIcons.shoePrints,
                            color: Colors.blue[800],
                            size: 20,
                          ),
                          bgColor: Colors.blue.shade100,
                          title: "Aktivitas",
                          onTap: () {
                            Navigator.pushNamed(context, '/aktifitas');
                            // Get.to(() => const DaftarAktifitas());
                          },
                        ),
                        MainMenu(
                          icon: FaIcon(
                            FontAwesomeIcons.userPlus,
                            color: Colors.blueAccent[800],
                            size: 20,
                          ),
                          bgColor: Colors.blueAccent.shade100,
                          title: "Jumlah Pengunjung",
                          onTap: () {
                            Navigator.pushNamed(context, '/pengunjung');
                            // Get.to(() => const DaftarJumlahPengunjung());
                          },
                        ),
                        MainMenu(
                          icon: FaIcon(
                            FontAwesomeIcons.infoCircle,
                            color: Colors.red[800],
                            size: 20,
                          ),
                          bgColor: Colors.red.shade100,
                          title: "Insiden",
                          onTap: () {
                            Navigator.pushNamed(context, '/DaftarInsiden');
                            // Get.to(() => const DaftarInsiden());
                          },
                        ),
                        MainMenu(
                          icon: FaIcon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.orange[800],
                            size: 20,
                          ),
                          bgColor: Colors.orange.shade100,
                          title: "Total Pengunjung",
                          onTap: () {
                            Navigator.pushNamed(context, '/daftarPengunjung');
                            // Get.to(() => const DaftarJumlahPengunjung());
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: TextButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => const DialogMessage());
                        },
                        onLongPress: () async {
                          try {
                            final result =
                                await InternetAddress.lookup('example.com');
                            if (result.isNotEmpty &&
                                result[0].rawAddress.isNotEmpty) {
                              print('connected');
                            }
                          } on SocketException catch (_) {
                            print('not connected');
                          }
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.comment,
                          size: 16,
                        ),
                        label: const Text('Kritik atau Saran')),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  final FaIcon icon;
  final String title;
  final Color bgColor;
  final void Function() onTap;
  const MainMenu({
    Key? key,
    required this.icon,
    required this.title,
    required this.bgColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
              child: icon,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(color: Colors.black45, fontSize: 12),
              ),
            )
          ],
        ),
        // color: Colors.teal[100],
      ),
    );
  }
}
