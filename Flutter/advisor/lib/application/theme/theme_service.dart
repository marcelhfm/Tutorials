import 'package:advisor/domain/repositories/theme_repo.dart';
import 'package:flutter/material.dart';

abstract class ThemeService extends ChangeNotifier {
  late bool isDarkModeOn;
  late bool useSystemTheme;
  Future<void> toggleTheme();
  Future<void> setTheme({required bool mode});
  Future<void> init();

  Future<void> toggleUseSystemTheme();
  Future<void> setUseSystemTheme({required bool useSystemTheme});
}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService {
  final ThemeRepository themeRepository;

  ThemeServiceImpl({required this.themeRepository});

  @override
  bool isDarkModeOn = true;

  @override
  bool useSystemTheme = false;

  @override
  Future<void> toggleTheme() async {
    isDarkModeOn = !isDarkModeOn;
    await setTheme(mode: isDarkModeOn);
  }

  @override
  Future<void> setTheme({required bool mode}) async {
    isDarkModeOn = mode;
    notifyListeners();
    await themeRepository.setThemeMode(mode: isDarkModeOn);
  }

  @override
  Future<void> setUseSystemTheme({required bool useSystemTheme}) async {
    useSystemTheme = useSystemTheme;
    notifyListeners();
    await themeRepository.setUseSystemTheme(useSystemTheme: useSystemTheme);
  }

  @override
  Future<void> toggleUseSystemTheme() async {
    useSystemTheme = !useSystemTheme;
    await setUseSystemTheme(useSystemTheme: useSystemTheme);
  }

  @override
  Future<void> init() async {
    final useSystemThemeOrFailure = await themeRepository.getUseSystemTheme();

    useSystemThemeOrFailure.fold(
      (failure) async {
        await setUseSystemTheme(useSystemTheme: false);
      },
      (useSystemTheme) async {
        await setUseSystemTheme(useSystemTheme: true);
      },
    );

    final modeOrFailure = await themeRepository.getThemeMode();

    modeOrFailure.fold((failure) {
      setTheme(mode: true);
    }, (mode) {
      setTheme(mode: mode);
    });
  }
}
