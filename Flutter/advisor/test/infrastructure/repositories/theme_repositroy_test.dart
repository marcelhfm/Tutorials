import 'package:advisor/domain/failures/failures.dart';
import 'package:advisor/domain/repositories/theme_repo.dart';
import 'package:advisor/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advisor/infrastructure/exceptions/exceptions.dart';
import 'package:advisor/infrastructure/repositories/theme_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repositroy_test.mocks.dart';

@GenerateMocks([ThemeLocalDatasource])
void main() {
  late MockThemeLocalDatasource mockThemeLocalDatasource;
  late ThemeRepository themeRepository;

  setUp(() {
    mockThemeLocalDatasource = MockThemeLocalDatasource();
    themeRepository =
        ThemeRepositroyImpl(themeLocalDatasource: mockThemeLocalDatasource);
  });

  group("getThemeMode", () {
    const tThemeMode = true;
    test("should call function to cache themeMode in local ds", () {
      // arrange
      when(mockThemeLocalDatasource.cacheThemeData(mode: anyNamed("mode")))
          .thenAnswer((_) async => true);

      // act
      themeRepository.setThemeMode(mode: tThemeMode);

      // assert
      verify(mockThemeLocalDatasource.cacheThemeData(mode: tThemeMode));
    });
  });

  group("setThemeMode", () {
    const tThemeMode = true;

    test("should return theme mode if cached data is present", () async {
      //arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenAnswer((_) async => tThemeMode);

      //act
      final result = await themeRepository.getThemeMode();

      //assert
      verify(mockThemeLocalDatasource.getCachedThemeData());
      expect(result, const Right(tThemeMode));
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });

    test("should return CacheFailure if datasource throws CacheException",
        () async {
      //arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenThrow(CacheException());

      //act
      final result = await themeRepository.getThemeMode();

      //assert
      verify(mockThemeLocalDatasource.getCachedThemeData());
      expect(result, Left(CacheFailure()));
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
  });
}
