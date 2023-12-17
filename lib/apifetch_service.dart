import 'dart:convert';
import 'package:http/http.dart';

class FilmApi {
  Future<List<Map<String, dynamic>>> getData() async {
    try {
      Response response = await get(Uri.parse(
          "https://film-app-5c561-default-rtdb.firebaseio.com/film.json"));

      if (response.statusCode == 200) {
        dynamic dataFetchRaw = jsonDecode(response.body);

        if (dataFetchRaw is List) {
          return List<Map<String, dynamic>>.from(dataFetchRaw);
        } else if (dataFetchRaw is Map) {
          List<Map<String, dynamic>> resultList = [];
          for (var entry in dataFetchRaw.entries) {
            if (entry.value is List) {
              resultList.addAll(List<Map<String, dynamic>>.from(entry.value));
            } else if (entry.value is Map<String, dynamic>) {
              // Check for null values in 'title' and 'imagePath'
              if (entry.value['title'] != null && entry.value['imagePath'] != null) {
                resultList.add(entry.value);
              }
            }
          }
          return resultList;
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Error fetching data: $e');
    }
  }
}
