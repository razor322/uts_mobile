// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:uts_mobile2_app/const.dart';
import 'package:uts_mobile2_app/model/model_list_sejarah.dart';
import 'package:uts_mobile2_app/model/model_update_sejarah.dart';
import 'package:uts_mobile2_app/sejarah/list_sejarah.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
// import 'package:uts_mobile_app/models/model_update_Sejarah.dart';

class SejarahEditScreen extends StatefulWidget {
  final Datum? data;
  SejarahEditScreen(this.data, {super.key});

  @override
  State<SejarahEditScreen> createState() => _SejarahEditScreenState();
}

class _SejarahEditScreenState extends State<SejarahEditScreen> {
  TextEditingController upnama = TextEditingController();
  TextEditingController upgambar = TextEditingController();
  TextEditingController upjenisKelamin = TextEditingController();
  TextEditingController updeskripsi = TextEditingController();
  TextEditingController uptglLahir = TextEditingController();
  TextEditingController upasal = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  String? id;
  XFile? _image;

  _pilihGallery() async {
    var image = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _image = image;
    });
  }

  _pilihCamera() async {
    var image = await ImagePicker().pickImage(
        source: ImageSource.camera, maxHeight: 1920.0, maxWidth: 1080.0);
    setState(() {
      _image = image;
    });
  }

  Future<ModelUpdateSejarah?> editSejarah() async {
    try {
      setState(() {
        isLoading = true;
        print(id);
      });
      var stream = http.ByteStream(DelegatingStream.typed(_image!.openRead()));
      var length = await _image!.length();
      var uri = Uri.parse('${url}updatesejarah.php');
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile(
        "gambar",
        stream,
        length,
        filename: path.basename(_image!.path),
      );

      request.fields['id'] = widget.data!.id;
      request.fields['nama'] = upnama.text;
      request.files.add(multipartFile);
      request.fields['tgl_lahir'] = uptglLahir.text;
      request.fields['asal'] = upasal.text;
      request.fields['jenis_kelamin'] = upjenisKelamin.text;
      request.fields['deskripsi'] = updeskripsi.text;

      // Pastikan respons adalah JSON yang valid sebelum mengurai

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        ModelUpdateSejarah data = ModelUpdateSejarah.fromJson(jsonResponse);

        if (data.isSuccess == true) {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${data.message}')));
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => SejarahPage()),
              (route) => false);
        } else {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('${data.message}')));
          });
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        print(e.toString());
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.data?.id;
    upnama = TextEditingController(text: widget.data?.nama);
    upgambar = TextEditingController(text: widget.data?.gambar);
    uptglLahir = TextEditingController(text: widget.data?.tglLahir);
    upasal = TextEditingController(text: widget.data?.asal);
    updeskripsi = TextEditingController(text: widget.data?.deskripsi);
    upjenisKelamin = TextEditingController(text: widget.data?.jenisKelamin);
    ;
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
      width: double.infinity,
      height: 150,
      child: Image.asset('./assets/placeholder.png'),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Sejarah"),
        backgroundColor: Colors.purple.shade200,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // _pilihCamera();
                      _pilihGallery();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 150.0,
                      child: _image == null
                          ? Image.network(
                              '$url/image/${widget.data?.gambar}',
                              fit: BoxFit.fill,
                            )
                          : Image.file(
                              File(_image!.path),
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: upnama,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        labelText: "Nama",
                        hintText: "Nama",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: uptglLahir,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        labelText: "Tanggal Lahir",
                        hintText: "Tanggal Lahir",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: upasal,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        labelText: "Asal",
                        hintText: "Asal",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: upjenisKelamin,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        labelText: "Jenis Kelamin",
                        hintText: "Jenis Kelamin",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: updeskripsi,
                    validator: (val) {
                      return val!.isEmpty ? "Tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        labelText: "Deskripsi",
                        hintText: "Deskripsi",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () async {
                      if (keyForm.currentState?.validate() == true) {
                        await editSejarah(); // Tunggu hingga operasi selesai

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SejarahPage()),
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Silahkan isi data terlebih dahulu"),
                          ),
                        );
                      }
                    },
                    color: Colors.purple.shade400,
                    textColor: Colors.white,
                    height: 45,
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
