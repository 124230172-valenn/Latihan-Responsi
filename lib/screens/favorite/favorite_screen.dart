import 'package:flutter/material.dart';
import '../../models/amiibo.dart';
import '../../services/favorite_service.dart';
import '../detail/detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Amiibo> favoriteList = [];

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favs = await FavoriteService.getFavorites();
    setState(() {
      favoriteList = favs;
    });
  }

  Future<void> deleteItem(String head) async {
    await FavoriteService.removeFavorite(head);
    await loadFavorites();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Item removed from favorites"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
      ),
      body: favoriteList.isEmpty
          ? const Center(child: Text("No favorites yet"))
          : ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                final item = favoriteList[index];

                return Dismissible(
                  key: Key(item.head),
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) => deleteItem(item.head),

                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item.image,
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      item.name,
                    ),
                    subtitle: Text(item.gameSeries),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(head: item.head),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
