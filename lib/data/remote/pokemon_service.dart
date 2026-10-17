import 'package:dio/dio.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

class PokemonServiceResponse {
  List<PokemonEntity>? pokemonEntityList;
  String? nextUrl;
  int? statusCode;
  String? statusMessage;
  DioException? dioException;

  PokemonServiceResponse({
    this.pokemonEntityList,
    this.nextUrl,
    this.statusCode,
    this.statusMessage,
    this.dioException,
  });
}

class PokemonService {
  Future<PokemonServiceResponse> requestToGetPokemon(String url) async {
    try {
      final response = await getIt.get<Dio>().get(url);
      return PokemonServiceResponse(
        pokemonEntityList:
            PokemonEntity.fromJsonList(response.data["results"] as List),
        nextUrl: response.data["next"] as String?,
      );
    } on DioException catch (e) {
      return PokemonServiceResponse(
          dioException: e, statusCode: e.response?.statusCode);
    } catch (e) {
      return PokemonServiceResponse(statusMessage: "Unexpected response: $e");
    }
  }
}
