import 'package:pokedex_flutter/data/database/entities/pokemon_details_entity.dart';
import 'package:pokedex_flutter/domain/remote/pokemon_details_service.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

class PokemonDetailsRepository {
  final PokemonDetailsService _shipsService =
      getIt.get<PokemonDetailsService>();

  Future<PokemonDetailsServiceResponse> requestToGetPokemonDetails(String url) async {
    PokemonDetailsServiceResponse pokemonDetailsServiceResponse =
        await _shipsService.requestToGetPokemonDetails(url);

    if (pokemonDetailsServiceResponse.pokemonDetailsEntity != null) {
      await savePokemon(pokemonDetailsServiceResponse.pokemonDetailsEntity!);
    }
    return pokemonDetailsServiceResponse;
  }

  Future<void> savePokemon(PokemonDetailsEntity pokemonDetailsEntity) async {
    await PokemonDetailsEntity.savePokemonDetails(pokemonDetailsEntity);
  }
}
