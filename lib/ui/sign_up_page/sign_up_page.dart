import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rice_chat/core/theme/color_scheme_ext.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController nameController = useTextEditingController();
    TextEditingController ageController = useTextEditingController();
    TextEditingController descriptionController = useTextEditingController();

    final gender = useState<String>("남성");

    final profileImage = useState<File?>(null);

    Future<void> pickImage() async {
      final picker = ImagePicker();
      final XFile? picked = await picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        profileImage.value = File(picked.path);
      }
    }

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
                  onTap: () => pickImage(),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: profileImage.value != null
                        ? FileImage(profileImage.value!)
                        : null,
                    child: profileImage.value == null
                        ? Icon(Icons.camera_alt, size: 38, color: Colors.black54)
                        : null,
                  ),
                ),
                SizedBox(height: 40),
                inputField(context, controller: nameController, hint: "이름"),
                SizedBox(height: 20),
                inputField(context, controller: ageController, hint: "나이"),
                SizedBox(height: 20),
                inputField(
                  context,
                  controller: descriptionController,
                  hint: "소개 멘트",
                  maxLines: 7,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: genderButton(
                        context,
                        image: Image.asset("assets/images/male.webp"),
                        selected: gender.value == "남성",
                        onTap: () => gender.value == "남성",
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: genderButton(
                        context,
                        image: Image.asset("assets/images/female.webp"),
                        selected: gender.value == "여성",
                        onTap: () => gender.value == "여성",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
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
