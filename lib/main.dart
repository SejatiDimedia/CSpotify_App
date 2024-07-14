import 'package:cspotify_app/core/configs/theme/app_theme.dart';
import 'package:cspotify_app/firebase_options.dart';
import 'package:cspotify_app/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:cspotify_app/presentation/choose_mode/pages/choose_mode_page.dart';
import 'package:cspotify_app/presentation/home/pages/home_page.dart';
import 'package:cspotify_app/presentation/splash/pages/splash_page.dart';
import 'package:cspotify_app/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          debugShowCheckedModeBanner: false,
          home: const AuthWrapper(), // Use AuthWrapper to handle auth state
        ),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check the connection state and authentication state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashPage(); // Show a loading indicator while waiting
        } else if (snapshot.hasData) {
          return const HomePage(); // If the user is logged in, show the HomePage
        } else {
          return const ChooseModePage(); // If the user is not logged in, show the ChooseModePage
        }
      },
    );
  }
}
