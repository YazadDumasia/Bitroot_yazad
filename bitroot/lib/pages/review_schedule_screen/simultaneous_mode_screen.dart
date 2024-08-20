import 'package:bitroot/bloc/bloc.dart';
import 'package:bitroot/models/models.dart';
import 'package:bitroot/pages/pages.dart';
import 'package:bitroot/utils/components/constants.dart';
import 'package:bitroot/widgets/widgets.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimultaneousModeScreen extends StatefulWidget {
  const SimultaneousModeScreen({Key? key}) : super(key: key);

  @override
  _SimultaneousModeScreenState createState() => _SimultaneousModeScreenState();
}

class _SimultaneousModeScreenState extends State<SimultaneousModeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewScheduleSimultaneousModeBloc,
        ReviewScheduleSimultaneousModeState>(
      builder: (context, state) {
        if (state is ReviewScheduleSimultaneousModeInitial ||
            state is ReviewScheduleSimultaneousModeLoading) {
          return const LoadingPage();
        }
        if (state is ReviewScheduleSimultaneousModeLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 5));
              context
                  .read<ReviewScheduleSimultaneousModeBloc>()
                  .add(RefreshLoadReviewScheduleSimultaneousModeEvent());
            },
            child: CustomScrollView(
              physics: NeverScrollableScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    addAutomaticKeepAlives: false,
                    addSemanticIndexes: true,
                    addRepaintBoundaries: true,
                    childCount: (state.simultaneousList == null ||
                            state.simultaneousList!.isEmpty)
                        ? 0
                        : state.simultaneousList?.length ?? 0,
                    (context, index) {
                      Sequential simultaneous = state.simultaneousList![index];
                      return reviewSimultaneousModeItemView(
                        model: simultaneous,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        if (state is ReviewScheduleSimultaneousModeError) {
          return ErrorPage(
            error_str: state.error_str,
            onPressedRetryButton: () {
              context
                  .read<ReviewScheduleSimultaneousModeBloc>()
                  .add(InitialLoadReviewScheduleSimultaneousModeEvent());
            },
          );
        }
        if (state is ReviewScheduleSimultaneousModeNoInternet) {
          return NoInternetPage(
            onPressedRetryButton: () {
              context
                  .read<ReviewScheduleSimultaneousModeBloc>()
                  .add(InitialLoadReviewScheduleSimultaneousModeEvent());
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

  reviewSimultaneousModeItemView(
      {required Sequential model, required int index}) {
    double text1Height = calculateTextHeight(
      "Tank 1 Nitrogen",
      Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.w700),
      double.infinity,
    );
    double text2Height = calculateTextHeight(
      'Volume ${model.volume ?? ''} 60 mins',
      Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.w700),
      double.infinity,
    );
    double text3Height = calculateTextHeight(
      '${model.mode ?? ''} mode',
      Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(fontWeight: FontWeight.w700),
      double.infinity,
    );
    double totalTextHeight1 = text1Height + text2Height - 10;
    double totalTextHeight2 = text2Height + text3Height - 10;

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
                    model.device ?? "",
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
                                  lineLength: totalTextHeight1,
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
                                DottedLine(
                                  direction: Axis.vertical,
                                  dashLength: 4,
                                  lineLength: totalTextHeight2,
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
                                                'Volume ${model.volume ?? ''} ',
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
                                                '${model.mode == null ? "" : Constants.capitalize(model.mode!)} mode',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
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
                                                      '${model.preMix ?? 0} min',
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
                                                      '${model.fertigation ?? 0} min',
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
                                                      '${model.postMix ?? 0} min',
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
                              activeTrackColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer
                                  .withOpacity(0.3),
                              inactiveTrackColor: Colors.grey.shade300,

                              // Overlay and thumb colors
                              overlayColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.2),
                              thumbColor: Theme.of(context).colorScheme.primary,
                              trackHeight: 10.0,

                              // Show value indicator
                              showValueIndicator: ShowValueIndicator
                                  .always, // <-- This enables the label
                            ),
                            child: Slider(
                              value: model.value ?? 0,
                              min: 0,
                              max: model.fertigation!,
                              label: model.value!.toStringAsFixed(1),
                              onChanged: (newValue) async {
                                // context
                                //     .read<ReviewScheduleSimultaneousModeBloc>()
                                //     .add(
                                //         UpdateSliderValueSimultaneousModeReviewEvent(
                                //             index: index, value: newValue));
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
