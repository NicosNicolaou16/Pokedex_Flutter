import 'package:pokedex_flutter/data/database/entities/pokemon_details_entity.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/data/models/pokemon_details_data_model/pokemon_details_data_model.dart';

enum PokemonDetailsStatesEnum {
  initial,
  loading,
  loaded,
  error,
}

final class PokemonDetailsStates {
  String? error;
  int? statusCode;
  List<PokemonDetailsDataModel> pokemonDetailsDataModelList;
  PokemonDetailsStatesEnum pokemonDetailsStatesEnum;

  PokemonDetailsStates({
    this.error,
    this.statusCode,
    this.pokemonDetailsDataModelList = const [],
    this.pokemonDetailsStatesEnum = PokemonDetailsStatesEnum.initial,
  });

  PokemonDetailsStates copyWith({
    String? error,
    int? statusCode,
    List<PokemonDetailsDataModel>? pokemonDetailsDataModelList,
    required PokemonDetailsStatesEnum pokemonDetailsStatesEnum,
  }) {
    return PokemonDetailsStates(
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      pokemonDetailsDataModelList:
          pokemonDetailsDataModelList ?? this.pokemonDetailsDataModelList,
      pokemonDetailsStatesEnum: pokemonDetailsStatesEnum,
    );
  }
}
