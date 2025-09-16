import 'package:flutter/material.dart';
import 'package:vibe_client/widgets/login_button.dart';

void main() {
  runApp(const VibeClient());
}

class VibeClient extends StatelessWidget {
  const VibeClient({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vibe Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const VibeHome(title: 'Vibe'),
    );
  }
}

class VibeHome extends StatefulWidget {
  const VibeHome({super.key, required this.title});

  final String title;

  @override
  State<VibeHome> createState() => _VibeHomeState();
}

class _VibeHomeState extends State<VibeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          const Spacer(flex: 1),
          const Center(
            child: Text("Welcome to Vibe", style: TextStyle(fontSize: 24)),
          ),
          const Spacer(flex: 1),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoginButton(type: LoginType.google),
              const SizedBox(height: 10),
              LoginButton(type: LoginType.apple),
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
