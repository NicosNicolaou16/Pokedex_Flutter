import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/database/database.dart';

final getIt = GetIt.instance;

class GetItDependenciesInjection {
  void getItSetup() {
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<AppDb>(() => AppDb());
    //getIt.registerFactory<ShipsBloc>(() => ShipsBloc());
  }
}
