import 'package:animations/animations.dart';
import 'package:bitroot/bloc/bloc.dart';
import 'package:bitroot/pages/review_schedule_screen/sequential_mode_screen.dart';
import 'package:bitroot/pages/review_schedule_screen/simultaneous_mode_screen.dart';
import 'package:bitroot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReviewScheduleScreen extends StatefulWidget {
  const ReviewScheduleScreen({Key? key}) : super(key: key);

  @override
  _ReviewScheduleScreenState createState() => _ReviewScheduleScreenState();
}

class _ReviewScheduleScreenState extends State<ReviewScheduleScreen>
    with TickerProviderStateMixin {
  late final ScrollController scrollController;

  late TabController _tabController;
  int? currentTabIndex = 0;
  DateTime? currentBackPressTime;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(
      () {
        setState(() {
          currentTabIndex = _tabController.index;
          Constants.debugLog(
              ReviewScheduleScreen, "currentTabIndex:$currentTabIndex");
  /*        switch (currentTabIndex) {
            case 0:
              BlocProvider.of<ReviewScheduleSimultaneousModeBloc>(context)
                  .add(InitialLoadReviewScheduleSimultaneousModeEvent());
              break;
            case 1:
              BlocProvider.of<ReviewScheduleSequentialModeBloc>(context)
                  .add(InitialLoadReviewScheduleEvent());
              break;
            default:
              break;
          }*/
        });
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ReviewScheduleSimultaneousModeBloc>(context)
          .add(InitialLoadReviewScheduleSimultaneousModeEvent());
      BlocProvider.of<ReviewScheduleSequentialModeBloc>(context)
          .add(InitialLoadReviewScheduleEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: true,
          body: Scrollbar(
            controller: scrollController,
            interactive: true,
            child: NestedScrollView(
              controller: scrollController,
              physics: const ClampingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    backgroundColor: Colors.white,
                    centerTitle: false,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        onWillPop();
                      },
                      tooltip:
                          MaterialLocalizations.of(context).backButtonTooltip,
                    ),
                    title: Text(
                      'Review Schedule',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                    actions: [
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          if (state is ThemeUpdated) {
                            bool isDarkTheme =
                                state.themeMode == ThemeMode.dark;
                            return Tooltip  (
                              message: isDarkTheme ? 'Switch to Light Theme' : 'Switch to Dark Theme',
                              child: Switch.adaptive(
                                thumbIcon: WidgetStateProperty.resolveWith<Icon>(
                                  (Set<WidgetState> states) {
                                    if (states.containsAll([
                                      WidgetState.disabled,
                                      WidgetState.selected
                                    ])) {
                                      return const Icon(Icons.sunny,
                                          color: Colors.deepOrange);
                                    }

                                    if (states.contains(WidgetState.disabled)) {
                                      return const Icon(
                                        Icons.nightlight,
                                      );
                                    }

                                    if (states.contains(WidgetState.selected)) {
                                      return const Icon(Icons.nightlight,
                                          color: Colors.white);
                                    }

                                    return const Icon(
                                      Icons.sunny,
                                      color: Colors.orange,
                                    );
                                  },
                                ),
                                value: isDarkTheme,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onChanged: (value) {
                                  // Toggle between light and dark themes
                                  context.read<ThemeCubit>().cycleThemeMode();
                                },
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                  SliverResizingHeader(
                    child: Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).colorScheme.primary,
                        unselectedLabelColor: Colors.grey.shade600,
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        indicatorWeight: 2.0,
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                              fontWeight:
                                  FontWeight.bold, // Bold text for active tab
                            ),
                        unselectedLabelStyle:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight
                                      .normal, // Normal weight for inactive tab
                                ),
                        tabAlignment: TabAlignment.fill,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicator: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.25),
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary, // Underline color
                              width: 2.0, // Underline thickness
                            ),
                          ),
                        ),
                        tabs: [
                          const Tab(text: "Simultaneous mode"),
                          const Tab(text: "Sequential mode"),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  buildPageTransitionSwitcher(screen: SimultaneousModeScreen(),currentIndex: 0),
                  buildPageTransitionSwitcher(screen: SequentialModeScreen(),currentIndex: 1),
                  // const SimultaneousModeScreen(),
                  // const SequentialModeScreen(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<ReviewScheduleSimultaneousModeBloc,
                  ReviewScheduleSimultaneousModeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ReviewScheduleSimultaneousModeLoaded) {
                    return Visibility(
                      visible: _tabController.index == 0,
                      child: Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: ColoredBox(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                            .withOpacity(0.25),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  "Schedule 1",
                                                  textAlign: TextAlign.start,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Zone 1, Zone 2",
                                                  textAlign: TextAlign.end,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                            ],
                                          ),
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
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              BlocConsumer<ReviewScheduleSequentialModeBloc,
                  ReviewScheduleSequentialModeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is ReviewScheduleSequentialModeLoaded) {
                    return Visibility(
                      visible: _tabController.index == 1,
                      child: Row(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      child: ColoredBox(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.25),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  "Schedule 1",
                                                  textAlign: TextAlign.start,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Zone 1, Zone 2",
                                                  textAlign: TextAlign.end,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<
                                                    ReviewScheduleSequentialModeBloc>()
                                                .add(
                                                    FinishSequentialModeReviewEvent());
                                          },
                                          child: const Text('Finish'),
                                          style: ElevatedButton.styleFrom(
                                            // TODO: do not hardcode colors - use theming instead!
                                            foregroundColor: Colors.white,
                                            // foreground (text) color
                                            backgroundColor:
                                                Theme.of(context).colorScheme.primary,
                                            // background color
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                            padding: const EdgeInsets.all(10),
                                          ),
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
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageTransitionSwitcher({Widget? screen, int? currentIndex}) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 3000),
      transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
          FadeThroughTransition(
        animation: primaryAnimation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      ),
      child: screen ?? Container(),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() {
    Constants.debugLog(ReviewScheduleScreen, "WillPopScope");
    if (_tabController.index != 0) {
      _tabController.animateTo(0);
      return Future.value(false);
    } else {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(
            msg: "Press back again to exit",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3);

        return Future.value(false);
      } else {
        onBackPressDialog();
        return Future.value(true);
      }
    }
  }

  onBackPressDialog() {
    if (!Constants.isIOS() && !Constants.isMacOS()) {
      return showDialog(
        context: context,
        builder: (context) => Theme(
          data: Theme.of(context),
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            titlePadding: const EdgeInsets.all(10.0),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            buttonPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            title: Text(
              'Are you sure?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text('Do you want to exit the app?',
                style: Theme.of(context).textTheme.titleSmall),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => navigationRoutes.goBackToExitApp(),
                child: const Text('Yes'),
              ),
            ],
          ),
        ),
      );
    } else {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: const Text('Are you sure?'),
          content: const Text('Do you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        ),
      );
    }
  }
}
