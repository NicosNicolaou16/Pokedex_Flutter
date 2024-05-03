import 'package:pokedex_flutter/data/database/entities/pokemon_details_entity.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/data/database/entities/stats_entity.dart';

class PokemonDetailsDataModel {
  PokemonDetailsEntity? pokemonDetailsEntity;
  PokemonEntity? pokemonEntity;
  StatsEntity? statsEntity;
  final PokemonDetailsDataModelViewTypes pokemonDetailsDataModelViewTypes;

  PokemonDetailsDataModel({
    this.pokemonDetailsEntity,
    this.pokemonEntity,
    this.statsEntity,
    required this.pokemonDetailsDataModelViewTypes,
  });

  static Future<List<PokemonDetailsDataModel>> createPokemonDetailsDataModel(
      PokemonEntity pokemonEntity) async {
    List<PokemonDetailsDataModel> pokemonDetailsDataModelList = [];

    PokemonDetailsEntity? pokemonDetailsEntity =
        await PokemonDetailsEntity.getPokemonDetailsByName(
            pokemonEntity.name ?? "");

    pokemonDetailsDataModelList.add(PokemonDetailsDataModel(
        pokemonDetailsEntity: pokemonDetailsEntity,
        pokemonEntity: pokemonEntity,
        pokemonDetailsDataModelViewTypes:
            PokemonDetailsDataModelViewTypes.imageWithNameViewType));

    await Future.forEach(pokemonDetailsEntity?.statsEntityList ?? [], (stat) {
      pokemonDetailsDataModelList.add(PokemonDetailsDataModel(
          statsEntity: stat,
          pokemonDetailsDataModelViewTypes:
              PokemonDetailsDataModelViewTypes.statViewType));
    });

    return pokemonDetailsDataModelList;
  }
}

enum PokemonDetailsDataModelViewTypes {
  imageWithNameViewType,
  statViewType,
}
