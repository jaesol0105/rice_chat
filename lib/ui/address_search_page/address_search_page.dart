import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/geolocator_helper.dart';
import 'package:rice_chat/ui/address_search_page/address_search_view_model.dart';
import 'package:rice_chat/ui/home_page/home_page.dart';

class AddressSearchPage extends ConsumerWidget {
  const AddressSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(addressSearchViewModelProvider.notifier);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                vm.searchByName(value);
              }
            },
            decoration: InputDecoration(
              hintText: '동명(읍,면)으로 검색 (ex. 서초동)',
              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  return SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        // GeolocatorHelper에서 위치 받아오기
                        final position = await GeolocatorHelper.getPosition();
                        if (position != null) {
                          // 위경도 기반으로 읍면동 검색
                          vm.serachByLocation(position.latitude, position.longitude);
                        }
                      },
                      child: const Text('현재 위치로 찾기'),
                    ),
                  );
                },
              ),
              // 리스트 영역은 Expanded 로 감싸서 남은 공간 차지하도록
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(addressSearchViewModelProvider);
                    return state.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Center(child: Text('주소 목록을 불러올 수 없습니다.\n$err')),
                      data: (addresses) {
                        if (addresses.isEmpty) {
                          return const Center(child: Text('검색 결과가 없습니다.'));
                        }
                        return ListView.builder(
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            final item = addresses[index];
                            return GestureDetector(
                              onTap: () {
                                vm.saveAddress(address: item);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                );
                              },
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                color: Colors.transparent,
                                alignment: Alignment.centerLeft,
                                child: Text(item, style: const TextStyle(fontSize: 16)),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
