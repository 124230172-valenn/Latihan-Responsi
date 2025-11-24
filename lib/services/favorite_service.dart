import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/amiibo.dart';

class FavoriteService {
  static const String key = "favorite_amiibo";

  /// Ambil semua favorite dari SharedPreferences
  static Future<List<Amiibo>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(key);

    if (data == null) {
      return [];
    }

    List decoded = jsonDecode(data);
    return decoded.map((e) => Amiibo.fromJson(e)).toList();
  }

  /// Simpan item ke favorite
  static Future<void> addFavorite(Amiibo amiibo) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = await getFavorites();

    // Jangan simpan double
    if (!favs.any((a) => a.head == amiibo.head)) {
      favs.add(amiibo);
      prefs.setString(
        key,
        jsonEncode(favs.map((e) => e.toJson()).toList()),
      );
    }
  }

  /// Hapus item dari favorite
  static Future<void> removeFavorite(String head) async {
    final prefs = await SharedPreferences.getInstance();
    final favs = await getFavorites();

    favs.removeWhere((a) => a.head == head);

    prefs.setString(
      key,
      jsonEncode(favs.map((e) => e.toJson()).toList()),
    );
  }

  /// Cek apakah item sudah difavorite
  static Future<bool> isFavorite(String head) async {
    final favs = await getFavorites();
    return favs.any((a) => a.head == head);
  }
}
