import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';

class PokemonDetailsDataModel {
  static Future<List<PokemonDetailsDataModel>> createPokemonDetailsDataModel(
      PokemonEntity pokemonEntity) async {
    List<PokemonDetailsDataModel> pokemonDetailsDataModelList = [];

    return pokemonDetailsDataModelList;
  }
}

enum PokemonDetailsDataModelViewTypes {
  imageWithNameViewType,
  statViewType,
}
