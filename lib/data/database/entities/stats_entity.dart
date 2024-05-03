import 'package:drift/drift.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_details_entity.dart';

@UseRowClass(StatsEntity)
class Stats extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get baseStat => text().nullable()();

  TextColumn get statName => text().nullable()();

  TextColumn get pokemonName => text().nullable().references(PokemonDetails, #name)();
}

class StatsEntity {
  int? id;
  String? baseStat;
  String? statName;
  String? pokemonName;

  StatsEntity({
    this.id,
    this.baseStat,
    this.statName,
    this.pokemonName,
  });
}
