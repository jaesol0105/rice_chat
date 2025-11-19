import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/ui/home_page/_tab/profile_tab/profile_view_model.dart';

class ProfileList extends HookConsumerWidget {
  const ProfileList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileViewModelProvider);
    final viewModel = ref.read(profileViewModelProvider.notifier);

    useEffect((){
      viewModel.loadProfile();
      return null;
    }, []);

    final nameController = useTextEditingController(text: state.user!.name);
    final ageController = useTextEditingController(text: state.user!.age.toString());
    final descController = useTextEditingController(text: state.user!.aboutMe ?? "");

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(60),
                onTap:()async{
                  await viewModel.updateProfileImage();
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: state.profileImgUrl != null
                      ? NetworkImage(state.profileImgUrl!)
                      : null,
                  child: state.profileImgUrl == null
                      ? const Icon(Icons.camera_alt, size: 38, color: Colors.black54)
                      : null,
                ),
              ),

              const SizedBox(height: 40),

              // 이름
              _buildInputField(
                context: context, 
                controller: nameController, 
                hint: "이름"
              ),

              const SizedBox(height: 20),

              _buildInputField(
                context: context, 
                controller: ageController, 
                hint: "나이/성별"
              ),

              const SizedBox(height: 20),

              _buildInputField(
                context: context,
                controller: descController,
                hint: "소개 멘트",
                maxLines: 7,
              ),

              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: ()async{
                        await viewModel.saveProfile(
                          name: nameController.text.trim(), 
                          age: int.tryParse(ageController.text.trim()) ?? 0, 
                          sex: state.user!.sex, 
                          about: descController.text.trim(),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("프로필이 저장되었습니다")),
                        );
                      }, 
                      child: Text("프로필 저장"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(hintText: hint),
      style: TextStyle(fontSize: 12),
    );
  }
}
