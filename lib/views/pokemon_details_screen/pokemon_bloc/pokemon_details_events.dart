import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';

abstract class PokemonDetailsEvents {}

class PokemonDetailsFetchData extends PokemonDetailsEvents {
  final PokemonEntity pokemonEntity;

  PokemonDetailsFetchData({required this.pokemonEntity});
}
