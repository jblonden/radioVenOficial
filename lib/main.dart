import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radio_ven_105_5_fm/radio_screen.dart';
import 'package:just_audio_background/just_audio_background.dart';



Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Radio VEN 105.5 FM',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
     
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF310050),
          brightness: Brightness.light,
        ),
      ),
      title: ' VEN 105.5 FM',
      home: RadioScreen(),

      
    );
  }
}