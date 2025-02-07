import 'package:flutter/material.dart';
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
  Color? color;
  PokemonDetailsStatesEnum pokemonDetailsStatesEnum;

  PokemonDetailsStates({
    this.error,
    this.statusCode,
    this.color = Colors.transparent,
    this.pokemonDetailsDataModelList = const [],
    this.pokemonDetailsStatesEnum = PokemonDetailsStatesEnum.initial,
  });

  PokemonDetailsStates copyWith({
    String? error,
    int? statusCode,
    Color? color,
    List<PokemonDetailsDataModel>? pokemonDetailsDataModelList,
    required PokemonDetailsStatesEnum pokemonDetailsStatesEnum,
  }) {
    return PokemonDetailsStates(
      error: error ?? this.error,
      statusCode: statusCode ?? this.statusCode,
      color: color ?? this.color,
      pokemonDetailsDataModelList:
          pokemonDetailsDataModelList ?? this.pokemonDetailsDataModelList,
      pokemonDetailsStatesEnum: pokemonDetailsStatesEnum,
    );
  }
}
