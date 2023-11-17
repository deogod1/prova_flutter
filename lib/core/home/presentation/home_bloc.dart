import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';
import 'package:prova_flutter/core/home/domain/usecases/delete_text_use_case.dart';
import 'package:prova_flutter/core/home/domain/usecases/load_all_text_use_case.dart';
import 'package:prova_flutter/core/home/domain/usecases/save_text_use_case.dart';
import 'package:prova_flutter/core/home/presentation/home_events.dart';

class HomeBloC {
  final DeleteTextUseCase deleteTextUseCase;
  final SaveTextUseCase saveTextUseCase;
  final LoadAllTextsUseCase loadAllTextsUseCase;
  final entities = ObservableList<TextEntity>();

  HomeBloC({
    required this.deleteTextUseCase,
    required this.saveTextUseCase,
    required this.loadAllTextsUseCase,
  }) {
    textDataStream.listen((event) {
      if (event is HomeLoadAllTextsEvent) {
        _handleLoadAllTexts();
      }
      if (event is HomeSaveTextEvent) {
        _handleSaveText(event.entity);
      }
      if (event is HomeDeleteTextEvent) {
        _handleDeleteText(event.entity);
      }
    });
  }

  final _textData = StreamController<HomeEvent>();
  final _textListData = StreamController<List<TextEntity>>();
  final _textEdit = StreamController<TextEntity?>();
  Sink get textDataSink => _textData.sink;
  Stream<HomeEvent> get textDataStream => _textData.stream;
  Sink get textListDataSink => _textListData.sink;
  Stream<List<TextEntity>> get textListDataStream => _textListData.stream;
  Sink get textEditDataSink => _textEdit.sink;
  Stream<TextEntity?> get textEditDataStream => _textEdit.stream;

  void _handleLoadAllTexts() async {
    final result = await loadAllTextsUseCase.call();
    result.fold((l) => null, (r) {
      entities.clear();
      entities.addAll(r);
    });
  }

  void _handleSaveText(TextEntity entity) async {
    final result = await saveTextUseCase.call(entity: entity);
    result.fold((l) => null, (r) => _handleLoadAllTexts());
  }

  void _handleDeleteText(TextEntity entity) async {
    final result = await deleteTextUseCase.call(entity: entity);
    result.fold((l) => null, (r) => _handleLoadAllTexts());
  }
}
