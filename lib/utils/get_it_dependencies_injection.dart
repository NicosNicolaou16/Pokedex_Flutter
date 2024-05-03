import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_flutter/data/database/database.dart';
import 'package:pokedex_flutter/data/repositories/pokemon_details_repository.dart';
import 'package:pokedex_flutter/data/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/domain/remote/pokemon_details_service.dart';
import 'package:pokedex_flutter/domain/remote/pokemon_service.dart';
import 'package:pokedex_flutter/views/pokemon_details_screen/pokemon_bloc/pokemon_details_bloc.dart';
import 'package:pokedex_flutter/views/pokemon_list_screen/pokemon_bloc/pokemon_list_bloc.dart';

final getIt = GetIt.instance;

class GetItDependenciesInjection {
  void getItSetup() {
    getIt.registerLazySingleton<Dio>(() => Dio());
    getIt.registerLazySingleton<AppDb>(() => AppDb());
    getIt.registerFactory<PokemonService>(() => PokemonService());
    getIt.registerFactory<PokemonDetailsService>(() => PokemonDetailsService());
    getIt.registerFactory<PokemonRepository>(() => PokemonRepository());
    getIt.registerFactory<PokemonListBloc>(() => PokemonListBloc());
    getIt.registerFactory<PokemonDetailsBloc>(() => PokemonDetailsBloc());
    getIt.registerFactory<PokemonDetailsRepository>(
        () => PokemonDetailsRepository());
  }
}
