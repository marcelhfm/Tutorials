import 'package:advisor/infrastructure/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: constant_identifier_names
const CACHE_THEME_MODE = 'CACHE_THEME_MODE';
const CACHE_USE_SYSTEM_THEME = 'CACHE_USE_SYSTEM_THEME';

abstract class ThemeLocalDatasource {
  Future<bool> getUseSystemTheme();
  Future<void> cacheUseSystemTheme({required bool useSystemTheme});

  Future<bool> getCachedThemeData();
  Future<void> cacheThemeData({required bool mode});
}

class ThemeLocalDatasourceImpl implements ThemeLocalDatasource {
  final SharedPreferences sharedPreferences;
  ThemeLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheThemeData({required bool mode}) {
    return sharedPreferences.setBool(CACHE_THEME_MODE, mode);
  }

  @override
  Future<bool> getCachedThemeData() {
    final modeBool = sharedPreferences.getBool(CACHE_THEME_MODE);

    if (modeBool != null) {
      return Future.value(modeBool);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUseSystemTheme({required bool useSystemTheme}) {
    return sharedPreferences.setBool(CACHE_USE_SYSTEM_THEME, useSystemTheme);
  }

  @override
  Future<bool> getUseSystemTheme() {
    final useSystemTheme = sharedPreferences.getBool(CACHE_USE_SYSTEM_THEME);

    if (useSystemTheme != null) {
      return Future.value(useSystemTheme);
    } else {
      throw CacheException();
    }
  }
}
