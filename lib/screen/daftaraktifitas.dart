import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../src/model/daftaraktifitasmodel.dart';
import 'fragment/components/custombackground.dart';
import 'fragment/components/dialogactivitydetail.dart';

import 'package:tpm_security_monitoring/helper/getStorage.dart' as constants;

class DaftarAktifitas extends StatefulWidget {
  const DaftarAktifitas({Key? key}) : super(key: key);

  @override
  _DaftarAktifitasState createState() => _DaftarAktifitasState();
}

class _DaftarAktifitasState extends State<DaftarAktifitas> {
  String idsite = GetStorage().read(constants.idSite);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Aktifitas Hari Ini'),
      ),
      body: Stack(
        children: [
          const CustomBackground(),
          FutureBuilder<List<AcitivityModel>>(
            future: ActivityServices.getData(idsite),
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
  final List<AcitivityModel> activities;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          AcitivityModel data = activities[index];
          return GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (context) => DialogActivityDetail(
                      image: data.images,
                      name: data.name,
                      activity: data.activity,
                    )),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                children: [
                  Text(
                    data.activity,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ditambahkan pada ' +
                        DateFormat('kk:mm').format(data.dateTime) +
                        ' oleh ' +
                        data.name,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          );
        });
  }
}
