import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer()..setLoopMode(LoopMode.all);

  Future<void> init() async {
    await _player.setAsset('assets/audio/background.mp3');
    play();
  }

  void play() => _player.play();
  void pause() => _player.pause();
  void dispose() => _player.dispose();
}