import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uts_mobile2_app/const.dart';
import 'package:uts_mobile2_app/model/model_listbudaya.dart';

class PageDetailBudaya extends StatelessWidget {
  //konstruktor penampung data
  final Datum? data;
  const PageDetailBudaya(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(data!.judul),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                '${url}image/${data?.gambar}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(
              data?.judul ?? "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.blue),
            ),
            trailing: Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              data?.konten ?? "",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
