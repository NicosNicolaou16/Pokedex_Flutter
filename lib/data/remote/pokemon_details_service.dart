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
    try {
      final response = await getIt.get<Dio>().get(url);
      return PokemonDetailsServiceResponse(
        pokemonDetailsEntity: PokemonDetailsEntity.fromJson(response.data),
      );
    } on DioException catch (e) {
      return PokemonDetailsServiceResponse(dioException: e);
    } catch (e) {
      return PokemonDetailsServiceResponse(
          statusMessage: "Unexpected response: $e");
    }
  }
}
