import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/domain/remote/pokemon_service.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

class PokemonRepository {
  final PokemonService _shipsService = getIt.get<PokemonService>();

  Future<PokemonServiceResponse> requestToGetPokemon(String url) async {
    PokemonServiceResponse pokemonServiceResponse =
        await _shipsService.requestToGetPokemon(url);

    if (pokemonServiceResponse.pokemonEntityList != null) {
      await savePokemon(pokemonServiceResponse.pokemonEntityList!);
    }
    return pokemonServiceResponse;
  }

  Future<void> savePokemon(List<PokemonEntity> pokemonEntityList) async {
    await PokemonEntity.savePokemonList(pokemonEntityList);
  }
}
