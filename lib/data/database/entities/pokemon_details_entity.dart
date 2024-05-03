import 'package:drift/drift.dart';
import 'package:pokedex_flutter/data/database/entities/stats_entity.dart';

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
}
