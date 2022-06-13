import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DialogMessage extends StatefulWidget {
  @override
  DialogMessageState createState() => DialogMessageState();
}

class DialogMessageState extends State<DialogMessage> {
  final session = GetStorage();
  late String message;
  Future _postMessage() async {
    Map<String, dynamic> content = <String, dynamic>{};
    content['iduser'] = session.read('id');
    content['message'] = message;
    print(content);
    return await http.post(
      Uri.https('hris.tpm-facility.com', 'attendance/kritiksaran'),
      body: content,
    );
  }

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
          padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Kritik atau Saran",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                    onChanged: (value) {
                      message = value;
                    },
                    autocorrect: false,
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: new InputDecoration.collapsed(
                      hintText: "",
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 15),
                child: Align(
                  child: Text(
                    "Terima kasih atas kritik dan sarannya.",
                    style: TextStyle(color: Colors.black45, fontSize: 12),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    _postMessage();
                    Get.back();
                    Get.snackbar("Berhasil!", "Pesan anda terkirim");
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
