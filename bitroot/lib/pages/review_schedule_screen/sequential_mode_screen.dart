import 'package:bitroot/bloc/bloc.dart';
import 'package:bitroot/models/models.dart';
import 'package:bitroot/pages/common_pages/error_page/error_page.dart';
import 'package:bitroot/pages/common_pages/loading_page/loading_page.dart';
import 'package:bitroot/pages/common_pages/no_internet_page/no_internet_page.dart';
import 'package:bitroot/widgets/widgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SequentialModeScreen extends StatefulWidget {
  const SequentialModeScreen({Key? key}) : super(key: key);

  @override
  _SequentialModeScreenState createState() => _SequentialModeScreenState();
}

class _SequentialModeScreenState extends State<SequentialModeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewScheduleSequentialModeBloc,
        ReviewScheduleSequentialModeState>(
      builder: (context, state) {
        if (state is ReviewScheduleSequentialModeInitial ||
            state is ReviewScheduleSequentialModeLoading) {
          return LoadingPage();
        }
        if (state is ReviewScheduleSequentialModeLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 5));
              context
                  .read<ReviewScheduleSequentialModeBloc>()
                  .add(RefreshLoadReviewScheduleEvent());
            },
            child: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    addAutomaticKeepAlives: false,
                    addSemanticIndexes: true,
                    addRepaintBoundaries: true,
                    childCount: (state.sequentialList == null ||
                            state.sequentialList!.isEmpty)
                        ? 0
                        : state.sequentialList?.length ?? 0,
                    (context, index) {
                      Sequential sequential = state.sequentialList![index];
                      return reviewSequentialModeItemView(
                        sequential: sequential,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        if (state is ReviewScheduleSequentialModeError) {
          return ErrorPage(
            error_str: state.error_str,
            onPressedRetryButton: () {
              context
                  .read<ReviewScheduleSequentialModeBloc>()
                  .add(InitialLoadReviewScheduleEvent());
            },
          );
        }
        if (state is ReviewScheduleSequentialModeNoInternet) {
          return NoInternetPage(
            onPressedRetryButton: () {
              context
                  .read<ReviewScheduleSequentialModeBloc>()
                  .add(InitialLoadReviewScheduleEvent());
            },
          );
        }
        return SizedBox.shrink();
      },
      listener: (context, state) {},
    );
  }

  double calculateTextHeight(String text, TextStyle style, double maxWidth) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);
    return textPainter.size.height;
  }

  reviewSequentialModeItemView(
      {required Sequential sequential, required int index}) {
    double text1Height = calculateTextHeight(
      "Tank 1 Nitrogen",
      Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.w700),
      double.infinity,
    );
    double text2Height = calculateTextHeight(
      'Volume ${sequential.volume ?? ''} 60 mins',
      Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.w700),
      double.infinity,
    );
    double totalTextHeight = text1Height + text2Height - 10;
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    sequential.device ?? "",
                    style: Theme.of(context).textTheme.titleLarge,
                  )),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        width: 2.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${(index ?? 0) + 1}",
                          style:
                          Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).brightness ==
                                Brightness.light
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                DottedLine(
                                  direction: Axis.vertical,
                                  dashLength: 4,
                                  lineLength: totalTextHeight,
                                  dashColor: Colors.black,
                                ),
                                const CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.black,
                                  child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text: "Tank 1 ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Nitrogen',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w200),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(
                                            text:
                                                'Volume ${sequential.volume ?? ''} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: '60 mins',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w200),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: RichText(
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              text: 'Pre Mix\n',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${sequential.preMix ?? 0} min',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w200),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              text: 'Fertigation\n',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${sequential.fertigation ?? 0} min',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Expanded(
                                          child: RichText(
                                            textAlign: TextAlign.end,
                                            text: TextSpan(
                                              text: 'Post mix\n',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      '${sequential.postMix ?? 0} min',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              // Custom thumb shape with rounded rectangle
                              thumbShape: SliderRectangularThumbShape(context),

                              // Custom active and inactive track colors
                              activeTrackColor:Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                              inactiveTrackColor: Colors.grey.shade300,

                              // Overlay and thumb colors
                              overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                              thumbColor: Theme.of(context).colorScheme.primary,
                              trackHeight: 10.0,

                              // Show value indicator
                              showValueIndicator: ShowValueIndicator.always,  // <-- This enables the label
                            ),
                            child: Slider(
                              value: sequential.value ?? 0,
                              min: 0,
                              max: sequential.fertigation!,
                              label: sequential.value!.toStringAsFixed(1),
                              onChanged: (newValue) async {
                                context
                                    .read<ReviewScheduleSequentialModeBloc>()
                                    .add(
                                        UpdateSliderValueSequentialModeReviewEvent(
                                            index: index, value: newValue));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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


