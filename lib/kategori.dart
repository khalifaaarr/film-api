import 'package:flutter/material.dart';
import 'package:film/BottomBar.dart';


class Kategori extends StatelessWidget {
  final List<Film> films = [
    Film('images/film1.jpg', 'QODRAT', 4.5),
    Film('images/film2.jpg', 'CEK TOKO SEBELAH', 4.0),
    Film('images/film3.jpg', '5CM', 4.2),
    Film('images/film4.jpg', 'THE RAID 2', 4.7),
    Film('images/film5.jpg', 'YOUR NAME', 3.9),
    Film('images/film6.jpg', 'Tuyul', 4.1),
    Film('images/film7.jpg', 'Kingsman', 4.8),
    Film('images/film8.jpg', 'Maze Runner', 4.3),
    Film('images/film9.jpg', 'Sisi Lain', 3.8),
    Film('images/film10.jpg', 'Warkop DKI', 5.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                color: Colors.transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 24,
                            child: Icon(
                              Icons.play_circle_outline,
                              color: Colors.blue,
                              size: 36,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Asupan Film',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Daftar Film',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: films.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                    },
                    leading: Image.asset(
                      films[index].imagePath,
                      width: 100,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                    title: Text(films[index].title),
                    subtitle: Text('Rating: ${films[index].rating}'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class Film {
  final String imagePath;
  final String title;
  final double rating;

  Film(this.imagePath, this.title, this.rating);
}
