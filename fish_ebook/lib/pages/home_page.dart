import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/audio_service.dart';
import 'fish_list_page.dart';
import 'fish_grid_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _audioService = AudioService();
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _audioService.init();
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    setState(() {
      if (_isPlaying) _audioService.pause();
      else _audioService.play();
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
          bottom: const TabBar(tabs: [Tab(text: 'List'), Tab(text: 'Grid')]),
        ),
        body: const TabBarView(children: [FishListPage(), FishGridPage()]),
      ),
    );
  }
}