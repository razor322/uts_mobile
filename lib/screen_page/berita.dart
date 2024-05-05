import 'package:flutter/material.dart';

class Berita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Image.asset('lib/assets/images/LogoDua.png'),  // Ganti dengan URL logo yang sebenarnya
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Cari berita...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onFieldSubmitted: (value) {
                // Tambahkan logika pencarian
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Ganti dengan jumlah artikel berita sebenarnya
              itemBuilder: (context, index) {
                return BeritaListItem(
                  title: 'Minang Tech',
                  subtitle: 'Belajar Minangkabau',
                  imageUrl: 'https://i.imgur.com/623k7z4.png',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BeritaListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const BeritaListItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
