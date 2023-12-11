import 'package:flutter/material.dart';
import 'package:flutter_simple_updates/flutter_simple_updates.dart';
import 'package:simple_mastodon_updates/logic/SimpleMastodonParser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final SimpleMastodonParser parser =
      SimpleMastodonParser("!", "https://mastodon.world/@Decentproof");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: NotificationWidget(
          cache: HiveCacheWrapper(),
          feedProvider: parser,
        ),
      ),
    );
  }
}
