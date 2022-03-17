import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:website/screen/about.dart';
import 'package:website/screen/navigation_controls.dart';
import 'package:website/screen/webview_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '3D TEAM',
        home: AnimatedSplashScreen(
            duration: 3000,
            splashIconSize: 800,
            splash: 'assets/3D-TEAM.png',
            nextScreen: MainScreen(controller: controller),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white));
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key? key,
    this.controller,
  }) : super(key: key);

  final Completer<WebViewController>? controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: SizedBox(
          height: 65.0,
          width: 65.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                      controller: controller,
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              elevation: 5.0,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          elevation: 20.0,
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        iconSize: 30.0,
                        icon: const Icon(Icons.person),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PersonalDetails()),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        iconSize: 30.0,
                        icon: const Icon(Icons.notifications),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                NavigationControls(controller: controller!)
              ],
            ),
          ),
        ),
        body: WebViewStack(
          controller: controller!,
        ),
      ),
    );
  }
}
