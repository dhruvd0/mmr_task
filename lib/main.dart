import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmr_task/config/firebase/firebase.dart';
import 'package:mmr_task/config/theme/theme.dart';
import 'package:mmr_task/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:mmr_task/features/home/bloc/home_cubit.dart';
import 'package:mmr_task/features/profile/profile_cubit/profile_cubit.dart';
import 'package:mmr_task/firebase_options.dart';
import 'package:mmr_task/splash.dart';

FirebaseConfig? firebaseConfig;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  firebaseConfig = FirebaseConfig.defaultInstances();
  runApp(const MaterialApp(home:  VideoPlayerApp()));
}

class VideoPlayerApp extends StatefulWidget {
  const VideoPlayerApp({Key? key}) : super(key: key);

  @override
  State<VideoPlayerApp> createState() => _VideoPlayerAppState();
}

class _VideoPlayerAppState extends State<VideoPlayerApp> {


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        theme: LightTheme.lightTheme,
        // ignore: prefer_const_constructors
        home:  Splash(),
      ),
    );
  }
}
