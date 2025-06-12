import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer bgmPlayer = AudioPlayer();

  Future<void> playBackgroundMusic(String asset) async {
    await bgmPlayer.play(UrlSource(asset));
  }

  Future<void> stopBackgroundMusic() async {
    await bgmPlayer.stop();
  }
}
