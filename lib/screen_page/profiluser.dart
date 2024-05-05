import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:uts_mobile2_app/screen_page/editprofile.dart';
import 'package:uts_mobile2_app/screen_page/login.dart';

class ProfilUser extends StatefulWidget {
  @override
  State<ProfilUser> createState() => _ProfilUserState();
}

class _ProfilUserState extends State<ProfilUser> {
  String? id, username, email;

  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    updateProfile();
  }

  void updateProfile() {
    getSession(); // Panggil kembali fungsi getSession untuk memperbarui data
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      email = pref.getString("email") ?? '';
      print('id $id');
      print('username $username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Stack for profile picture and edit icon
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 80.0,
                  //    backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                // Button to change profile picture
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

            // User information
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "$username",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "$email",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Space between user information and buttons
            SizedBox(height: 16.0),

            // Edit profile button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white), // Background color green
                foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.green), // Text color white
              ),
              child: Text('Edit Profile'),
            ),

            // Space between Edit Profile and Log out buttons
            Container(
              width: 200, // Lebar tombol
              height: 40, // Tinggi tombol
              margin: EdgeInsets.all(130), // Memberi margin di sekitar tombol
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()), // Log out userr
                  ); // Add your logout logic here
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green), // Background color
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Text color
                ),
                child: Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
