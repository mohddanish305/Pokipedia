import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';

class MainNavScreen extends StatefulWidget {
  final String trainerName;
  const MainNavScreen({super.key, required this.trainerName});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(trainerName: widget.trainerName),
      const FavoritesScreen(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (v) => setState(() => index = v),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites"),
        ],
      ),
    );
  }
}