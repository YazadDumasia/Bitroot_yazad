import 'package:bitroot/AppLocalization.dart';
import 'package:bitroot/bloc/bloc.dart';
import 'package:bitroot/bloc_providers.dart';
import 'package:bitroot/config/config.dart';
import 'package:bitroot/models/models.dart';
import 'package:bitroot/routing/routes.dart';
import 'package:bitroot/simple_bloc_observer.dart';
import 'package:bitroot/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  GestureBinding.instance.resamplingEnabled = true;
  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<LanguageModel> languages = LanguageModel.getLanguages();
    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiBlocProvider(
      providers: blocProviders,
      child: BlocConsumer<ThemeCubit, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return PageStorage(
            bucket: bucketGlobal,
            child: MaterialApp(
              title: Constants.appName,
              debugShowCheckedModeBanner: false,
              theme: theme.light(),
              darkTheme: theme.dark(),
              highContrastDarkTheme: theme.darkHighContrast(),
              highContrastTheme: theme.lightHighContrast(),
              themeMode: BlocProvider.of<ThemeCubit>(context).state
                      is ThemeUpdated
                  ? (BlocProvider.of<ThemeCubit>(context).state as ThemeUpdated)
                      .themeMode
                  : ThemeMode.system,
              themeAnimationCurve: Curves.linear,
              themeAnimationDuration: const Duration(seconds: 2),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    // elevatedButtonTheme: ElevatedButtonThemeData(
                    //   style: ElevatedButton.styleFrom(
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //     ),
                    //   ),
                    // ),
                    floatingActionButtonTheme: FloatingActionButtonThemeData(
                      iconSize: 25,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      contentPadding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 5, top: 5),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).disabledColor,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.error),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    dropdownMenuTheme:
                        Theme.of(context).dropdownMenuTheme.copyWith(
                              inputDecorationTheme:
                                  Theme.of(context).inputDecorationTheme,
                            ),
                  ),
                  child: child!,
                );
              },
              restorationScopeId: 'app',
              navigatorKey: navigatorKey,
              scrollBehavior: ScrollConfiguration.of(context).copyWith(
                multitouchDragStrategy: MultitouchDragStrategy.sumAllPointers,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.stylus
                },
              ),
              onGenerateRoute: RouteGenerator.generateRoute,
              initialRoute: RouteName.splashRoute,
              useInheritedMediaQuery: true,
              localizationsDelegates: [
                AppLocalizationsDelegate(languages),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: languages
                  .map((language) => Locale(language.code!, ''))
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
