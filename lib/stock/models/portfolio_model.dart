import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_model.freezed.dart';

/// 포트폴리오 항목 모델
@freezed
sealed class PortfolioItem with _$PortfolioItem {
  const factory PortfolioItem({
    required String symbol,
    required int quantity,
    required double avgPrice,
  }) = _PortfolioItem;
}
