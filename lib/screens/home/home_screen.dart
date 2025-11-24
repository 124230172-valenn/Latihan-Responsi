import 'package:flutter/material.dart';
import '../../models/amiibo.dart';
import '../../services/api_service.dart';
import '../../services/favorite_service.dart';
import '../../widgets/amiibo_list_item.dart';
import '../detail/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Amiibo>> futureAmiibo;
  List<String> favoriteHeads = [];

  @override
  void initState() {
    super.initState();
    futureAmiibo = ApiService.getAllAmiibo();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favs = await FavoriteService.getFavorites();
    setState(() {
      favoriteHeads = favs.map((e) => e.head).toList();
    });
  }

  Future<void> _toggleFavorite(Amiibo item) async {
    if (favoriteHeads.contains(item.head)) {
      await FavoriteService.removeFavorite(item.head);
    } else {
      await FavoriteService.addFavorite(item);
    }
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Nintendo Amiibo List",
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: FutureBuilder<List<Amiibo>>(
        future: futureAmiibo,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 45,
                width: 45,
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final data = snapshot.data ?? [];

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              final isFav = favoriteHeads.contains(item.head);

              return AmiiboListItem(
                amiibo: item,
                isFavorite: isFav,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(head: item.head),
                    ),
                  );
                },
                onFavoriteTap: () => _toggleFavorite(item),
              );
            },
          );
        },
      ),
    );
  }
}
