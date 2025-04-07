import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _prefs;

  ThemeCubit(this._prefs)
      : super(ThemeState(themeMode: _getThemeFromPrefs(_prefs)));

  static ThemeMode _getThemeFromPrefs(SharedPreferences prefs) {
    final themeMode = prefs.getString('theme_mode');
    switch (themeMode) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  void toggleDarkMode(bool enabled) async {
    final newMode = enabled ? ThemeMode.dark : ThemeMode.light;
    setThemeMode(newMode);
  }

  void setThemeMode(ThemeMode themeMode) async {
    await _prefs.setString('theme_mode', _modeToString(themeMode));
    emit(ThemeState(themeMode: themeMode));
  }

  static String _modeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }
}
