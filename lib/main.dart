import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  runApp(const StarGameApp());
}

class StarGameApp extends StatelessWidget {
  const StarGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StarGamePage(),
    );
  }
}

class StarGamePage extends StatefulWidget {
  const StarGamePage({super.key});

  @override
  State<StarGamePage> createState() => _StarGamePageState();
}

class _StarGamePageState extends State<StarGamePage> {
  StreamSubscription<String?>? _sub;
  String? gameId;

  @override
  void initState() {
    super.initState();
    _initDeepLink();
  }

  void _initDeepLink() {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    }, onError: (err) {
      // Handle error
    }) as StreamSubscription<String?>?;
  }

  void _handleDeepLink(Uri uri) {
    print('Deep link recebido: $uri');
    // Extrair o ID do jogo do deep link
    final id = uri.queryParameters['id'];
    if (id != null) {
      print('ID do jogo: $id');
      setState(() {
        gameId = id;
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameScreen(gameId: id)),
      );
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Star Game'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const GameScreen(gameId: 'default')),
            );
          },
          child: const Text('Start Game'),
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final String gameId;

  const GameScreen({super.key, required this.gameId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Playing Game $gameId')),
      body: Center(child: Text('Playing Game $gameId')),
    );
  }
}
