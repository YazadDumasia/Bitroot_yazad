import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4283328048),
      surfaceTint: Color(4283328048),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4287276392),
      onPrimaryContainer: Color(4278587392),
      secondary: Color(4283061054),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285429856),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4280445527),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4284852628),
      onTertiaryContainer: Color(4278194443),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294638322),
      onSurface: Color(4279966744),
      onSurfaceVariant: Color(4282665021),
      outline: Color(4285888876),
      outlineVariant: Color(4291152057),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348396),
      inversePrimary: Color(4290039951),
      primaryFixed: Color(4291882153),
      onPrimaryFixed: Color(4279246848),
      primaryFixedDim: Color(4290039951),
      onPrimaryFixedVariant: Color(4281814299),
      secondaryFixed: Color(4292667082),
      onSecondaryFixed: Color(4279639565),
      secondaryFixedDim: Color(4290824879),
      onSecondaryFixedVariant: Color(4282403381),
      tertiaryFixed: Color(4289393113),
      onTertiaryFixed: Color(4278198296),
      tertiaryFixedDim: Color(4287616189),
      onTertiaryFixedVariant: Color(4278210880),
      surfaceDim: Color(4292598483),
      surfaceBright: Color(4294638322),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294309100),
      surfaceContainer: Color(4293914342),
      surfaceContainerHigh: Color(4293519585),
      surfaceContainerHighest: Color(4293125083),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281551127),
      surfaceTint: Color(4283328048),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4284709956),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282205745),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285429856),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278209596),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282155117),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294638322),
      onSurface: Color(4279966744),
      onSurfaceVariant: Color(4282401849),
      outline: Color(4284309845),
      outlineVariant: Color(4286086255),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348396),
      inversePrimary: Color(4290039951),
      primaryFixed: Color(4284709956),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283130670),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285429856),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283850569),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282155117),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4280248149),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292598483),
      surfaceBright: Color(4294638322),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294309100),
      surfaceContainer: Color(4293914342),
      surfaceContainerHigh: Color(4293519585),
      surfaceContainerHighest: Color(4293125083),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4279576320),
      surfaceTint: Color(4283328048),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4281551127),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280034579),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282205745),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200350),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278209596),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294638322),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280362268),
      outline: Color(4282401849),
      outlineVariant: Color(4282401849),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281348396),
      inversePrimary: Color(4292474546),
      primaryFixed: Color(4281551127),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280168963),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282205745),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280758045),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278209596),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278203432),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292598483),
      surfaceBright: Color(4294638322),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294309100),
      surfaceContainer: Color(4293914342),
      surfaceContainerHigh: Color(4293519585),
      surfaceContainerHighest: Color(4293125083),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290039951),
      surfaceTint: Color(4290039951),
      onPrimary: Color(4280366598),
      primaryContainer: Color(4284709956),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4290824879),
      onSecondary: Color(4280955680),
      secondaryContainer: Color(4285364063),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4287616189),
      onTertiary: Color(4278204459),
      tertiaryContainer: Color(4282155116),
      onTertiaryContainer: Color(4294967295),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279374864),
      onSurface: Color(4293125083),
      onSurfaceVariant: Color(4291152057),
      outline: Color(4287599237),
      outlineVariant: Color(4282665021),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293125083),
      inversePrimary: Color(4283328048),
      primaryFixed: Color(4291882153),
      onPrimaryFixed: Color(4279246848),
      primaryFixedDim: Color(4290039951),
      onPrimaryFixedVariant: Color(4281814299),
      secondaryFixed: Color(4292667082),
      onSecondaryFixed: Color(4279639565),
      secondaryFixedDim: Color(4290824879),
      onSecondaryFixedVariant: Color(4282403381),
      tertiaryFixed: Color(4289393113),
      onTertiaryFixed: Color(4278198296),
      tertiaryFixedDim: Color(4287616189),
      onTertiaryFixedVariant: Color(4278210880),
      surfaceDim: Color(4279374864),
      surfaceBright: Color(4281874997),
      surfaceContainerLowest: Color(4279045899),
      surfaceContainerLow: Color(4279966744),
      surfaceContainer: Color(4280229916),
      surfaceContainerHigh: Color(4280887846),
      surfaceContainerHighest: Color(4281611568),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4290303123),
      surfaceTint: Color(4290039951),
      onPrimary: Color(4278983168),
      primaryContainer: Color(4286552414),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291088307),
      onSecondary: Color(4279310600),
      secondaryContainer: Color(4287272059),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4287879361),
      onTertiary: Color(4278197011),
      tertiaryContainer: Color(4284063112),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374864),
      onSurface: Color(4294769651),
      onSurfaceVariant: Color(4291415230),
      outline: Color(4288783511),
      outlineVariant: Color(4286678392),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293125083),
      inversePrimary: Color(4281880348),
      primaryFixed: Color(4291882153),
      onPrimaryFixed: Color(4278785024),
      primaryFixedDim: Color(4290039951),
      onPrimaryFixedVariant: Color(4280761355),
      secondaryFixed: Color(4292667082),
      onSecondaryFixed: Color(4278981380),
      secondaryFixedDim: Color(4290824879),
      onSecondaryFixedVariant: Color(4281350437),
      tertiaryFixed: Color(4289393113),
      onTertiaryFixed: Color(4278195471),
      tertiaryFixedDim: Color(4287616189),
      onTertiaryFixedVariant: Color(4278206001),
      surfaceDim: Color(4279374864),
      surfaceBright: Color(4281874997),
      surfaceContainerLowest: Color(4279045899),
      surfaceContainerLow: Color(4279966744),
      surfaceContainer: Color(4280229916),
      surfaceContainerHigh: Color(4280887846),
      surfaceContainerHighest: Color(4281611568),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294246367),
      surfaceTint: Color(4290039951),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4290303123),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294246369),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291088307),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293787638),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4287879361),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279374864),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294573293),
      outline: Color(4291415230),
      outlineVariant: Color(4291415230),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293125083),
      inversePrimary: Color(4279971585),
      primaryFixed: Color(4292145581),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4290303123),
      onPrimaryFixedVariant: Color(4278983168),
      secondaryFixed: Color(4292930510),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291088307),
      onSecondaryFixedVariant: Color(4279310600),
      tertiaryFixed: Color(4289721821),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4287879361),
      onTertiaryFixedVariant: Color(4278197011),
      surfaceDim: Color(4279374864),
      surfaceBright: Color(4281874997),
      surfaceContainerLowest: Color(4279045899),
      surfaceContainerLow: Color(4279966744),
      surfaceContainer: Color(4280229916),
      surfaceContainerHigh: Color(4280887846),
      surfaceContainerHighest: Color(4281611568),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colorScheme.primary,
          selectionColor: colorScheme.primary.withOpacity(0.7),
          selectionHandleColor: colorScheme.primary,
        ),
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          titleTextStyle: textTheme.titleLarge!.copyWith(color: Colors.white),
          backgroundColor: colorScheme.primary,
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 24.0,
          ),
          actionsIconTheme: const IconThemeData(
            color: Colors.white,
            size: 24.0,
          ),
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
        dividerColor: colorScheme.primary,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
