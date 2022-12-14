// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'domain/PuzzleCombination.dart';
import 'domain/PuzzleImage.dart';
import 'domain/PuzzleLevel.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 116155010826914795),
      name: 'PuzzleCombination',
      lastPropertyId: const IdUid(1, 633005806522767345),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 633005806522767345),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 4411100918884665341),
            name: 'images',
            targetId: const IdUid(2, 6151005907880350888))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 6151005907880350888),
      name: 'PuzzleImage',
      lastPropertyId: const IdUid(2, 497339508738205218),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7644118267016718183),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 497339508738205218),
            name: 'path',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 1003760889257007289),
      name: 'PuzzleLevel',
      lastPropertyId: const IdUid(4, 7546169269742472939),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 533626021620357464),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 8843479974108140318),
            name: 'order',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7079063000563051612),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7546169269742472939),
            name: 'isMatchUp',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(2, 8848987698817841942),
            name: 'combinations',
            targetId: const IdUid(1, 116155010826914795))
      ],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(3, 1003760889257007289),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(2, 8848987698817841942),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    PuzzleCombination: EntityDefinition<PuzzleCombination>(
        model: _entities[0],
        toOneRelations: (PuzzleCombination object) => [],
        toManyRelations: (PuzzleCombination object) =>
            {RelInfo<PuzzleCombination>.toMany(1, object.id): object.images},
        getId: (PuzzleCombination object) => object.id,
        setId: (PuzzleCombination object, int id) {
          object.id = id;
        },
        objectToFB: (PuzzleCombination object, fb.Builder fbb) {
          fbb.startTable(2);
          fbb.addInt64(0, object.id);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PuzzleCombination(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          InternalToManyAccess.setRelInfo(
              object.images,
              store,
              RelInfo<PuzzleCombination>.toMany(1, object.id),
              store.box<PuzzleCombination>());
          return object;
        }),
    PuzzleImage: EntityDefinition<PuzzleImage>(
        model: _entities[1],
        toOneRelations: (PuzzleImage object) => [],
        toManyRelations: (PuzzleImage object) => {},
        getId: (PuzzleImage object) => object.id,
        setId: (PuzzleImage object, int id) {
          object.id = id;
        },
        objectToFB: (PuzzleImage object, fb.Builder fbb) {
          final pathOffset = fbb.writeString(object.path);
          fbb.startTable(3);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, pathOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PuzzleImage(
              const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        }),
    PuzzleLevel: EntityDefinition<PuzzleLevel>(
        model: _entities[2],
        toOneRelations: (PuzzleLevel object) => [],
        toManyRelations: (PuzzleLevel object) =>
            {RelInfo<PuzzleLevel>.toMany(2, object.id): object.combinations},
        getId: (PuzzleLevel object) => object.id,
        setId: (PuzzleLevel object, int id) {
          object.id = id;
        },
        objectToFB: (PuzzleLevel object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.order);
          fbb.addOffset(2, nameOffset);
          fbb.addBool(3, object.isMatchUp);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = PuzzleLevel(
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              order: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
              isMatchUp: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 10, false),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));
          InternalToManyAccess.setRelInfo(
              object.combinations,
              store,
              RelInfo<PuzzleLevel>.toMany(2, object.id),
              store.box<PuzzleLevel>());
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [PuzzleCombination] entity fields to define ObjectBox queries.
class PuzzleCombination_ {
  /// see [PuzzleCombination.id]
  static final id =
      QueryIntegerProperty<PuzzleCombination>(_entities[0].properties[0]);

  /// see [PuzzleCombination.images]
  static final images = QueryRelationToMany<PuzzleCombination, PuzzleImage>(
      _entities[0].relations[0]);
}

/// [PuzzleImage] entity fields to define ObjectBox queries.
class PuzzleImage_ {
  /// see [PuzzleImage.id]
  static final id =
      QueryIntegerProperty<PuzzleImage>(_entities[1].properties[0]);

  /// see [PuzzleImage.path]
  static final path =
      QueryStringProperty<PuzzleImage>(_entities[1].properties[1]);
}

/// [PuzzleLevel] entity fields to define ObjectBox queries.
class PuzzleLevel_ {
  /// see [PuzzleLevel.id]
  static final id =
      QueryIntegerProperty<PuzzleLevel>(_entities[2].properties[0]);

  /// see [PuzzleLevel.order]
  static final order =
      QueryIntegerProperty<PuzzleLevel>(_entities[2].properties[1]);

  /// see [PuzzleLevel.name]
  static final name =
      QueryStringProperty<PuzzleLevel>(_entities[2].properties[2]);

  /// see [PuzzleLevel.isMatchUp]
  static final isMatchUp =
      QueryBooleanProperty<PuzzleLevel>(_entities[2].properties[3]);

  /// see [PuzzleLevel.combinations]
  static final combinations =
      QueryRelationToMany<PuzzleLevel, PuzzleCombination>(
          _entities[2].relations[0]);
}
