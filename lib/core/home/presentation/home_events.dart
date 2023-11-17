import 'package:prova_flutter/core/home/domain/entities/text_entity.dart';

abstract class HomeEvent {}

class HomeSaveTextEvent extends HomeEvent {
  final TextEntity entity;

  HomeSaveTextEvent({required this.entity});
}

class HomeDeleteTextEvent extends HomeEvent {
  final TextEntity entity;

  HomeDeleteTextEvent({required this.entity});
}

class HomeLoadAllTextsEvent extends HomeEvent {}

class HomeEditTextEvent extends HomeEvent {
  final TextEntity entity;

  HomeEditTextEvent({required this.entity});
}
