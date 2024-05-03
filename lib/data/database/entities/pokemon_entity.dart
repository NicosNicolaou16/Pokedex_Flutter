import 'package:drift/drift.dart';
import 'package:pokedex_flutter/data/database/database.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

const String baseImageUrl =
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/";
const String pngFormat = ".png";

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

  static List<PokemonEntity> fromJsonList(List json) {
    List<PokemonEntity> shipEntityList;
    if (json != null) {
      shipEntityList =
          List<PokemonEntity>.from(json.map((e) => PokemonEntity.fromJson(e)))
              .toList();
    } else {
      return [];
    }
    return shipEntityList;
  }

  PokemonCompanion toCompanion(String? imageUrl, int? order) {
    return PokemonCompanion(
      name: Value(name ?? ""),
      url: Value(url ?? ""),
      imageUrl: Value(imageUrl),
      order: Value(order),
    );
  }

  static Future<List<PokemonEntity>> savePokemonList(
      List<PokemonEntity> pokemonList) async {
    AppDb appDb = getIt.get<AppDb>();
    await Future.forEach(pokemonList, (pokemon) {
      _buildImageUrl(pokemon);
      appDb.into(appDb.pokemon).insertOnConflictUpdate(
          pokemon.toCompanion(pokemon.imageUrl, pokemon.order));
    });

    return pokemonList;
  }

  static Future<void> _buildImageUrl(PokemonEntity pokemonEntity) async {
    RegExp exp = RegExp(r'/([0-9]/*)');
    RegExpMatch? match = exp.firstMatch(pokemonEntity.url ?? "");
    String? pokemonIdAsString = match?.group(1);
    if (pokemonIdAsString != null &&
        pokemonIdAsString.isNotEmpty &&
        _isNumericUsingRegularExpression(pokemonIdAsString) == true) {
      pokemonEntity.order = int.tryParse(pokemonIdAsString);
      pokemonEntity.imageUrl =
          "$baseImageUrl${match?.group(1) ?? ''}$pngFormat";
    }
  }

  static bool _isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }
}
