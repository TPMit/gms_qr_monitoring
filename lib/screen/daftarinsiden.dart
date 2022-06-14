import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../src/model/daftarinsidenmodel.dart';
import 'fragment/components/custombackground.dart';

import 'package:tpm_security_monitoring/helper/getStorage.dart' as constants;

import 'fragment/components/dialoginsidendetail.dart';

class DaftarInsiden extends StatefulWidget {
  const DaftarInsiden({Key? key}) : super(key: key);

  @override
  _DaftarInsidenState createState() => _DaftarInsidenState();
}

class _DaftarInsidenState extends State<DaftarInsiden> {
  String idsite = GetStorage().read(constants.idSite);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Insiden Report'),
      ),
      body: Stack(
        children: [
          const CustomBackground(),
          FutureBuilder<List<ListAccidentModel>>(
            future: ListAccidentService.get(idsite),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return AccidentList(accident: snapshot.data!);
              } else {
                return const Center(
                  child: Text(
                    'Bulum ada Insiden Report.',
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

class AccidentList extends StatelessWidget {
  const AccidentList({Key? key, required this.accident}) : super(key: key);
  final List<ListAccidentModel> accident;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: accident.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DialogInsidenDetail(
                      image: accident[index].images,
                      name: accident[index].name,
                      activity: accident[index].title,
                      tindakan: accident[index].takenaction,
                    ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: Column(
                children: [
                  Text(
                    accident[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'ditambahkan pada ' +
                        accident[index].thedate +
                        ' oleh ' +
                        accident[index].name,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  )
                ],
              ),
            ),
          );
        });
  }
}
