import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/amiibo.dart';

class ApiService {
  static const String baseUrl = 'https://www.amiiboapi.com/api/amiibo/';

  static Future<List<Amiibo>> getAllAmiibo() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List list = data['amiibo'];

      return list.map((item) => Amiibo.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  static Future<Amiibo> getAmiiboByHead(String head) async {
    final response = await http.get(Uri.parse('$baseUrl?head=$head'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List list = data['amiibo'];

      return Amiibo.fromJson(list[0]);
    } else {
      throw Exception('Gagal memuat detail');
    }
  }
}
