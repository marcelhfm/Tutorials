import 'package:advisor/domain/failures/failures.dart';
import 'package:advisor/domain/repositories/theme_repo.dart';
import 'package:advisor/infrastructure/datasources/theme_local_datasource.dart';
import 'package:dartz/dartz.dart';

class ThemeRepositroyImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;
  ThemeRepositroyImpl({required this.themeLocalDatasource});

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    try {
      final themeMode = await themeLocalDatasource.getCachedThemeData();
      return Right(themeMode);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<void> setThemeMode({required bool mode}) {
    return themeLocalDatasource.cacheThemeData(mode: mode);
  }
}
