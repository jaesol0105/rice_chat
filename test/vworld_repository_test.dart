import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:rice_chat/data/repository/vworld_repository.dart';

void main() {
  // 실제 Dio 주입해서 테스트
  final repo = VworldRepository(client: Dio(BaseOptions(validateStatus: (status) => true)));

  test('VworldRepository 테스트', () async {
    final result = await repo.findByLatLng(35.2210076, 129.0826365);
    print('결과1: $result');
    expect(result.isEmpty, false);

    // 결과 없어야 함
    final result2 = await repo.findByLatLng(32.2210076, 129.0826365);
    print('결과2: $result2');
    expect(result2.isEmpty, true);
  });
}
