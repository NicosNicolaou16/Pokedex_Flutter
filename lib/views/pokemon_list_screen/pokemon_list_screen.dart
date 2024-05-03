import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/utils/alerts_dialog/alerts_dialog.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';
import 'package:pokedex_flutter/views/pokemon_details_screen/pokemon_details_screen.dart';
import 'package:pokedex_flutter/views/pokemon_list_screen/pokemon_bloc/pokemon_list_bloc.dart';
import 'package:pokedex_flutter/views/pokemon_list_screen/pokemon_bloc/pokemon_list_events.dart';
import 'package:pokedex_flutter/views/pokemon_list_screen/pokemon_bloc/pokemon_list_states.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final PokemonListBloc _pokemonListBloc = getIt.get<PokemonListBloc>();

  _init(BuildContext context) {
    _pokemonListBloc.add(PokemonListFetchData());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text(
            "Pokemon List",
            style: TextStyle(
              fontSize: 21,
            ),
          ),
        ),
        body: BlocProvider(
          create: (_) => _pokemonListBloc,
          child: BlocConsumer<PokemonListBloc, PokemonStates>(
            listener: (context, state) {
              if (state.pokemonStatesEnum == PokemonStatesEnum.error) {
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

  Widget _states(PokemonStates state, BuildContext context) {
    if (state.pokemonStatesEnum == PokemonStatesEnum.initial) {
      _init(context);
    } else if (state.pokemonStatesEnum == PokemonStatesEnum.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return _mainView(context);
  }

  Widget _mainView(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      padding: const EdgeInsets.all(8.0), // padding around the grid
      itemCount: _pokemonListBloc.state.pokemonEntityList?.length ?? 0,
      itemBuilder: (context, index) {
        PokemonEntity pokemonEntity =
            _pokemonListBloc.state.pokemonEntityList![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PokemonDetailsScreen(
                        pokemonEntity: pokemonEntity,
                      )),
            );
          },
          child: Card(
            elevation: 9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.green,
            child: CachedNetworkImage(
              imageUrl: pokemonEntity.imageUrl ?? "",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.image),
              height: 150,
              width: 150,
            ),
          ),
        );
      },
    );
  }
}
