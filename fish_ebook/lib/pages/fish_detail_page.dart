import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/fish.dart';
import '../models/bookmark_model.dart';

class FishDetailPage extends StatelessWidget {
  final Fish fish;
  const FishDetailPage({Key? key, required this.fish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookmarks = context.watch<BookmarkModel>();
    final isFav = bookmarks.isFavorite(fish.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(fish.nameZh),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () => bookmarks.toggleFavorite(fish.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(fish.imageAsset, width: double.infinity, height: 250, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(fish.nameZh, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(fish.nameEn, style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                      const SizedBox(height: 8),
                      Text('Habitat: ${fish.habitat}'),
                      const SizedBox(height: 8),
                      Text(fish.description),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}