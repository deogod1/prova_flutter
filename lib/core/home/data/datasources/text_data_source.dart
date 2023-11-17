import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';

abstract class TextDataSource {
  Future<List<TextEntity>> loadAll();
  Future<void> save({required TextEntity entity});
  Future<void> delete({required TextEntity entity});
}
