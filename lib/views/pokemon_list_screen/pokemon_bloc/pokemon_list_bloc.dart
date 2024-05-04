import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/data/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/utils/error_handling.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';
import 'package:pokedex_flutter/views/pokemon_list_screen/pokemon_bloc/pokemon_list_events.dart';
import 'package:pokedex_flutter/views/pokemon_list_screen/pokemon_bloc/pokemon_list_states.dart';

class PokemonListBloc extends Bloc<PokemonEvents, PokemonStates> {
  final PokemonRepository _pokemonRepository = getIt.get<PokemonRepository>();

  PokemonListBloc() : super(PokemonStates()) {
    on<PokemonListFetchData>(_onPokemonListFetched);
    on<Offline>(_offline);
  }

  Future<void> _onPokemonListFetched(
    PokemonListFetchData event,
    Emitter<PokemonStates> emit,
  ) async {
    emit(state.copyWith(pokemonStatesEnum: PokemonStatesEnum.loading));
    await _pokemonRepository
        .requestToGetPokemon("")
        .then((pokemonServiceResponse) async {
      if (pokemonServiceResponse.pokemonEntityList != null) {
        emit(state.copyWith(
            pokemonStatesEnum: PokemonStatesEnum.loaded,
            pokemonEntityList: pokemonServiceResponse.pokemonEntityList));
      } else {
        emit(state.copyWith(
          error: ErrorHandling.getErrorMessage(
              pokemonServiceResponse.dioException,
              pokemonServiceResponse.statusMessage,
              pokemonServiceResponse.statusCode ?? -1),
          statusCode: -1,
          pokemonStatesEnum: PokemonStatesEnum.error,
        ));
      }
    });
  }

  FutureOr<void> _offline(Offline event, Emitter<PokemonStates> emit) async {
    List<PokemonEntity> pokemonEntityList = await PokemonEntity.getAllPokemon();
    emit(state.copyWith(
        pokemonStatesEnum: PokemonStatesEnum.loaded,
        pokemonEntityList: pokemonEntityList));
  }
}
