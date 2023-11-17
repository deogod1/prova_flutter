import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';

class TextEntityMapper {
  TextEntity fromMap(Map<String, dynamic> map) {
    return TextEntity(
      id: map['id'],
      text: map['text'],
    );
  }

  Map<String, dynamic> toMap(TextEntity entity) {
    return {
      'id': entity.id,
      'text': entity.text,
    };
  }
}
