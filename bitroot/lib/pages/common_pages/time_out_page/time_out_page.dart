import 'package:bitroot/config/config.dart';
import 'package:flutter/material.dart';

class TimeOutPage extends StatefulWidget {
  final GestureTapCallback? onPressedRetryButton;
  final String? error_str;

  const TimeOutPage(
      {super.key, required this.error_str, required this.onPressedRetryButton});

  @override
  State<TimeOutPage> createState() => _TimeOutPageState();
}

class _TimeOutPageState extends State<TimeOutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Image.asset(
                    AppAssetPaths.time_out_error_img,
                    fit: BoxFit.scaleDown,
                    width: MediaQuery.of(context).size.width * .65,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * .50
                        : 250,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.error_str ?? "",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // button's shape
                            ),
                            elevation: 3,
                          ),
                          onPressed: widget.onPressedRetryButton,
                          child: const Text('Retry'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
