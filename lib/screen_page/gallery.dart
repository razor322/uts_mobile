import 'package:flutter/material.dart';

class Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        children: [
          // Gallery item 1
          GalleryItem(
            image: AssetImage('assets/images/gallery1.jpg'),
            title: 'Tuanku Imam Bonjol',
          ),

          // Gallery item 2
          GalleryItem(
            image: AssetImage('assets/images/gallery2.jpg'),
            title: 'H. Agus Salim',
          ),

          // Gallery item 3
          GalleryItem(
            image: AssetImage('assets/images/gallery3.jpg'),
            title: 'Chatib Sulaiman',
          ),
          GalleryItem(
            image: AssetImage('assets/images/gallery3.jpg'),
            title: 'Chatib Sulaiman',
          ),
          // Add more gallery items here
        ],
      ),
    );
  }
}

class GalleryItem extends StatelessWidget {
  final ImageProvider image;
  final String title;

  const GalleryItem({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
