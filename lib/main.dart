import 'package:flutter/material.dart';
import 'package:netflix/controller/movie_controller.dart';
import 'package:netflix/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Netflix Clone",
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}