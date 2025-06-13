import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:just_audio/just_audio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (_) => BookmarkModel(prefs),
      child: const FishApp(),
    ),
  );
}

class BookmarkModel extends ChangeNotifier {
  static const _key = 'favorites';
  final SharedPreferences _prefs;
  final Set<int> _favorites;

  BookmarkModel(this._prefs)
      : _favorites = (_prefs.getStringList(_key) ?? []).map(int.parse).toSet();

  bool isFavorite(int id) => _favorites.contains(id);

  void toggleFavorite(int id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    _prefs.setStringList(
      _key,
      _favorites.map((i) => i.toString()).toList(),
    );
    notifyListeners();
  }
}

class Fish {
  final int id;
  final String nameZh;
  final String nameEn;
  final String habitat;
  final String description;
  final String imageAsset;

  const Fish({
    required this.id,
    required this.nameZh,
    required this.nameEn,
    required this.habitat,
    required this.description,
    required this.imageAsset,
  });
}

const List<Fish> fishList = [
  Fish(
    id: 1,
    nameZh: '小丑魚',
    nameEn: 'Clownfish (Amphiprioninae)',
    habitat: '熱帶珊瑚礁',
    description: '以其鮮豔的橘白相間條紋聞名，與海葵共生。',
    imageAsset: 'assets/images/clownfish.jfif',
  ),
  Fish(
    id: 2,
    nameZh: '藍刺尾魚',
    nameEn: 'Blue Tang (Paracanthurus hepatus)',
    habitat: '印度-太平洋珊瑚礁',
    description: '又稱「多莉魚」，體型扁平，鮮藍色帶黑邊。',
    imageAsset: 'assets/images/blue_tang.jfif',
  ),
  Fish(
    id: 3,
    nameZh: '海洋天使魚',
    nameEn: 'Angelfish (Pomacanthidae)',
    habitat: '熱帶淺海',
    description: '體色絢麗，多樣化斑紋，常見於水族箱。',
    imageAsset: 'assets/images/angelfish.jfif',
  ),
  Fish(
    id: 4,
    nameZh: '孔雀魚',
    nameEn: 'Guppy (Poecilia reticulata)',
    habitat: '淡水溫帶地區',
    description: '小型淡水魚，繁殖力強，顏色繁多。',
    imageAsset: 'assets/images/guppy.jpg',
  ),
  Fish(
    id: 5,
    nameZh: '鮭魚',
    nameEn: 'Salmon (Salmonidae)',
    habitat: '常見於餐桌',
    description: '肉質鮮美，營養豐富。',
    imageAsset: 'assets/images/salmon.jpg',
  ),
];

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

// HomePage 改為 StatefulWidget 以管理音樂播放
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AudioPlayer _audioPlayer;
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer()..setLoopMode(LoopMode.all);
    // 播放 assets 下的背景音樂，確保 pubspec.yaml 已註冊
    _audioPlayer.setAsset('assets/audio/background.mp3').then((_) {
      _audioPlayer.play();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    setState(() {
      if (_isPlaying) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.play();
      }
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fish eBook'),
          actions: [
            IconButton(
              icon: Icon(_isPlaying ? Icons.music_off : Icons.music_note),
              onPressed: _togglePlayback,
            ),
          ],
          bottom: const TabBar(
            tabs: [Tab(text: 'List'), Tab(text: 'Grid')],
          ),
        ),
        body: const TabBarView(
          children: [FishListPage(), FishGridPage()],
        ),
      ),
    );
  }
}

class FishListPage extends StatelessWidget {
  const FishListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fishList.length,
      itemBuilder: (context, index) {
        final fish = fishList[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FishDetailPage(fish: fish),
                ),
              );
            },
            child: ListTile(
              leading: Image.asset(
                fish.imageAsset,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(fish.nameZh),
              subtitle: Text(fish.habitat),
            ),
          ),
        );
      },
    );
  }
}

class FishGridPage extends StatelessWidget {
  const FishGridPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(12),
      childAspectRatio: 3 / 4,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: fishList.map((fish) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FishDetailPage(fish: fish),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    fish.imageAsset,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    fish.nameZh,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

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
            Image.asset(
              fish.imageAsset,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fish.nameZh,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fish.nameEn,
                        style: const TextStyle(
                            fontSize: 16, fontStyle: FontStyle.italic),
                      ),
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
