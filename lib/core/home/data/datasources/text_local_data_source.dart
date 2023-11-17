import 'package:prova_flutter/core/home/data/datasources/text_data_source.dart';
import 'package:prova_flutter/core/home/data/mapper/text_entity_mapper.dart';
import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TextLocalDataSource extends TextDataSource {
  final TextEntityMapper mapper;

  TextLocalDataSource({required this.mapper});

  @override
  Future<void> delete({required TextEntity entity}) async {
    final prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('textlist');
    if (json == null) {
      return;
    }
    List<dynamic> jsonList = jsonDecode(json);
    final list = jsonList.map((e) => mapper.fromMap(e)).toList();
    list.removeWhere((element) => element.id == entity.id);
    prefs.setString(
        'textlist', jsonEncode(list.map((e) => mapper.toMap(e)).toList()));
  }

  @override
  Future<List<TextEntity>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('textlist');
    if (json == null) {
      return [];
    }
    List<dynamic> list = jsonDecode(json);
    return list.map((e) => mapper.fromMap(e)).toList();
  }

  @override
  Future<void> save({required TextEntity entity}) async {
    final prefs = await SharedPreferences.getInstance();
    String? json = prefs.getString('textlist');
    late List<dynamic> jsonList;
    if (json == null) {
      jsonList = [];
    } else {
      jsonList = jsonDecode(json);
    }
    final listText = jsonList.map((e) => mapper.fromMap(e)).toList();
    final index = listText.indexWhere((element) => element.id == entity.id);
    if (index == -1) {
      listText.add(entity);
    } else {
      listText.removeWhere((element) => element.id == entity.id);
      listText.insert(index, entity);
    }
    prefs.setString(
        'textlist', jsonEncode(listText.map((e) => mapper.toMap(e)).toList()));
  }
}
