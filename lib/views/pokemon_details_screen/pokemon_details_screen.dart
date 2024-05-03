import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/data/models/pokemon_details_data_model/pokemon_details_data_model.dart';
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
    return ListView.builder(
        itemCount:
            _pokemonDetailsBloc.state.pokemonDetailsDataModelList.length ?? 0,
        itemBuilder: (context, index) {
          PokemonDetailsDataModel pokemonDetailsDataModel =
              _pokemonDetailsBloc.state.pokemonDetailsDataModelList[index];
          if (pokemonDetailsDataModel.pokemonDetailsDataModelViewTypes ==
              PokemonDetailsDataModelViewTypes.imageWithNameViewType) {
            return Column(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      pokemonDetailsDataModel.pokemonEntity?.imageUrl ?? "",
                  imageBuilder: (context, imageProvider) {
                    //getImagePalette(imageProvider);
                    _pokemonDetailsBloc
                        .add(PokemonPaletteColor(imageProvider: imageProvider));
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.image),
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(pokemonDetailsDataModel.pokemonEntity?.name ?? ""),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        "${pokemonDetailsDataModel.pokemonDetailsEntity?.weight.toString()}Kg " ??
                            ""),
                  ],
                )
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child:
                      Text(pokemonDetailsDataModel.statsEntity?.statName ?? ""),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    tween: Tween<double>(
                      begin: 0,
                      end:
                          (pokemonDetailsDataModel.statsEntity?.baseStat ?? 0) /
                              100,
                    ),
                    builder: (context, value, _) => LinearProgressIndicator(
                      minHeight: 30,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      value: value,
                      color: _pokemonDetailsBloc.state.color,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          }
        });
  }
}
