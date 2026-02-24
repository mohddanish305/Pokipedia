import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';

Color getPokemonTypeColor(String type) {
  switch (type) {
    case 'grass':
      return const Color(0xFF78C850);
    case 'fire':
      return const Color(0xFFF08030);
    case 'water':
      return const Color(0xFF6890F0);
    case 'electric':
      return const Color(0xFFF8D030);
    case 'poison':
      return const Color(0xFFA040A0);
    default:
      return const Color(0xFF48D0B0);
  }
}

class HomeScreen extends StatefulWidget {
  final String trainerName;
  const HomeScreen({super.key, required this.trainerName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = ApiService();
  List allPokemon = [];
  List filteredPokemon = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    allPokemon = await api.fetchPokemonList();
    filteredPokemon = allPokemon;
    setState(() => isLoading = false);
  }

  void search(String q) {
    filteredPokemon = allPokemon
        .where((e) => e['name'].toLowerCase().contains(q.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Poképedia')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: search,
              decoration: InputDecoration(
                hintText: "Search Pokémon...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredPokemon.length,
              itemBuilder: (_, i) {
                final p = filteredPokemon[i];

                return FutureBuilder<Map<String, dynamic>>(
                  future: api.fetchPokemonDetail(p['url']),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(22),
                        ),
                      );
                    }

                    final pokemon = snapshot.data!;
                    final type =
                    pokemon['types'][0]['type']['name'];
                    final bgColor =
                    getPokemonTypeColor(type);

                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(
                            url: p['url'],
                            tag: p['name'],
                            index: i,
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              bgColor.withOpacity(0.9),
                              bgColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: -20,
                              bottom: -20,
                              child: Opacity(
                                opacity: 0.2,
                                child: Icon(
                                  Icons.catching_pokemon,
                                  size: 120,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p['name'].toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Image.network(
                                      pokemon['sprites']
                                      ['front_default'],
                                      height: 120,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}