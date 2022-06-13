import 'package:flutter/material.dart';

class DialogInsidenDetail extends StatelessWidget {
  const DialogInsidenDetail(
      {Key? key,
      required this.image,
      required this.name,
      required this.activity,
      required this.tindakan})
      : super(key: key);
  final String name;
  final String image, activity, tindakan; 
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 20, top: 30, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                "Detail Aktifitas",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Oleh: " + name),
                          const SizedBox(
                            height: 8,
                          ),
                          Text("temuan: " +activity),
                          const SizedBox(
                            height: 8,
                          ),
                          Text("Tindakan: "+tindakan),
                        ],
                      ),
                    ),
                    Image.network(
                      'https://gmsnv.mindotek.com/assets/imagesofgms/accidences/' +
                          image,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
