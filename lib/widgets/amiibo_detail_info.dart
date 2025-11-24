import 'package:flutter/material.dart';
import '../models/amiibo.dart';

class AmiiboDetailInfo extends StatelessWidget {
  final Amiibo amiibo;

  const AmiiboDetailInfo({super.key, required this.amiibo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network(amiibo.image, height: 180),
        const SizedBox(height: 16),

        Text(
          amiibo.name,
          style: const TextStyle(fontSize: 22),
        ),
        const SizedBox(height: 8),

        Text("Game Series: ${amiibo.gameSeries}"),
        Text("Amiibo Series: ${amiibo.amiiboSeries}"),
        Text("Character: ${amiibo.character}"),
        Text("Type: ${amiibo.type}"),
        const SizedBox(height: 16),

        if (amiibo.release != null)
          Column(
            children: [
              const Text("Release Dates:"),
              Text("AU: ${amiibo.release!.au ?? '-'}"),
              Text("EU: ${amiibo.release!.eu ?? '-'}"),
              Text("JP: ${amiibo.release!.jp ?? '-'}"),
              Text("NA: ${amiibo.release!.na ?? '-'}"),
            ],
          ),
      ],
    );
  }
}
