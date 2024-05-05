import 'package:flutter/material.dart';

class ListPahlawan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pahlawan'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Pahlawan...',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Logika pencarian dapat diterapkan di sini
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,  // Update jumlah pahlawan yang sesungguhnya
              itemBuilder: (context, index) {
                return HeroListItem(
                  name: 'Tuanku Imam Bonjol',
                  subtitle: 'Pahlawan Indonesia',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HeroListItem extends StatelessWidget {
  final String name;
  final String subtitle;

  const HeroListItem({
    Key? key,
    required this.name,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]),  // Inisial nama
      ),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,  // Pastikan Row tidak memenuhi lebar maksimal
        children: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              // Logika untuk menghapus item dari daftar
            },
          ),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.green),
            onPressed: () {
              // Logika untuk mengedit informasi pahlawan
            },
          ),
          IconButton(
            icon: Icon(Icons.info, color: Colors.blue),
            onPressed: () {
              // Logika untuk menampilkan informasi lebih lanjut
            },
          ),
        ],
      ),
    );
  }
}
