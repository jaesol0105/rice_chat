import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/theme/color_scheme_ext.dart';
import 'package:rice_chat/ui/address_search_page/address_search_page.dart';
import 'package:rice_chat/ui/sign_up_page/sign_up_view_model.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpViewModelProvider);
    final vm = ref.read(signUpViewModelProvider.notifier);

    TextEditingController nameController = useTextEditingController();
    TextEditingController ageController = useTextEditingController();
    TextEditingController descriptionController = useTextEditingController();

    final gender = useState<String>("남성");

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: InkWell(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(60),
                  onTap: () => vm.pickAndUploadProfileImage(),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: signUpState.profileImgUrl != null
                        ? NetworkImage(signUpState.profileImgUrl!)
                        : null,
                    child: signUpState.profileImgUrl == null
                        ? Icon(Icons.camera_alt, size: 38, color: Colors.black54)
                        : null,
                  ),
                ),
                SizedBox(height: 40),
                inputField(context, controller: nameController, hint: "이름"),
                SizedBox(height: 20),
                inputField(context, controller: ageController, hint: "나이"),
                SizedBox(height: 20),
                inputField(context, controller: descriptionController, hint: "소개 멘트", maxLines: 7),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: genderButton(
                        context,
                        image: Image.asset("assets/images/male.webp"),
                        selected: gender.value == "남성",
                        onTap: () => gender.value = "남성",
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: genderButton(
                        context,
                        image: Image.asset("assets/images/female.webp"),
                        selected: gender.value == "여성",
                        onTap: () => gender.value = "여성",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final viewModel = ref.read(signUpViewModelProvider.notifier);
                          final error = viewModel.validate(
                            name: nameController.text.trim(),
                            ageText: ageController.text.trim(),
                            about: descriptionController.text.trim(),
                          );
                          if (error != null) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(error)));
                            return;
                          }
                          await viewModel.saveProfile(
                            name: nameController.text,
                            age: int.tryParse(ageController.text) ?? 0,
                            sex: gender.value == "남성",
                            address: null,
                            aboutMe: descriptionController.text,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => AddressSearchPage()),
                          );
                        },
                        child: Text("프로필 등록"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputField(
    BuildContext context, {
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

  Widget genderButton(
    BuildContext context, {
    required Image image,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected
                    ? Theme.of(context).colorScheme.selectedBorder
                    : Theme.of(context).colorScheme.fieldBorder,
                width: 1,
              ),
              color: Theme.of(context).colorScheme.fieldBackground,
            ),
            alignment: Alignment.center,
            child: image,
          ),
        ],
      ),
    );
  }
}
