import '../models/stock_event_model.dart';

/// 랜덤 이벤트 목록
final stockEvents = [
  // 호재 이벤트들
  const StockEventModel(
    id: 'bull_market',
    title: '📈 전체 시장 호황',
    description: '긍정적인 경제 지표 발표로 모든 종목이 상승 중입니다!',
    effect: EventEffect(type: EventEffectType.allUp, value: 0.05),
    probability: 0.02,
    isPositive: true,
  ),
  const StockEventModel(
    id: 'tech_boom',
    title: '💻 AI 혁신 뉴스',
    description: 'AI 기술 혁신 소식으로 기술주들이 급등하고 있습니다!',
    effect: EventEffect(
      type: EventEffectType.sectorUp,
      sectors: ['TECH', 'GAME', 'CLOUD'],
      value: 0.12,
    ),
    probability: 0.025,
    isPositive: true,
  ),
  const StockEventModel(
    id: 'energy_boom',
    title: '⚡ 에너지 대호황',
    description: '신재생 에너지 정책 발표로 에너지 관련 주식이 급등중입니다.',
    effect: EventEffect(
      type: EventEffectType.sectorUp,
      sectors: ['ENERGY'],
      value: 0.15,
    ),
    probability: 0.02,
    isPositive: true,
  ),
  const StockEventModel(
    id: 'food_safety_news',
    title: '🍎 식품 안전성 인증',
    description: '식품업계 안전성 개선 소식으로 식품주가 상승하고 있습니다.',
    effect: EventEffect(
      type: EventEffectType.sectorUp,
      sectors: ['FOOD'],
      value: 0.1,
    ),
    probability: 0.02,
    isPositive: true,
  ),
  const StockEventModel(
    id: 'construction_boom',
    title: '🏗️ 대규모 건설 프로젝트',
    description: '정부 인프라 투자 확대로 건설주들이 강세를 보이고 있습니다.',
    effect: EventEffect(
      type: EventEffectType.sectorUp,
      sectors: ['BUILD'],
      value: 0.13,
    ),
    probability: 0.02,
    isPositive: true,
  ),
  const StockEventModel(
    id: 'dividend_day',
    title: '💰 배당금 지급일',
    description: '보유 종목에서 배당금을 지급합니다!',
    effect: EventEffect(
      type: EventEffectType.dividend,
      value: 0.03,
      duration: 0,
    ),
    probability: 0.03,
    isPositive: true,
  ),
  const StockEventModel(
    id: 'new_ipo',
    title: '🆕 신규 상장',
    description: '새로운 유망 종목이 상장되었습니다!',
    effect: EventEffect(type: EventEffectType.newStock),
    probability: 0.015,
    isPositive: true,
  ),

  // 악재 이벤트들
  const StockEventModel(
    id: 'bear_market',
    title: '📉 전체 시장 폭락',
    description: '경제 불안 요소로 인해 전 종목이 하락하고 있습니다.',
    effect: EventEffect(type: EventEffectType.allDown, value: 0.08),
    probability: 0.02,
    isPositive: false,
  ),
  const StockEventModel(
    id: 'tech_scandal',
    title: '💥 기술주 스캔들',
    description: '대형 기술기업 논란으로 기술주들이 급락하고 있습니다.',
    effect: EventEffect(
      type: EventEffectType.sectorDown,
      sectors: ['TECH', 'GAME', 'CLOUD'],
      value: 0.1,
    ),
    probability: 0.025,
    isPositive: false,
  ),
  const StockEventModel(
    id: 'energy_crisis',
    title: '⚫ 에너지 공급 차질',
    description: '원자재 공급 문제로 에너지주가 큰 타격을 받고 있습니다.',
    effect: EventEffect(
      type: EventEffectType.sectorDown,
      sectors: ['ENERGY'],
      value: 0.12,
    ),
    probability: 0.02,
    isPositive: false,
  ),
  const StockEventModel(
    id: 'food_contamination',
    title: '🚫 식품 오염 사고',
    description: '식품 안전 문제가 불거지면서 관련 업체들이 급락중입니다.',
    effect: EventEffect(
      type: EventEffectType.sectorDown,
      sectors: ['FOOD'],
      value: 0.14,
    ),
    probability: 0.02,
    isPositive: false,
  ),
  const StockEventModel(
    id: 'construction_halt',
    title: '🚧 건설 규제 강화',
    description: '부동산 규제 정책 발표로 건설주들이 하락하고 있습니다.',
    effect: EventEffect(
      type: EventEffectType.sectorDown,
      sectors: ['BUILD'],
      value: 0.11,
    ),
    probability: 0.02,
    isPositive: false,
  ),
  const StockEventModel(
    id: 'interest_hike',
    title: '📊 금리 인상 우려',
    description: '중앙은행 금리 인상 시사로 전반적인 투자심리가 위축되고 있습니다.',
    effect: EventEffect(type: EventEffectType.allDown, value: 0.06),
    probability: 0.025,
    isPositive: false,
  ),
  const StockEventModel(
    id: 'market_manipulation',
    title: '⚠️ 시세 조작 의혹',
    description: '일부 종목의 시세 조작 의혹으로 시장 신뢰도가 하락하고 있습니다.',
    effect: EventEffect(type: EventEffectType.randomCrash, value: 0.2),
    probability: 0.015,
    isPositive: false,
  ),
];
