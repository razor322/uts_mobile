// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:uts_mobile2_app/const.dart';
import 'package:uts_mobile2_app/model/model_list_sejarah.dart';

class PageDetailSejarah extends StatelessWidget {
  final Datum? data;
  const PageDetailSejarah(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 170, 146),
        title: Text(
          "Detail Pahlawan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                './assets/gambar.png',
                width: 100,
                height: 100,
                // fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '$url/image/${data?.gambar}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.nama ?? "",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Asal : ${data?.asal}",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                Text(
                    "Tanggal lahir : ${DateFormat('dd MMMM yyyy').format(DateTime.parse(data?.tglLahir ?? ""))}",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
                Text("Jenis Kelamin : ${data?.jenisKelamin}",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 14)),
              ],
            ),
            trailing: Icon(
              Icons.star,
              color: Colors.orange,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.deskripsi ?? "",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
