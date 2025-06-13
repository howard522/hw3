import 'package:flutter/material.dart';
import '../models/fish.dart';
import 'fish_detail_page.dart';

class FishListPage extends StatelessWidget {
  const FishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fishList.length,
      itemBuilder: (_, i) {
        final fish = fishList[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FishDetailPage(fish: fish)),
            ),
            child: ListTile(
              leading: Image.asset(fish.imageAsset, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(fish.nameZh),
              subtitle: Text(fish.habitat),
            ),
          ),
        );
      },
    );
  }
}