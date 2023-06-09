import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pandacasino_scratcher/screens/unity/UnityMainScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MAIN"),
      ),
      body: Center(
        child: TextButton(
          child: Text("GO GAME "),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return NestedUnityMainScreen();
            }));
          },
        ),
      ),
    );
  }
}
