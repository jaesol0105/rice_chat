import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/geolocator_helper.dart';
import 'package:rice_chat/ui/address_search_page/address_search_view_model.dart';

class AddressSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Consumer(
            builder: (context, ref, child) {
              return TextField(
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    final viewModel = ref.read(addressSearchViewModelProvider.notifier);
                    viewModel.searchByName(value);
                  }
                },
                decoration: InputDecoration(
                  hintText: '동명(읍,면)으로 검색 (ex. 서초동)',
                  contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                ),
              );
            },
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
                        // 1. GeolocatorHelper에서 위치 받아오기
                        final position = await GeolocatorHelper.getPosition();
                        if (position != null) {
                          // 2. 뷰모델에 요청하기
                          final viewModel = ref.read(addressSearchViewModelProvider.notifier);
                          viewModel.serachByLocation(position.latitude, position.longitude);
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) {
                                //       return JoinPage(item);
                                //     },
                                //   ),
                                // );
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
