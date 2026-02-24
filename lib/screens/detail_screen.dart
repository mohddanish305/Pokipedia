import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';

class DetailScreen extends StatefulWidget {
  final String url;
  final String tag;
  final int index;

  const DetailScreen(
      {super.key, required this.url, required this.tag, required this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final api = ApiService();
  Map<String, dynamic>? pokemon;
  bool fav = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    pokemon = await api.fetchPokemonDetail(widget.url);
    fav = await FavoriteService.isFavorite(pokemon!['name']);
    setState(() {});
  }

  Color typeColor(String type) {
    switch (type) {
      case 'fire':
        return const Color(0xFFFB6C6C);
      case 'water':
        return const Color(0xFF77BDFE);
      case 'grass':
        return const Color(0xFF48D0B0);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pokemon == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    final type = pokemon!['types'][0]['type']['name'];

    return Scaffold(
      backgroundColor: typeColor(type),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(fav ? Icons.favorite : Icons.favorite_border),
            onPressed: () async {
              await FavoriteService.toggleFavorite(pokemon!['name']);
              fav = !fav;
              setState(() {});
            },
          )
        ],
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.tag,
            child: Image.network(
              pokemon!['sprites']['front_default'],
              height: 200,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Height: ${pokemon!['height']}"),
                  Text("Weight: ${pokemon!['weight']}"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}