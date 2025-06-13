import 'package:flutter/material.dart';
import '../models/fish.dart';
import 'fish_detail_page.dart';

class FishGridPage extends StatelessWidget {
  const FishGridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(12),
      childAspectRatio: 3/4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: fishList.map((fish) => Card(
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FishDetailPage(fish: fish)),
          ),
          child: Column(
            children: [
              Expanded(child: Image.asset(fish.imageAsset, fit: BoxFit.cover)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(fish.nameZh, textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }
}