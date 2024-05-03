import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/data/models/pokemon_details_data_model/pokemon_details_data_model.dart';
import 'package:pokedex_flutter/data/repositories/pokemon_details_repository.dart';
import 'package:pokedex_flutter/data/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/utils/error_handling.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';
import 'package:pokedex_flutter/views/pokemon_details_screen/pokemon_bloc/pokemon_details_events.dart';
import 'package:pokedex_flutter/views/pokemon_details_screen/pokemon_bloc/pokemon_details_states.dart';
import 'package:pokedex_flutter/views/pokemon_list_screen/pokemon_bloc/pokemon_list_events.dart';
import 'package:pokedex_flutter/views/pokemon_list_screen/pokemon_bloc/pokemon_list_states.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvents, PokemonDetailsStates> {
  final PokemonDetailsRepository _pokemonDetailsRepository =
      getIt.get<PokemonDetailsRepository>();

  PokemonDetailsBloc() : super(PokemonDetailsStates()) {
    on<PokemonDetailsFetchData>(_onPokemonDetailsFetched);
  }

  Future<void> _onPokemonDetailsFetched(
    PokemonDetailsFetchData event,
    Emitter<PokemonDetailsStates> emit,
  ) async {
    emit(state.copyWith(
        pokemonDetailsStatesEnum: PokemonDetailsStatesEnum.loading));
    await _pokemonDetailsRepository
        .requestToGetPokemonDetails(event.pokemonEntity.url ?? "")
        .then((shipsServiceResponse) async {
      if (shipsServiceResponse.pokemonDetailsEntity != null) {
        emit(state.copyWith(
            pokemonDetailsStatesEnum: PokemonDetailsStatesEnum.loaded,
            pokemonDetailsDataModelList:
                await PokemonDetailsDataModel.createPokemonDetailsDataModel(
                    event.pokemonEntity)));
      } else {
        emit(state.copyWith(
          error: ErrorHandling.getErrorMessage(
              shipsServiceResponse.dioException,
              shipsServiceResponse.statusMessage,
              shipsServiceResponse.statusCode ?? -1),
          statusCode: -1,
          pokemonDetailsStatesEnum: PokemonDetailsStatesEnum.error,
        ));
      }
    });
  }
}
