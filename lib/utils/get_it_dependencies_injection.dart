import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/database/database.dart';
import 'package:pokedex_flutter/domain/remote/pokemon_details_service.dart';
import 'package:pokedex_flutter/domain/remote/pokemon_service.dart';

final getIt = GetIt.instance;

class GetItDependenciesInjection {
  void getItSetup() {
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<AppDb>(() => AppDb());
    getIt.registerFactory<PokemonService>(() => PokemonService());
    getIt.registerFactory<PokemonDetailsService>(() => PokemonDetailsService());
  }
}
