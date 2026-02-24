import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchPokemonList() async {
    final res = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=50"),
    );
    return json.decode(res.body)['results'];
  }

  Future<Map<String, dynamic>> fetchPokemonDetail(String url) async {
    final res = await http.get(Uri.parse(url));
    return json.decode(res.body);
  }
}