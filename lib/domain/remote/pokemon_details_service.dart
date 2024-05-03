import 'package:dio/dio.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_details_entity.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

class PokemonDetailsServiceResponse {
  PokemonDetailsEntity? pokemonDetailsEntity;
  int? statusCode;
  String? statusMessage;
  DioException? dioException;

  PokemonDetailsServiceResponse({
    this.pokemonDetailsEntity,
    this.statusCode,
    this.statusMessage,
    this.dioException,
  });
}

class PokemonDetailsService {
  Future<PokemonDetailsServiceResponse> requestToGetPokemonDetails(
    String url,
  ) async {
    return getIt.get<Dio>().get(url).then((response) {
      if (response.statusCode! == 200 || response.statusCode! == 201) {
        return PokemonDetailsServiceResponse(
            pokemonDetailsEntity: PokemonDetailsEntity.fromJson(response.data));
      } else {
        return PokemonDetailsServiceResponse(
            statusMessage: response.statusMessage,
            statusCode: response.statusCode);
      }
    }).catchError((err) async {
      return PokemonDetailsServiceResponse(dioException: err as DioException);
    });
  }
}
