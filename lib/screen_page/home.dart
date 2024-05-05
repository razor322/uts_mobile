// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:uts_mobile2_app/gallery_screen.dart';
import 'package:uts_mobile2_app/screen_page/listbudaya.dart';
import 'package:uts_mobile2_app/screen_page/profiluser.dart';
import 'package:uts_mobile2_app/sejarah/list_sejarah.dart';

// Pastikan Anda mengimpor UserProfilePage
//import 'news_page.dart';
//import 'employee_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman sebagai widget
  static List<Widget> _widgetOptions = <Widget>[
    PageListBudaya(),
    GalleryScreen(),
    SejarahPage(),
    ProfilUser(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'list pahlawan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
