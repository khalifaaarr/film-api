import 'package:film/BottomBar.dart';
import 'package:flutter/material.dart';

class FilmDetailPage extends StatelessWidget {
  final Map<String, dynamic> film;

  const FilmDetailPage({Key? key, required this.film}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(film['title']), // Menampilkan judul film di AppBar
        backgroundColor: Colors.blueGrey, // Ubah warna AppBar sesuai keinginan
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg2.jpg'), // Ganti dengan path gambar yang ingin digunakan
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300, // Ubah tinggi gambar sesuai kebutuhan
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        film['imagePath'], // Menampilkan gambar film di atas background
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Rating: ${film['rating']}', // Menampilkan rating film
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    film['description'], // Menampilkan deskripsi film
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
