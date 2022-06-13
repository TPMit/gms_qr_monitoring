import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../src/model/daftarcheckpointmodel.dart';
import 'fragment/components/custombackground.dart';

import 'package:tpm_security_monitoring/helper/getStorage.dart' as constants;

class DaftarPatroli extends StatefulWidget {
  const DaftarPatroli({Key? key}) : super(key: key);

  @override
  _DaftarPatroliState createState() => _DaftarPatroliState();
}

class _DaftarPatroliState extends State<DaftarPatroli> {
  String idsite = GetStorage().read(constants.idSite);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Patroli hari ini'),
      ),
      body: Stack(
        children: [
          const CustomBackground(),
          FutureBuilder<List<ListCheckPointModel>>(
            future: ListCheckPointService.get(idsite),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                // return ActivityList(activities: snapshot.data!);
                // return Text("fdsg");
                return PatroliList(patroli: snapshot.data!);
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

class PatroliList extends StatelessWidget {
  const PatroliList({Key? key, required this.patroli}) : super(key: key);

  final List<ListCheckPointModel> patroli;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: patroli.length,
        itemBuilder: (context, index) {
          ListCheckPointModel data = patroli[index];
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 3,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                // data.checkin == '1'
                //     ? FaIcon(
                //         FontAwesomeIcons.solidCheckCircle,
                //         size: 30,
                //         color: Colors.blue[800],
                //       )
                //     : FaIcon(
                //         FontAwesomeIcons.checkCircle,
                //         size: 30,
                //         color: Colors.orange[400],
                //       ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.location,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text("oleh " +
                        data.name +
                        " pada " +
                        DateFormat.Hm().format(data.currentdatetime))
                  ],
                )
              ],
            ),
          );
        });
  }
}
