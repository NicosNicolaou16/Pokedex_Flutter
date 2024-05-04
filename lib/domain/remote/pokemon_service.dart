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
    return getIt
        .get<Dio>()
        .get(url)
        .then((response) {
      if (response.statusCode! == 200 || response.statusCode! == 201) {
        return PokemonServiceResponse(
            pokemonEntityList:
                PokemonEntity.fromJsonList(response.data["results"]),
            nextUrl: response.data["next"]);
      } else {
        return PokemonServiceResponse(
            statusMessage: response.statusMessage,
            statusCode: response.statusCode);
      }
    }).catchError((err) async {
      return PokemonServiceResponse(dioException: err as DioException);
    });
  }
}
