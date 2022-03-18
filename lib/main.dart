import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:website/screen/about.dart';
import 'package:website/screen/navigation_controls.dart';
import 'package:website/screen/webview_stack.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onPressed: () async {
                const phoneNumber = '+8801783698303';
                const url = 'tel:$phoneNumber';

                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
              child: const Icon(
                Icons.phone,
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
                        iconSize: 25.0,
                        icon: const Icon(Icons.home),
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
                      ),
                      IconButton(
                        iconSize: 25.0,
                        icon: const Icon(Icons.person),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PersonalDetails()),
                          );
                        },
                      ),
                      IconButton(
                        iconSize: 25.0,
                        icon: const Icon(Icons.message),
                        onPressed: () async {
                          const phoneNumber = '+8801783698303';
                          const url = 'sms:$phoneNumber';

                          if (await canLaunch(url)) {
                            await launch(
                              url,
                            );
                          }
                        },
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
