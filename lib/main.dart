import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neon/neon.dart';
import 'package:neonpen/neonpen.dart';
import 'package:page_transition/page_transition.dart';

import 'vision_detector_views/object_detector_view.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => AnimatedSplashScreen(
              splashIconSize: double.infinity,
              splash: Stack(
                children: [
                  Positioned.fill(
                    child: Lottie.asset(
                      'assets/lotte/46533-charts.json',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: Lottie.asset(
                        'assets/lotte/75679-camera.json',
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              nextScreen: Home(),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,
            ),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0XFF00D1FD),
          Color(0XFF03012A).withOpacity(.5),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          children: [
            Spacer(),
            Image.asset('assets/lotte/gub.png'),
            Neonpen(
              text: Text(
                ' Data Mining Lab! ',
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoSerif(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              color: Colors.indigo,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              opacity: 0.4,
              emphasisWidth: 15,
              emphasisOpacity: 0.3,
              emphasisAngleDegree: 2,
              enableLineZiggle: true,
              lineZiggleLevel: 1,
              isDoubleLayer: false,
            ),
            SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigoAccent.shade100,
                      offset: Offset(3, 5),
                      spreadRadius: 5,
                      blurRadius: 5,
                    )
                  ]),
              child: Text(
                'Object Detection App',
                style: GoogleFonts.oleoScript(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigoAccent),
              ),
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ObjectDetectorView()));
              },
              child: Lottie.asset(
                'assets/lotte/9948-camera-pop-up.json',
                width: 240,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
            Neon(
              text: 'Tap',
              color: Colors.indigo,
              fontSize: 50,
              font: NeonFont.Beon,
              flickeringText: true,
              flickeringLetters: [0, 1],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
