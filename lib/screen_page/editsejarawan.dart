import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditSejarawan extends StatefulWidget {
  @override
  _EditSejarawanState createState() => _EditSejarawanState();
}

class _EditSejarawanState extends State<EditSejarawan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _asalController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String _jenisKelamin = 'Laki-Laki';
  File? _image;

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Sejarawan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            GestureDetector(
              onTap: getImage,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.grey),
                ),
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Icon(Icons.camera_alt, color: Colors.grey[700]),
                alignment: Alignment.center,
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _tanggalLahirController,
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(new FocusNode());
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1500),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  _tanggalLahirController.text = picked.toIso8601String().split('T').first;
                }
              },
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _asalController,
              decoration: InputDecoration(
                labelText: 'Asal',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: _jenisKelamin,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Jenis Kelamin',
              ),
              items: <String>['Laki-Laki', 'Perempuan'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _jenisKelamin = newValue!;
                });
              },
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _deskripsiController,
              decoration: InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            
            Container(
              width: 200, // Lebar tombol
              height: 40, // Tinggi tombol
              margin: EdgeInsets.all(50), // Memberi margin di sekitar tombol
              child: ElevatedButton(
                onPressed: () {
                  // Log out userr
                  // Add your logout logic here
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green), // Background color
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Text color
                ),
                child: Text('Perbarui'),
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalLahirController.dispose();
    _asalController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }
}
