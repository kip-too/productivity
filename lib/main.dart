import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_list_app/features/auth/presentation/pages/login_page.dart';
import 'package:todo_list_app/features/auth/presentation/pages/onboarding_carousel.dart';
import 'package:todo_list_app/features/auth/presentation/pages/sign_up_page.dart';

import 'core/constants/supabase_keys.dart';
import 'core/theme/app_theme.dart';
import 'features/todos/presentation/pages/todo_list.dart';
import 'features/todos/presentation/providers/todo_providers.dart';

Future<void> main() async{
  await Supabase.initialize(url: Url, anonKey: supabaseAnonKey);

  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
class MainApp extends ConsumerWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final bool isLoggedIn = client.auth.currentSession != null;

    return MaterialApp(
      themeMode: themeMode,
      darkTheme: AppThemes.darkTheme,
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/' : '/login', // Set initial route based on login status
      routes: {
        '/': (context) => isLoggedIn ? const TodoListPage() : const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/onboarding': (context) => const OnboardingCarousel(),
      },
    );
  }
}
