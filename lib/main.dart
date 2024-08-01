import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:motix_app/cubit/addPostCubit.dart';
import 'package:motix_app/cubit/imageCubit.dart';
import 'package:motix_app/cubit/profileCubit.dart';
import 'package:motix_app/cubit/registerCubit.dart';
import 'package:motix_app/cubit/socialMediaCubit.dart';
import 'package:motix_app/presantations/notesPage/note_provider.dart';
import 'package:motix_app/presantations/splashScreen/splash_screen.dart';
import 'package:motix_app/util/consts/consts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Gemini.init(apiKey: GEMINI_API_KEY);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: MyApp(),
    ),
  );
} //end void main

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => Imagecubit()),
        BlocProvider(create: (context) => SocialMediaCubit()),
        BlocProvider(create: (context) => AddPostCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        locale: Locale('tr', 'TR'),
        supportedLocales: [
          const Locale('en', 'EN'),
          const Locale('tr', 'TR'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        home: SplashScreen(),
      ),
    );
  }
} //end class MyApp
