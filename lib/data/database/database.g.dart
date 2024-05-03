// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PokemonTable extends Pokemon
    with TableInfo<$PokemonTable, PokemonEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [name, url, imageUrl, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon';
  @override
  VerificationContext validateIntegrity(Insertable<PokemonEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  PokemonEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonEntity(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order']),
    );
  }

  @override
  $PokemonTable createAlias(String alias) {
    return $PokemonTable(attachedDatabase, alias);
  }
}

class PokemonCompanion extends UpdateCompanion<PokemonEntity> {
  final Value<String> name;
  final Value<String?> url;
  final Value<String?> imageUrl;
  final Value<int?> order;
  final Value<int> rowid;
  const PokemonCompanion({
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonCompanion.insert({
    required String name,
    this.url = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PokemonEntity> custom({
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? imageUrl,
    Expression<int>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (imageUrl != null) 'image_url': imageUrl,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonCompanion copyWith(
      {Value<String>? name,
      Value<String?>? url,
      Value<String?>? imageUrl,
      Value<int?>? order,
      Value<int>? rowid}) {
    return PokemonCompanion(
      name: name ?? this.name,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      order: order ?? this.order,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonCompanion(')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('order: $order, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PokemonDetailsTable extends PokemonDetails
    with TableInfo<$PokemonDetailsTable, PokemonDetailsEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PokemonDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [name, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pokemon_details';
  @override
  VerificationContext validateIntegrity(
      Insertable<PokemonDetailsEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  PokemonDetailsEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PokemonDetailsEntity(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight']),
    );
  }

  @override
  $PokemonDetailsTable createAlias(String alias) {
    return $PokemonDetailsTable(attachedDatabase, alias);
  }
}

class PokemonDetailsCompanion extends UpdateCompanion<PokemonDetailsEntity> {
  final Value<String> name;
  final Value<int?> weight;
  final Value<int> rowid;
  const PokemonDetailsCompanion({
    this.name = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PokemonDetailsCompanion.insert({
    required String name,
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PokemonDetailsEntity> custom({
    Expression<String>? name,
    Expression<int>? weight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (weight != null) 'weight': weight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PokemonDetailsCompanion copyWith(
      {Value<String>? name, Value<int?>? weight, Value<int>? rowid}) {
    return PokemonDetailsCompanion(
      name: name ?? this.name,
      weight: weight ?? this.weight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PokemonDetailsCompanion(')
          ..write('name: $name, ')
          ..write('weight: $weight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StatsTable extends Stats with TableInfo<$StatsTable, StatsEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _baseStatMeta =
      const VerificationMeta('baseStat');
  @override
  late final GeneratedColumn<int> baseStat = GeneratedColumn<int>(
      'base_stat', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _statNameMeta =
      const VerificationMeta('statName');
  @override
  late final GeneratedColumn<String> statName = GeneratedColumn<String>(
      'stat_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pokemonNameMeta =
      const VerificationMeta('pokemonName');
  @override
  late final GeneratedColumn<String> pokemonName = GeneratedColumn<String>(
      'pokemon_name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES pokemon_details (name)'));
  @override
  List<GeneratedColumn> get $columns => [id, baseStat, statName, pokemonName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stats';
  @override
  VerificationContext validateIntegrity(Insertable<StatsEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('base_stat')) {
      context.handle(_baseStatMeta,
          baseStat.isAcceptableOrUnknown(data['base_stat']!, _baseStatMeta));
    }
    if (data.containsKey('stat_name')) {
      context.handle(_statNameMeta,
          statName.isAcceptableOrUnknown(data['stat_name']!, _statNameMeta));
    }
    if (data.containsKey('pokemon_name')) {
      context.handle(
          _pokemonNameMeta,
          pokemonName.isAcceptableOrUnknown(
              data['pokemon_name']!, _pokemonNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StatsEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StatsEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      baseStat: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}base_stat']),
      statName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stat_name']),
      pokemonName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pokemon_name']),
    );
  }

  @override
  $StatsTable createAlias(String alias) {
    return $StatsTable(attachedDatabase, alias);
  }
}

class StatsCompanion extends UpdateCompanion<StatsEntity> {
  final Value<int> id;
  final Value<int?> baseStat;
  final Value<String?> statName;
  final Value<String?> pokemonName;
  const StatsCompanion({
    this.id = const Value.absent(),
    this.baseStat = const Value.absent(),
    this.statName = const Value.absent(),
    this.pokemonName = const Value.absent(),
  });
  StatsCompanion.insert({
    this.id = const Value.absent(),
    this.baseStat = const Value.absent(),
    this.statName = const Value.absent(),
    this.pokemonName = const Value.absent(),
  });
  static Insertable<StatsEntity> custom({
    Expression<int>? id,
    Expression<int>? baseStat,
    Expression<String>? statName,
    Expression<String>? pokemonName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (baseStat != null) 'base_stat': baseStat,
      if (statName != null) 'stat_name': statName,
      if (pokemonName != null) 'pokemon_name': pokemonName,
    });
  }

  StatsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? baseStat,
      Value<String?>? statName,
      Value<String?>? pokemonName}) {
    return StatsCompanion(
      id: id ?? this.id,
      baseStat: baseStat ?? this.baseStat,
      statName: statName ?? this.statName,
      pokemonName: pokemonName ?? this.pokemonName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (baseStat.present) {
      map['base_stat'] = Variable<int>(baseStat.value);
    }
    if (statName.present) {
      map['stat_name'] = Variable<String>(statName.value);
    }
    if (pokemonName.present) {
      map['pokemon_name'] = Variable<String>(pokemonName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatsCompanion(')
          ..write('id: $id, ')
          ..write('baseStat: $baseStat, ')
          ..write('statName: $statName, ')
          ..write('pokemonName: $pokemonName')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $PokemonTable pokemon = $PokemonTable(this);
  late final $PokemonDetailsTable pokemonDetails = $PokemonDetailsTable(this);
  late final $StatsTable stats = $StatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [pokemon, pokemonDetails, stats];
}
