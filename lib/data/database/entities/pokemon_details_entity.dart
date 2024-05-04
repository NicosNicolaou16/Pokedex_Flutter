import 'package:drift/drift.dart';
import 'package:pokedex_flutter/data/database/database.dart';
import 'package:pokedex_flutter/data/database/entities/stats_entity.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

@UseRowClass(PokemonDetailsEntity)
class PokemonDetails extends Table {
  TextColumn get name => text()();

  IntColumn get weight => integer().nullable()();

  @override
  Set<Column>? get primaryKey => {name};
}

class PokemonDetailsEntity {
  String? name;
  int? weight;
  List<StatsEntity>? statsEntityList;

  PokemonDetailsEntity({
    this.name,
    this.weight,
    this.statsEntityList,
  });

  PokemonDetailsEntity.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    weight = json["weight"];
    statsEntityList = StatsEntity.fromJsonList(json["stats"]);
  }

  PokemonDetailsCompanion toCompanion() {
    return PokemonDetailsCompanion(
      name: Value(name ?? ""),
      weight: Value(weight ?? -1),
    );
  }

  static Future<void> deleteAllPokemonDetails(AppDb appDb) async {
    await appDb.delete(appDb.pokemonDetails).go();
  }

  static Future<PokemonDetailsEntity> savePokemonDetails(
    PokemonDetailsEntity pokemonDetailsEntity,
  ) async {
    AppDb appDb = getIt.get<AppDb>();
    await StatsEntity.deleteAllStats(appDb);
    await appDb
        .into(appDb.pokemonDetails)
        .insertOnConflictUpdate(pokemonDetailsEntity.toCompanion());
    if (pokemonDetailsEntity.statsEntityList != null &&
        pokemonDetailsEntity.name != null) {
      await StatsEntity.saveStats(
          pokemonDetailsEntity.statsEntityList!, pokemonDetailsEntity.name!);
    }

    return pokemonDetailsEntity;
  }

  static Future<PokemonDetailsEntity?> getPokemonDetailsByName(
      String name) async {
    AppDb appDb = getIt.get<AppDb>();
    PokemonDetailsEntity? pokemonDetailsEntity =
        await (appDb.select(appDb.pokemonDetails)
              ..where((tbl) => tbl.name.equals(name)))
            .getSingleOrNull();
    pokemonDetailsEntity?.statsEntityList =
        await StatsEntity.getPokemonStatsByName(name);
    return pokemonDetailsEntity;
  }
}
