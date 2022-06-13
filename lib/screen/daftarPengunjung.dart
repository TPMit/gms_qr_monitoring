// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../src/model/pengunjungmodel.dart';
import 'fragment/components/custombackground.dart';

import 'package:tpm_security_monitoring/helper/getStorage.dart' as constants;

import 'fragment/components/dialogvisitordetail.dart';

class DaftarPengunjung extends StatefulWidget {
  const DaftarPengunjung({Key? key}) : super(key: key);

  @override
  _DaftarPengunjungState createState() => _DaftarPengunjungState();
}

class _DaftarPengunjungState extends State<DaftarPengunjung> {
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
        title: const Text('daftar Pengunjung'),
      ),
      body: Stack(
        children: [
          const CustomBackground(),
          FutureBuilder<List<ListVisitorCountModel>>(
            future: ListVisitorCountService.get(idsite),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return ActivityList(activities: snapshot.data!);
              } else {
                return const Center(
                  child: Text(
                    'Bulum ada aktifitas untuk hari ini.',
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

class ActivityList extends StatelessWidget {
  const ActivityList({Key? key, required this.activities}) : super(key: key);
  final List<ListVisitorCountModel> activities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          ListVisitorCountModel data = activities[index];
          return GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (context) => DialogVisitorDetail(
                      image: data.images,
                      name: data.namaPenjaga,
                      activity: data.perlu,
                    )),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                children: [
                  Text(
                    'tamu nomer: ' + data.tamu,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ditambahkan pada ' +
                        data.thetime +
                        ' oleh ' +
                        data.namaPenjaga,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          );
        });
  }
}
