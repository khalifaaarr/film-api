import 'package:flutter/material.dart';
import 'package:film/BottomBar.dart';
import 'package:film/FilmDetailPage.dart';
import 'package:film/apifetch_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<HomeScreen> {
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.movie,
                      size: 30,
                      color: Colors.black, // Ubah warna ikon sesuai kebutuhan
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Asupan Film',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
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
                                film['imagePath'],
                              ),
                              title: Text(film['title']),
                              subtitle: Text('Rating: ${film['rating']}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FilmDetailPage(
                                      film: film,
                                    ),
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
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
