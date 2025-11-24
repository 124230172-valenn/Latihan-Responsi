import 'package:flutter/material.dart';
import '../../models/amiibo.dart';
import '../../services/api_service.dart';
import '../favorite/favorite_screen.dart';
import '../../services/favorite_Service.dart';

class DetailScreen extends StatefulWidget {
  final String head;

  const DetailScreen({super.key, required this.head});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Amiibo> amiiboFuture;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    amiiboFuture = ApiService.getAmiiboByHead(widget.head);
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    bool fav = await FavoriteService.isFavorite(widget.head);
    setState(() {
      isFavorite = fav;
    });
  }

  Future<void> _toggleFavorite(Amiibo item) async {
    if (isFavorite) {
      await FavoriteService.removeFavorite(item.head);
    } else {
      await FavoriteService.addFavorite(item);
    }
    _checkFavoriteStatus();
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amiibo Details"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () async {
              final amiibo = await amiiboFuture;
              _toggleFavorite(amiibo);
            },
          ),
        ],
      ),

      body: FutureBuilder<Amiibo>(
        future: amiiboFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final amiibo = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GAMBAR
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      amiibo.image,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // NAME
                Text(
                  amiibo.name,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),

                const SizedBox(height: 16),

                // DETAIL LIST
                _detailRow("Amiibo Series", amiibo.amiiboSeries),
                _detailRow("Character", amiibo.character),
                _detailRow("Game Series", amiibo.gameSeries),
                _detailRow("Type", amiibo.type),
                _detailRow("Head", amiibo.head),
                _detailRow("Tail", amiibo.tail),

                const SizedBox(height: 20),

                const Text(
                  "Release Dates",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 8),

                _detailRow("Australia", amiibo.release?.au ?? "-"),
                _detailRow("Europe", amiibo.release?.eu ?? "-"),
                _detailRow("Japan", amiibo.release?.jp ?? "-"),
                _detailRow("North America", amiibo.release?.na ?? "-"),
              ],
            ),
          );
        },
      ),
    );
  }
}
