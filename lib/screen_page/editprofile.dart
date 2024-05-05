import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uts_mobile2_app/const.dart';
import 'package:uts_mobile2_app/model/model_updateUser.dart';
import 'package:uts_mobile2_app/screen_page/home.dart';
import 'package:uts_mobile2_app/utils/cek_session.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _usernameController = TextEditingController();
  String? id, username, email;
  TextEditingController txtusername = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      email = pref.getString("email") ?? '';
      print("id $id");
      print("id $username");
    });
  }

  Future<ModelUpdateUser?> editUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res =
          await http.post(Uri.parse('${url}updateUser.php'), body: {
        "id_user": '$id',
        "username": _usernameController.text,
      });
      ModelUpdateUser data = modelUpdateUserFromJson(res.body);
      if (data.value == 1) {
        setState(() {
          isLoading = false;
          session.saveSession(
            data.value ?? 0,
            data.idUser ?? "",
            data.username ?? "",
            email ?? "",
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      } else if (data.value == 0) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    print(id);
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                // Stack for profile picture and edit icon
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 80.0,
                      // backgroundImage: AssetImage('assets/images/logo1.png'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.black),
                        onPressed: () {
                          // Logic to change profile picture
                          // This might include showing a dialog or navigating to a new screen
                        },
                      ),
                    ),
                  ],
                ),

                // Space between profile picture and user information
                SizedBox(height: 24.0),

                // Username Edit Form
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),

                // Space between user information and buttons
                SizedBox(height: 16.0),

                // Update Button
                Container(
                  width: 200, // Lebar tombol
                  height: 40, // Tinggi tombol
                  margin:
                      EdgeInsets.all(130), // Memberi margin di sekitar tombol
                  child: ElevatedButton(
                    onPressed: () {
                      if (keyForm.currentState?.validate() == true) {
                        setState(() {
                          editUser();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("silahkan isi data terlebih dahulu")));
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green), // Background color
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Text color
                    ),
                    child: Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
