import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/notes_page/note_provider.dart';
import 'package:motix_app/pages/coach_page.dart';
import 'package:motix_app/pages/cubit/registerCubit.dart';
import 'package:motix_app/pages/home_page.dart';
import 'package:motix_app/pages/profile.dart';
import 'package:motix_app/pages/social_media_page/social_media_page.dart';
import 'package:motix_app/pages/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
