import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const key = "favorites";

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  static Future<void> toggleFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favs = prefs.getStringList(key) ?? [];

    if (favs.contains(name)) {
      favs.remove(name);
    } else {
      favs.add(name);
    }

    await prefs.setStringList(key, favs);
  }

  static Future<bool> isFavorite(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(key) ?? []).contains(name);
  }
}