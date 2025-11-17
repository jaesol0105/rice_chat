import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vworld_repository.g.dart';

class VworldRepository {
  VworldRepository({required this.client});
  final Dio client;

  /// 텍스트로 읍면동 검색
  Future<List<String>> findByName(String query) async {
    try {
      final response = await client.get(
        'https://api.vworld.kr/req/search',
        queryParameters: {
          'request': 'search',
          'key': '6B8D2367-BC2E-352D-AA02-963D026463A3',
          'query': query,
          'type': 'DISTRICT',
          'category': 'L4',
        },
      );

      // Response > result > items >> title
      if (response.statusCode == 200 && response.data['response']['status'] == 'OK') {
        final items = response.data['response']['result']['items'];
        final itemList = List.from(items);
        final iterable = itemList.map((item) {
          return '${item['title']}';
        });
        return iterable.toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// 위도경도로 읍면동 검색
  Future<List<String>> findByLatLng(double lat, double lng) async {
    try {
      final response = await client.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': '6B8D2367-BC2E-352D-AA02-963D026463A3',
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT($lng $lat)',
          'geometry': false,
          'size': 100,
        },
      );

      // Response > result > featureCollection > features >> properties > full_nm
      if (response.statusCode == 200 && response.data['response']['status'] == 'OK') {
        final features = response.data['response']['result']['featureCollection']['features'];
        final featureList = List.from(features);
        final iterable = featureList.map((feat) {
          return '${feat['properties']['full_nm']}';
        });
        return iterable.toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

@riverpod
VworldRepository vworldRepository(Ref ref) {
  final dio = Dio(
    BaseOptions(
      validateStatus: (status) => true, // 실패 응답 시 throw 로 인해 앱 터지는거 방지
    ),
  );
  return VworldRepository(client: dio);
}
