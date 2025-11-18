import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/theme/color_scheme_ext.dart';
import 'package:rice_chat/ui/sign_up_page/sign_up_page.dart';
import 'package:rice_chat/ui/splash_page/auth_view_model.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showLoginButton = useState(false);
    final authState = ref.watch(authViewModelProvider);

    useEffect(() {
      Future.delayed(Duration(seconds: 2), () {
        showLoginButton.value = true;
      });
      return null;
    }, []);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset("assets/images/logo.webp",
              width: 320,
              height: 320,
              ),
              Spacer(),
              if(authState.isLoading)
              Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: CircularProgressIndicator(),
              ),
              AnimatedOpacity(
                opacity: showLoginButton.value ? 1 : 0,
                duration: Duration(milliseconds: 800),
                child: Column(
                  children: [
                    button(
                      context,
                      icon: Icons.apple,
                      text: '애플로 로그인하기',
                      onTap: () {},
                    ),
                    SizedBox(height: 16),
                    button(
                      context,
                      icon: Icons.language,
                      text: "구글로 로그인하기",
                      onTap: () async{
                        final user = await ref
                        .read(authViewModelProvider.notifier)
                        .loginWithGoogle();

                        if(user != null){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        } else {
                          final error = ref.read(authViewModelProvider).error;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error ?? "로그인 실패")),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    button(
                      context,
                      icon: Icons.check_box_outline_blank,
                      text: '네이버로 로그인하기',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.fieldBorder,
            width: 1,
          ),
          color: Theme.of(context).colorScheme.fieldBackground,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(text, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
