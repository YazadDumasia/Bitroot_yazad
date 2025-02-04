import 'dart:math';

import 'package:bitroot/utils/utils.dart';
import 'package:bitroot/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SplashScreenDesktopLayout extends StatefulWidget {
  const SplashScreenDesktopLayout({super.key});

  @override
  State<SplashScreenDesktopLayout> createState() =>
      _SplashScreenDesktopLayoutState();
}

class _SplashScreenDesktopLayoutState extends State<SplashScreenDesktopLayout> {
  List<Color> listParticleColor = <Color>[];
  var appLogoLight;

  Size? size;
  Orientation? orientation;

  @override
  void initState() {
    appLogoLight = FlutterLogo(
      size: 120,
    );
    for (int i = 0; i < 50; i++) {
      listParticleColor.add(
        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    return AnimateGradient(
      primaryBegin: Alignment.topLeft,
      primaryEnd: Alignment.bottomLeft,
      secondaryBegin: Alignment.bottomLeft,
      secondaryEnd: Alignment.topRight,
      duration: const Duration(seconds: 2),
      primaryColors: const [
        Color.fromRGBO(225, 109, 245, 1),
        Color.fromRGBO(78, 248, 231, 1),
        // Color.fromRGBO(99, 251, 215, 1),
        // Color.fromRGBO(83, 138, 214, 1)
      ],
      secondaryColors: const [
        Color.fromRGBO(5, 222, 250, 1),
        Color.fromRGBO(134, 231, 214, 1)
      ],
      child: SizedBox(
        key: UniqueKey(),
        width: size!.width,
        height: size!.height,
        child: Stack(
          children: [
            CircularParticle(
              awayRadius: 50,
              numberOfParticles: 120,
              speedOfParticles: 1.4,
              width: size!.width,
              height: size!.height,
              onTapAnimation: true,
              particleColor: Colors.white.withAlpha(150),
              awayAnimationDuration: const Duration(milliseconds: 600),
              maxParticleSize: 8,
              isRandSize: true,
              isRandomColor: true,
              randColorList: listParticleColor,
              awayAnimationCurve: Curves.easeInOutBack,
              enableHover: true,
              hoverColor: Colors.white,
              hoverRadius: 90,
              connectDots: false, //not recommended
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: OrientationBuilder(
                builder: (context, orientation) {
                  print("orientation:$orientation");
                  if (orientation == Orientation.landscape) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: PulseAnimation(
                              maxScale: 1.0,
                              minScale: 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .40,
                                  // child: appLogoLight,
                                  child: FlutterLogo(
                                    size: 150,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            elevation: 2,
                            margin: const EdgeInsets.only(left: 30, right: 30),
                            child: PulseAnimation(
                              maxScale: 1.0,
                              minScale: 0.8,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .65,
                                  // child: appLogoLight,
                                  child: FlutterLogo(
                                    size: 150,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    // precacheImage(appLogoLight.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
