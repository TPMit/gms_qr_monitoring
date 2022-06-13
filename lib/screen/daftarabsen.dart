
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


import '../src/model/daftarabsenmodel.dart';
import 'fragment/components/custombackground.dart';

import 'package:tpm_security_monitoring/helper/getStorage.dart' as constants;

class DaftarAbsensi extends StatefulWidget {
  const DaftarAbsensi({Key? key}) : super(key: key);

  @override
  _DaftarAbsensiState createState() => _DaftarAbsensiState();
}

class _DaftarAbsensiState extends State<DaftarAbsensi> {
  String idsite = GetStorage().read(constants.idSite);
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Absensi Hari Ini'),
      ),
      body: Stack(
        children: [
          const CustomBackground(),
          FutureBuilder<List<ListAbsenModel>>(
            future: ListAbsenService.get(idsite),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return AbsenList(listAbsen: snapshot.data!);
              } else {
                return const Center(
                  child: Text(
                    "Belum ada absensi",
                    style: TextStyle(color: Colors.white38),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class AbsenList extends StatelessWidget {
  const AbsenList({Key? key, required this.listAbsen}) : super(key: key);
  final List<ListAbsenModel> listAbsen;

  @override
  Widget build(BuildContext context) {
    List statusColor = [
      Colors.blue,
      Colors.blue[600],
      Colors.orange[800],
      Colors.blueGrey[700],
      Colors.lime[800],
      Colors.yellow[900],
      Colors.lightBlue[200],
      Colors.red[300],
      Colors.blueGrey[400],
      Colors.indigo[300],
      Colors.cyan[600],
      Colors.red,
      Colors.cyan[900],
      Colors.blueGrey[600],
      Colors.blueGrey[900],
      Colors.teal[900],
      Colors.blueGrey,
      Colors.blueGrey,
      Colors.blueGrey
    ];
    return ListView.builder(
        itemCount: listAbsen.length,
        itemBuilder: (context, index) {
          ListAbsenModel data = listAbsen[index];
          return Container(
            height: 90,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Chip(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                              backgroundColor:
                                  statusColor[int.parse(data.attStatus)],
                              label: Text(
                                data.keterangan,
                                style: const TextStyle(fontSize: 10, color: Colors.white),
                              )),
                          Chip(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),
                              backgroundColor: Colors.grey,
                              label: Text(
                                data.hours + ' jam',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ))
                        ],
                      ),
                      data.attStatus == '0'
                          ? const Text('sudah absen keluar',style: TextStyle(color: Colors.green),)
                          : const Text('baru absen pagi',
                              style: TextStyle(color: Colors.red),
                            )
                    ],
                  ),
                  
                ],
              ),
            ),
          );
        });
  }
}
