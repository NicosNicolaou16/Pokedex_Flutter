import 'package:drift/drift.dart';
import 'package:pokedex_flutter/data/database/database.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_details_entity.dart';
import 'package:pokedex_flutter/utils/get_it_dependencies_injection.dart';

@UseRowClass(StatsEntity)
class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get baseStat => integer().nullable()();

  TextColumn get statName => text().nullable()();

  TextColumn get pokemonName =>
      text().nullable().references(PokemonDetails, #name)();
}

class StatsEntity {
  int? id;
  int? baseStat;
  String? statName;
  String? pokemonName;

  StatsEntity({
    this.id,
    this.baseStat,
    this.statName,
    this.pokemonName,
  });

  StatsEntity.fromJson(Map<String, dynamic> json) {
    baseStat = json["base_stat"];
    statName = json["stat"]["name"];
  }

  static List<StatsEntity> fromJsonList(List json) {
    List<StatsEntity> shipEntityList;
    if (json != null) {
      shipEntityList =
          List<StatsEntity>.from(json.map((e) => StatsEntity.fromJson(e)))
              .toList();
    } else {
      return [];
    }
    return shipEntityList;
  }

  StatsCompanion toCompanion(
    String? pokemonName,
  ) {
    return StatsCompanion(
      baseStat: Value(baseStat ?? -1),
      statName: Value(statName ?? ""),
      pokemonName: Value(pokemonName),
    );
  }

  static Future<void> deleteAllStats(AppDb appDb) async {
    await appDb.delete(appDb.stats).go();
  }

  static Future<List<StatsEntity>> saveStats(
      List<StatsEntity> statsList, String pokemonName) async {
    AppDb appDb = getIt.get<AppDb>();
    await Future.forEach(statsList, (stat) async {
      await appDb
          .into(appDb.stats)
          .insertOnConflictUpdate(stat.toCompanion(pokemonName));
    });

    return statsList;
  }

  static Future<List<StatsEntity>> getPokemonStatsByName(String name) async {
    AppDb appDb = getIt.get<AppDb>();
    List<StatsEntity>? statsEntityList = await (appDb.select(appDb.stats)
          ..where((tbl) => tbl.pokemonName.equals(name)))
        .get();
    return statsEntityList;
  }
}
