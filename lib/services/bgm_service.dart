import 'package:audioplayers/audioplayers.dart';

/// BGM 타입
enum BgmType {
  home('audio/bgm.mp3'),
  stock('audio/stock_bgm.mp3');

  final String path;
  const BgmType(this.path);
}

/// BGM 서비스 - 배경음악 관리
class BgmService {
  static final BgmService _instance = BgmService._internal();
  factory BgmService() => _instance;
  BgmService._internal();

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  BgmType? _currentBgm;

  bool get isPlaying => _isPlaying;
  BgmType? get currentBgm => _currentBgm;

  /// BGM 재생 (기본: home)
  Future<void> play([BgmType type = BgmType.home]) async {
    print('[BgmService] play(${type.name}) 호출됨, isPlaying: $_isPlaying, current: ${_currentBgm?.name}');

    // 같은 BGM이 이미 재생 중이면 무시
    if (_isPlaying && _currentBgm == type) return;

    // 다른 BGM이 재생 중이면 먼저 정지
    if (_isPlaying) {
      await _audioPlayer.stop();
    }

    try {
      print('[BgmService] BGM 재생 시도: ${type.path}');
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.play(AssetSource(type.path));
      _isPlaying = true;
      _currentBgm = type;
      print('[BgmService] BGM 재생 성공!');
    } catch (e) {
      print('[BgmService] BGM 재생 실패: $e');
    }
  }

  /// BGM 정지
  Future<void> stop() async {
    if (!_isPlaying) return;

    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      _currentBgm = null;
    } catch (e) {
      print('[BgmService] BGM 정지 실패: $e');
    }
  }

  /// BGM 일시정지
  Future<void> pause() async {
    if (!_isPlaying) return;

    try {
      await _audioPlayer.pause();
      _isPlaying = false;
    } catch (e) {
      print('[BgmService] BGM 일시정지 실패: $e');
    }
  }

  /// BGM 재개
  Future<void> resume() async {
    if (_isPlaying) return;

    try {
      await _audioPlayer.resume();
      _isPlaying = true;
    } catch (e) {
      print('[BgmService] BGM 재개 실패: $e');
    }
  }

  /// 볼륨 설정 (0.0 ~ 1.0)
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  /// 리소스 해제
  void dispose() {
    _audioPlayer.dispose();
  }
}
