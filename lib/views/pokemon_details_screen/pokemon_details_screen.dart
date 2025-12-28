import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percentages_with_animation/percentages_with_animation.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/data/models/pokemon_details_data_model/pokemon_details_data_model.dart';
import 'package:pokedex_flutter/utils/alerts_dialog/alerts_dialog.dart';
import 'package:pokedex_flutter/utils/extensions/extensions.dart';
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

  void _init(BuildContext context) {
    _pokemonDetailsBloc.add(Offline(pokemonEntity: widget.pokemonEntity));
    _pokemonDetailsBloc
        .add(PokemonDetailsFetchData(pokemonEntity: widget.pokemonEntity));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
    );
  }

  Widget _states(PokemonDetailsStates state, BuildContext context) {
    if (state.pokemonDetailsStatesEnum == PokemonDetailsStatesEnum.initial) {
      _init(context);
    } else if (state.pokemonDetailsStatesEnum ==
        PokemonDetailsStatesEnum.loading) {
      return Stack(
        children: [
          _mainView(context),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      );
    }
    return Stack(
      children: [
        _mainView(context),
      ],
    );
  }

  Widget _mainView(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: _pokemonDetailsBloc.state.color,
      ),
      child: Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: _pokemonDetailsBloc.state.color,
          title: const Text(
            "Pokemon Details",
            style: TextStyle(
              fontSize: 21,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount:
                _pokemonDetailsBloc.state.pokemonDetailsDataModelList.length,
            itemBuilder: (context, index) {
              PokemonDetailsDataModel pokemonDetailsDataModel =
                  _pokemonDetailsBloc.state.pokemonDetailsDataModelList[index];
              if (pokemonDetailsDataModel.pokemonDetailsDataModelViewTypes ==
                  PokemonDetailsDataModelViewTypes.imageWithNameViewType) {
                return _imageAndNameView(pokemonDetailsDataModel);
              } else {
                return _statsView(pokemonDetailsDataModel);
              }
            }),
      ),
    );
  }

  Widget _imageAndNameView(PokemonDetailsDataModel pokemonDetailsDataModel) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: _pokemonDetailsBloc.state.color,
          child: Padding(
            padding: const EdgeInsets.only(top: 130.0),
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Hero(
              tag: pokemonDetailsDataModel.pokemonEntity?.imageUrl ?? "",
              child: CachedNetworkImage(
                imageUrl: pokemonDetailsDataModel.pokemonEntity?.imageUrl ?? "",
                imageBuilder: (context, imageProvider) {
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
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  pokemonDetailsDataModel.pokemonEntity?.name
                          ?.upperCaseFirstLetter() ??
                      "",
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  " - ${pokemonDetailsDataModel.pokemonDetailsEntity?.weight.toString() ?? ""}Kg",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _statsView(PokemonDetailsDataModel pokemonDetailsDataModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            pokemonDetailsDataModel.statsEntity?.statName
                    ?.upperCaseFirstLetter() ??
                "",
            style: const TextStyle(color: Colors.white, fontSize: 19),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearPercentage(
            currentPercentage:
                pokemonDetailsDataModel.statsEntity?.baseStat?.toDouble() ?? 0,
            maxPercentage: pokemonDetailsDataModel.maxValue?.toDouble() ?? 0,
            backgroundHeight: 30,
            percentageHeight: 30,
            backgroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            percentageDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: _pokemonDetailsBloc.state.color,
            ),
            leftRightText: LeftRightText.leftOnly,
            leftTextStyle: TextStyle(
              color: _pokemonDetailsBloc.state.color,
              fontSize: 19,
            ),
          ),
        ),
      ],
    );
  }
}
