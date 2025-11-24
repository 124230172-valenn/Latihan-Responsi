import 'package:flutter/material.dart';
import '../models/amiibo.dart';

class FavoriteListItem extends StatelessWidget {
  final Amiibo amiibo;
  final DismissDirectionCallback onDismissed;

  const FavoriteListItem({
    super.key,
    required this.amiibo,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(amiibo.head),
      direction: DismissDirection.horizontal,
      onDismissed: onDismissed,
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
      child: ListTile(
        leading: Image.network(amiibo.image, width: 50),
        title: Text(amiibo.name),
        subtitle: Text(amiibo.gameSeries),
      ),
    );
  }
}
