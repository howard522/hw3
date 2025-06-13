import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/bookmark_model.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await BookmarkModel.initPrefs();
  runApp(
    ChangeNotifierProvider(
      create: (_) => BookmarkModel(prefs),
      child: const FishApp(),
    ),
  );
}

class FishApp extends StatelessWidget {
  const FishApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fish eBook',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}