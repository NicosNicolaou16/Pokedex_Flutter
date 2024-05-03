import 'package:drift/drift.dart';
import 'package:pokedex_flutter/data/database/database.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

const String baseImageUrl =
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/";

@UseRowClass(PokemonEntity)
class Pokemon extends Table {
  TextColumn get name => text()();

  TextColumn get url => text().nullable()();

  TextColumn get imageUrl => text().nullable()();

  IntColumn get order => integer().nullable()();

  @override
  Set<Column>? get primaryKey => {name};
}

class PokemonEntity {
  String? name;
  String? url;
  String? imageUrl;
  int? order;

  PokemonEntity({
    this.name,
    this.url,
    this.imageUrl,
    this.order,
  });

  PokemonEntity.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    url = json["url"];
  }

  PokemonCompanion toCompanion(String? imageUrl, int? order) {
    return PokemonCompanion(
      name: Value(name ?? ""),
      url: Value(url ?? ""),
      imageUrl: Value(imageUrl),
      order: Value(order),
    );
  }

  Future<List<PokemonEntity>> savePokemonList(
      List<PokemonEntity> pokemonList) async {
    AppDb appDb = getIt.get<AppDb>();
    await Future.forEach(pokemonList, (pokemon) {
      appDb
          .into(appDb.pokemon)
          .insertOnConflictUpdate(pokemon.toCompanion(pokemon.imageUrl, pokemon.order));
    });

    return pokemonList;
  }

  Future<void> buildImageUrl(PokemonEntity pokemonEntity) async {}
}
