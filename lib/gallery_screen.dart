import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:uts_mobile2_app/const.dart';
import 'package:uts_mobile2_app/model/model_list_sejarah.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late List<Datum?> listImage = [];

  Future<List<Datum>?> getGambar() async {
    try {
      http.Response res = await http.get(Uri.parse('${url}listsejarah.php'));
      var data = jsonDecode(res.body);
      setState(() {
        for (var i in data['data']) {
          listImage.add(Datum.fromJson(i));
        }
      });
      print('berhasil');
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      });
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getGambar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page Gallery"),
          centerTitle: true,
          // backgroundColor: Colors.green.shade200,
        ),
        body: GridView.builder(
            itemCount: listImage.length,
            padding: EdgeInsets.all(5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              Datum? data = listImage[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 140,
                          child: InstaImageViewer(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${url}image/${data?.gambar}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${data?.nama}, ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blueAccent),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '${data?.deskripsi}, ',
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
