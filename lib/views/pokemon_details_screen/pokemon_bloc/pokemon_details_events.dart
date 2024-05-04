import 'package:flutter/cupertino.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';

abstract class PokemonDetailsEvents {}

class PokemonDetailsFetchData extends PokemonDetailsEvents {
  final PokemonEntity pokemonEntity;

  PokemonDetailsFetchData({required this.pokemonEntity});
}

class PokemonPaletteColor extends PokemonDetailsEvents {
  final ImageProvider imageProvider;

  PokemonPaletteColor({required this.imageProvider});
}

class Offline extends PokemonDetailsEvents {
  final PokemonEntity pokemonEntity;

  Offline({
    required this.pokemonEntity,
  });
}
