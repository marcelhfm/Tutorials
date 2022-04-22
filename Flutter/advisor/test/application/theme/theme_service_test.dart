import 'package:advisor/application/theme/theme_service.dart';
import 'package:advisor/domain/failures/failures.dart';
import 'package:advisor/domain/repositories/theme_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_service_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  late MockThemeRepository mockThemeRepository;
  late ThemeService themeService;
  late int listenerCount;

  setUp(() {
    listenerCount = 0;
    mockThemeRepository = MockThemeRepository();
    themeService = ThemeServiceImpl(themeRepository: mockThemeRepository)
      ..addListener(() {
        listenerCount += 1;
      });
  });

  test('check if default mode is darkmode', () {
    // assert
    expect(themeService.isDarkModeOn, true);
  });

  group("setTheme", () {
    const tMode = false;

    test("should set theme to the parameter given", () async {
      // arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // act
      await themeService.setTheme(mode: tMode);

      // assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);
    });
  });

  group("toggleTheme", () {
    const tMode = false;

    test("should toggle themeMode, store theme information", () async {
      // arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // act
      await themeService.toggleTheme();

      // assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);
    });
  });

  group("init", () {
    const tMode = false;

    test("should get themeMode from local datasource", () async {
      // arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => const Right(tMode));

      // act
      await themeService.init();

      // assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });

    test("should start with darkMode if no theme is returned from localDs",
        () async {
      // arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => Left(CacheFailure()));

      // act
      await themeService.init();

      // assert
      expect(themeService.isDarkModeOn, true);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });
  });
}
