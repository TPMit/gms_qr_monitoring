import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../src/model/JumlahPengjunjung.dart';
import 'fragment/components/custombackground.dart';

import 'package:tpm_security_monitoring/helper/getStorage.dart' as constants;

class DaftarJumlahPengunjung extends StatefulWidget {
  const DaftarJumlahPengunjung({Key? key}) : super(key: key);

  @override
  _DaftarJumlahPengunjungState createState() => _DaftarJumlahPengunjungState();
}

class _DaftarJumlahPengunjungState extends State<DaftarJumlahPengunjung> {
  String idsite = GetStorage().read(constants.idSite);
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jumlah Pengunjung'),
      ),
      body: Stack(
        children: [
          const CustomBackground(),
          FutureBuilder<List<ListJumlahVisitorModel>>(
            future: ListJumlahPengunjungService.get(idsite),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return VisitorCountList(visitors: snapshot.data!);
              } else {
                return const Center(
                  child: Text(
                    'Record tidak ditemukan.',
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

class VisitorCountList extends StatelessWidget {
  const VisitorCountList({Key? key, required this.visitors}) : super(key: key);
  final List<ListJumlahVisitorModel> visitors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: visitors.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
              children: [
                Text(
                  visitors[index].total,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Jumlah pengunjung hari ini',
                  style: TextStyle(fontStyle: FontStyle.italic),
                )
              ],
            ),
          );
        });
  }
}
