import 'package:flutter/material.dart';
import 'package:film/BottomBar.dart';
import 'package:film/FilmDetailPage.dart';
import 'package:film/apifetch_service.dart';

class Search extends StatefulWidget {
  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<Search> {
  final FilmApi _filmApi = FilmApi();
  late Future<List<Map<String, dynamic>>> _filmData;

  @override
  void initState() {
    super.initState();
    _filmData = _filmApi.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Film Search'),
        backgroundColor: Colors.blueGrey, // Ubah warna AppBar sesuai keinginan
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg2.jpg'), // Ganti dengan path gambar yang ingin digunakan
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _filmData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching data'));
            } else {
              List<Map<String, dynamic>> filmList = snapshot.data ?? [];
              return ListView.builder(
                itemCount: filmList.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> film = filmList[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      leading: Image.network(
                          film['imagePath']), // Sesuaikan dengan key imagePath dari API
                      title:
                      Text(film['title']), // Sesuaikan dengan key title dari API
                      subtitle: Text('Rating: ${film['rating']}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FilmDetailPage(film: film), // Kirim data film ke halaman detail
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
