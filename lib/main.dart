import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:motix_app/pages/cubit/addPostCubit.dart';
import 'package:motix_app/pages/cubit/imageCubit.dart';
import 'package:motix_app/pages/cubit/registerCubit.dart';
import 'package:motix_app/pages/cubit/socialMediaCubit.dart';
import 'package:motix_app/pages/splash_screen.dart';
import 'package:motix_app/product/util/consts.dart';
import 'package:motix_app/notes_page/note_provider.dart';
import 'package:provider/provider.dart';


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
}

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
