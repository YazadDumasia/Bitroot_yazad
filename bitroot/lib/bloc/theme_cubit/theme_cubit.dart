import 'package:bitroot/utils/components/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeUpdated(themeMode: ThemeMode.system)) {
    _loadTheme(); // Automatically load the theme when the cubit is created
  }

  // Updates the theme and saves it in SharedPreferences
  Future<void> updateTheme(ThemeMode newThemeMode) async {
    final prefs = await SharedPreferences.getInstance();

    // Save the selected theme mode in SharedPreferences
    await prefs.setString(Constants.prefThemeModeKey, newThemeMode.toString());

    emit(ThemeUpdated(themeMode: newThemeMode));
  }

  // Loads the theme from SharedPreferences and emits the appropriate state
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the saved theme mode from SharedPreferences
    final themeModeString = prefs.getString(Constants.prefThemeModeKey) ??
        ThemeMode.system.toString();

    // Parse the themeModeString to the appropriate ThemeMode enum
    final ThemeMode loadedThemeMode;
    switch (themeModeString) {
      case 'ThemeMode.dark':
        loadedThemeMode = ThemeMode.dark;
        break;
      case 'ThemeMode.light':
        loadedThemeMode = ThemeMode.light;
        break;
      default:
        loadedThemeMode = ThemeMode.system;
    }

    emit(ThemeUpdated(themeMode: loadedThemeMode));
  }

  // Cycles through the three theme modes: light, dark, and system
  Future<void> cycleThemeMode() async {
    final currentThemeMode = (state as ThemeUpdated).themeMode;
    final ThemeMode nextThemeMode;

    // Determine the next theme mode in the cycle
    switch (currentThemeMode) {
      case ThemeMode.dark:
        nextThemeMode = ThemeMode.light;
        break;
      case ThemeMode.light:
        nextThemeMode = ThemeMode.system;
        break;
      default:
        nextThemeMode = ThemeMode.dark;
    }
    await updateTheme(nextThemeMode);
  }
}
