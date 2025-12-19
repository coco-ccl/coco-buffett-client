import 'package:flame/components.dart';

/// 모든 빌딩 컴포넌트의 기반이 되는 추상 클래스
abstract class Building extends PositionComponent {
  final double buildingScale;

  Building({
    required Vector2 position,
    required double width,
    required double height,
    required this.buildingScale,
  }) : super(
          position: position,
          size: Vector2(width, height) * buildingScale,
        ) {
    // 기준점을 하단 좌측으로 설정하여 배치를 직관적으로 만듦
    anchor = Anchor.bottomLeft;
  }
}
