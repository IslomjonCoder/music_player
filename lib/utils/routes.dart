import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:untitled7/presentation/screens/home_screen.dart';

class RouteNames {
  static const String songs = "/";
  static const String music = "/music";
}

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.songs:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteNames.music:
        return MaterialPageRoute(
            builder: (context) => MusicDetail(
                  song: settings.arguments as SongModel,
                ));

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route not found"),
            ),
          ),
        );
    }
  }
}
