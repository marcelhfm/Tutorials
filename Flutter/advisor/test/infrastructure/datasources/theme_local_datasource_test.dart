import 'package:advisor/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advisor/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late ThemeLocalDatasource themeLocalDatasource;
  late MockSharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    themeLocalDatasource = ThemeLocalDatasourceImpl(
      sharedPreferences: sharedPreferences,
    );
  });

  group("getCachedThemeData", () {
    const tThemeData = true;
    test("should return a bool (themeData) if there is one stored", () async {
      // arrange
      when(sharedPreferences.getBool(any)).thenReturn(tThemeData);

      // act
      final result = await themeLocalDatasource.getCachedThemeData();

      // assert
      verify(sharedPreferences.getBool(CACHE_THEME_MODE));
      expect(result, tThemeData);
    });

    test("should return CacheException if there is no data stored", () {
      // arrange
      when(sharedPreferences.getBool(any)).thenReturn(null);

      // act
      final call = themeLocalDatasource.getCachedThemeData;

      // assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group("cacheThemeData", () {
    const tThemeData = true;

    test("should call sharedPreferences to cache themeMode", () {
      when(sharedPreferences.setBool(any, any)).thenAnswer((_) async => true);

      //act
      themeLocalDatasource.cacheThemeData(mode: tThemeData);

      //assert
      verify(sharedPreferences.setBool(CACHE_THEME_MODE, tThemeData));
    });
  });
}
