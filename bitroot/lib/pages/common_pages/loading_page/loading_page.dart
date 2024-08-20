import 'package:bitroot/config/config.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Container(
              //   child: Lottie.asset(
              //     AppAssetPaths.loading_lottie,
              //     frameRate: FrameRate.max,
              //     backgroundLoading: true,
              //     options: LottieOptions(enableMergePaths: true,enableApplyingOpacityToLayers: true),
              //     width: MediaQuery.of(context).size.width * .65,
              //     height: MediaQuery.of(context).size.height * .65,
              //   ),
              // ),
              Container(
                child: Image.asset(
                  AppAssetPaths.initial_loader_lottie,
                  fit: BoxFit.scaleDown,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .65,
                  height: MediaQuery
                      .of(context)
                      .orientation == Orientation.portrait ? MediaQuery
                      .of(context)
                      .size
                      .height * .50:250,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
