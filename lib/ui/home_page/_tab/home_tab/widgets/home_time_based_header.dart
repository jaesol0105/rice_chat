import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/home_tab_view_model.dart';

class HomeTimeBasedHeader extends ConsumerWidget {
  const HomeTimeBasedHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeTabViewModelProvider);
    final now = DateTime.now();
    final imageAsset = _getImageAssetForHour(now.hour);
    final formattedTime = DateFormat('yyyy.MM.dd.HH:mm').format(now);

    return state.when(
      data: (state) {
        return Column(
          children: [
            const SizedBox(height: 12),
            // 현재 위치한 읍면동 표시
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 24, top: 24),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  state.address,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // 배너 이미지 (시간에 따라 바뀜)
            Center(child: Image.asset(imageAsset, width: 200, height: 200, fit: BoxFit.contain)),
            // 날짜랑 시간 표시
            Text(formattedTime, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 16),
          ],
        );
      },
      loading: () => const Padding(padding: EdgeInsets.symmetric(vertical: 48)),
      error: (e, st) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Text('error: $e', style: const TextStyle(color: Colors.red)),
      ),
    );
  }

  /// 시간대별로 다른 이미지 반환
  String _getImageAssetForHour(int hour) {
    // 6시 ~ 22시 : 낮
    if (hour >= 6 && hour < 22) {
      return 'assets/images/sun.webp';
    } else {
      return 'assets/images/moon.webp';
    }
  }
}
