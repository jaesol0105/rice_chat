import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/core/theme/color_scheme_ext.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef widgetRef) {
    final showLoginButton = useState(false);

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
              Image.asset("assets/images/logo.png"),
              Spacer(),
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
