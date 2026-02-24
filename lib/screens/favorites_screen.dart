import 'package:flutter/material.dart';
import '../services/favorite_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<String> favs = [];

  @override
  void initState() {
    super.initState();
    loadFavs();
  }

  void loadFavs() async {
    favs = await FavoriteService.getFavorites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favs.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
        itemCount: favs.length,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.favorite, color: Colors.red),
          title: Text(favs[i]),
        ),
      ),
    );
  }
}