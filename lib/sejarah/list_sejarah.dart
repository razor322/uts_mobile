// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:uts_mobile2_app/const.dart';
import 'package:uts_mobile2_app/gallery_screen.dart';
import 'package:uts_mobile2_app/model/model_delete_sejarah.dart';
import 'package:uts_mobile2_app/model/model_list_sejarah.dart';
import 'package:uts_mobile2_app/sejarah/detailsejarah.dart';
import 'package:uts_mobile2_app/sejarah/sejarah_create_page.dart';
import 'package:uts_mobile2_app/sejarah/sejarah_edit_page.dart';

class SejarahPage extends StatefulWidget {
  const SejarahPage({super.key});

  @override
  State<SejarahPage> createState() => _SejarahPageState();
}

class _SejarahPageState extends State<SejarahPage> {
  TextEditingController txtcari = TextEditingController();
  bool isCari = false;
  bool isLoading = false;
  late List<Datum> _allSejarah = [];
  late List<Datum> _searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    getSejarah();
    super.initState();
  }

  Future<List<Datum>?> getSejarah() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http.get(Uri.parse('${url}listsejarah.php'));
      List<Datum> data = modelListSejarahFromJson(res.body).data ?? [];
      setState(() {
        _allSejarah = data;
        _searchResult = data;
      });
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
        print(e.toString());
      });
    }
  }

  Future<void> deleteSejarah(int id) async {
    var iduser = id;
    try {
      setState(() {
        isLoading = false;
      });
      http.Response res = await http
          .post(Uri.parse('${url}hapus.php'), body: {"id": iduser.toString()});

      // Periksa apakah permintaan berhasil (status kode 200)
      if (res.statusCode == 200) {
        // Parsing respon dari JSON ke objek ModelDeleteMahasiswa
        ModelDeleteSejarah data = modelDeleteSejarahFromJson(res.body);

        if (data.status == "success") {
          setState(() {
            // Hapus pegawai dari _searchResult berdasarkan ID
            _searchResult.removeWhere((sejarah) => sejarah.id == id.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}')),
            );
          });

          _filterSejarah(txtcari.text);
          setState(() {
            getSejarah();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          print(data.message);
        }
      } else {
        // Menampilkan pesan kesalahan jika permintaan tidak berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus Sejarawan')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print(e);
    }
  }

  void _filterSejarah(String query) {
    List<Datum> filteredSejarah = _allSejarah
        .where((sejarah) =>
            sejarah.nama!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _searchResult = filteredSejarah;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SejarahCreatepage()));
        },
        tooltip: "tambah mahasiswa",
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GalleryScreen()));
              },
              icon: Icon(Icons.info))
        ],
        // title: Text(
        //   "List Pahlawan",
        //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        // ),
        // backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  onChanged: _filterSejarah,
                  controller: txtcari,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.search),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search",
                    hintStyle: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "List Pahlawan",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _searchResult.length,
                        itemBuilder: (context, index) {
                          Datum data = _searchResult[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageDetailSejarah(data),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Card(
                                child: ListTile(
                                  minLeadingWidth: 15,
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.blue.shade200,
                                    child: Icon(
                                      Icons.person,
                                      size: 25,
                                    ),
                                  ),
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (String choice) {
                                      switch (choice) {
                                        case 'hapus':
                                          String idToDelete =
                                              _searchResult[index].id;
                                          if (int.tryParse(idToDelete) !=
                                              null) {
                                            deleteSejarah(
                                                int.parse(idToDelete));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text('ID tidak valid')),
                                            );
                                          }
                                          break;
                                        case 'edit':
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SejarahEditScreen(data),
                                            ),
                                          );
                                          break;
                                        case 'lihat':
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PageDetailSejarah(data),
                                            ),
                                          );
                                          break;
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        value: 'hapus',
                                        child: ListTile(
                                          leading: Icon(Icons.delete,
                                              color: Colors.red),
                                          title: Text('Hapus Data'),
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'edit',
                                        child: ListTile(
                                          leading: Icon(Icons.edit,
                                              color: Colors.yellow),
                                          title: Text('Edit Data'),
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        value: 'lihat',
                                        child: ListTile(
                                          leading: Icon(
                                              Icons.info_outline_rounded,
                                              color: Colors.green),
                                          title: Text('Lihat Data'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Text("${data.nama}"),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data.asal}",
                                      ),
                                      Text(
                                        "${DateFormat('dd MMMM yyyy').format(DateTime.parse(data.tglLahir))}",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
