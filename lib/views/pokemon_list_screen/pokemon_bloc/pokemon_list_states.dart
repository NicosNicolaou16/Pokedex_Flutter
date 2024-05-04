import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';

enum PokemonStatesEnum {
  initial,
  loading,
  loaded,
  error,
}

final class PokemonStates {
  String? error;
  int? statusCode;
  String? nextUrl;
  List<PokemonEntity>? pokemonEntityList;
  PokemonStatesEnum pokemonStatesEnum;

  PokemonStates({
    this.error,
    this.statusCode,
    this.nextUrl,
    this.pokemonEntityList = const [],
    this.pokemonStatesEnum = PokemonStatesEnum.initial,
  });

  PokemonStates copyWith({
    String? error,
    int? statusCode,
    String? nextUrl,
    List<PokemonEntity>? pokemonEntityList,
    required PokemonStatesEnum pokemonStatesEnum,
  }) {
    return PokemonStates(
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      nextUrl: nextUrl,
      pokemonEntityList: pokemonEntityList ?? this.pokemonEntityList,
      pokemonStatesEnum: pokemonStatesEnum,
    );
  }
}
