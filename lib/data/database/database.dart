import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:pokedex_flutter/data/database/entities/pokemon_details_entity.dart';
import 'package:pokedex_flutter/data/database/entities/pokemon_entity.dart';
import 'package:pokedex_flutter/data/database/entities/stats_entity.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Pokemon,
  PokemonDetails,
  Stats,
])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
