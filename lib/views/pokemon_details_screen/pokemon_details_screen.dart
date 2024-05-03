import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/utils/alerts_dialog/alerts_dialog.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';
import 'package:pokedex_flutter/views/pokemon_details_screen/pokemon_bloc/pokemon_details_bloc.dart';
import 'package:pokedex_flutter/views/pokemon_details_screen/pokemon_bloc/pokemon_details_events.dart';
import 'package:pokedex_flutter/views/pokemon_details_screen/pokemon_bloc/pokemon_details_states.dart';

class PokemonDetailsScreen extends StatefulWidget {
  final PokemonEntity pokemonEntity;

  const PokemonDetailsScreen({super.key, required this.pokemonEntity});

  @override
  State<PokemonDetailsScreen> createState() => _PokemonDetailsScreenState();
}

class _PokemonDetailsScreenState extends State<PokemonDetailsScreen> {
  final PokemonDetailsBloc _pokemonDetailsBloc =
      getIt.get<PokemonDetailsBloc>();

  _init(BuildContext context) {
    _pokemonDetailsBloc
        .add(PokemonDetailsFetchData(pokemonEntity: widget.pokemonEntity));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Pokemon Details",
            style: TextStyle(
              fontSize: 21,
            ),
          ),
        ),
        body: BlocProvider(
          create: (_) => _pokemonDetailsBloc,
          child: BlocConsumer<PokemonDetailsBloc, PokemonDetailsStates>(
            listener: (context, state) {
              if (state.pokemonDetailsStatesEnum ==
                  PokemonDetailsStatesEnum.error) {
                AlertsDialog.showAlertDialog(state.error ?? "", context);
              }
            },
            builder: (context, state) {
              return _states(state, context);
            },
          ),
        ),
      ),
    );
  }

  Widget _states(PokemonDetailsStates state, BuildContext context) {
    if (state.pokemonDetailsStatesEnum == PokemonDetailsStatesEnum.initial) {
      _init(context);
    } else if (state.pokemonDetailsStatesEnum ==
        PokemonDetailsStatesEnum.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return _mainView(context);
  }

  Widget _mainView(BuildContext context) {
    return Container();
  }
}
